import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mime/mime.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_web/screen/success.dart';
import 'package:expense_tracker_web/util/google_drive.dart';
import 'package:expense_tracker_web/util/google_sheet.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';
import 'package:expense_tracker_web/widgets/dialog_body.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:provider/provider.dart';
import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';
import 'package:expense_tracker_web/l10n/app_localizations_extension.dart';
import 'package:expense_tracker_web/util/gemini_helper.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  // Group related controllers together
  final _formKey = GlobalKey<FormState>();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController receiptDateController =
      TextEditingController(text: DateFormat('d MMM y').format(DateTime.now()));

  // Group related state variables together
  String? itemName;
  String? category;
  Currency? currency;
  double? price;
  String? submitDate;
  DateTime? receiptDate = DateTime.now();
  Uint8List? receiptImage;
  bool uploadToGDrive = false;
  bool isProcessingGemini = false;
  String? geminiError;

  // Move categories to a separate constant or utility class
  static const Map<String, List<String>> categories = {
    'Housing': [
      'Mortgage or rent',
      'Property taxes',
      'Household repairs',
      'HOA fees',
    ],
    'Transportation': [
      'Public transportation',
      'Taxi/Uber',
      'Prepaid card',
      'Car payment',
      'Car warranty',
      'Gas',
      'Tires',
      'Maintenance and oil changes',
      'Parking fees',
      'Repairs',
      'Registration and DMV Fees',
    ],
    'Food': [
      'Groceries',
      'Restaurants',
      'Takeaway',
      'From Friend',
      'Street food',
      'Delivery',
      'Pet food',
    ],
    'Utilities': [
      'Electricity',
      'Water',
      'Garbage',
      'Phones',
      'Cable',
      'Internet',
    ],
    'Clothing': [
      'Adults\' clothing',
      'Adults\' shoes',
      'Children\'s clothing',
      'Children\'s shoes',
    ],
    'Medical/Healthcare': [
      'Primary care',
      'Dental care',
      'Specialty care',
      'Urgent care',
      'Medications',
      'Medical devices',
    ],
    'Insurance': [
      'Health insurance',
      'Homeowner\'s or renter\'s insurance',
      'Home warranty or protection plan',
      'Auto insurance',
      'Life insurance',
      'Disability insurance',
    ],
    'Household Items/Supplies': [
      'Toiletries',
      'Laundry detergent',
      'Dishwasher detergent',
      'Cleaning supplies',
      'Tools',
    ],
    'Personal': [
      'Gym memberships',
      'Haircuts',
      'Salon services',
      'Cosmetics',
      'Babysitter',
      'Subscriptions',
    ],
    'Education': [
      'Children\'s college',
      'Your college',
      'School supplies',
      'Books',
      'Tuition',
      'Exams',
    ],
    'Savings': [
      'Emergency fund',
      'Big purchases',
      'Other savings',
    ],
    'Gifts/Donations': [
      'Birthday',
      'Anniversary',
      'Wedding',
      'Christmas',
      'Special occasion',
      'Charities',
      'Souvenir',
    ],
    'Entertainment': [
      'Alcohol and/or bars',
      'Games',
      'Movies',
      'Concerts',
      'Vacations',
      'Subscriptions (Netflix, Amazon, Hulu, etc.)',
      'Entertainment',
    ],
    'Debt': [
      'Credit card',
      'Personal loans',
      'Student loans',
      'Other debt payments',
    ],
    'Other': [
      'Other expenses',
    ],
  };

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingProvider>(context, listen: false);
    uploadToGDrive = settings.uploadToGDrive;

    // Set default currency if available
    if (settings.currency != null) {
      currency = CurrencyServiceCustom.findByCode(settings.currency!);
    }
  }

  @override
  void dispose() {
    itemNameController.dispose();
    priceController.dispose();
    receiptDateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      showDialog(
        context: context,
        builder: (context) => LoadingDialogBody(
          text: AppLocalizations.of(context)!.submittingExpenseForm,
        ),
      );

      DateTime now = DateTime.now();
      submitDate = DateFormat('d MMM y').format(now);
      String receiptDateString = DateFormat('d MMM y').format(receiptDate!);
      String uploadFilename =
          (uploadToGDrive) ? '$itemName $receiptDateString' : '';

      // Create a list of futures to execute
      List<Future> futures = [
        _addRecordToGoogleSheet(submitDate!, uploadFilename)
      ];

      // Only add file upload if uploadToGDrive is true and we have an image
      if (uploadToGDrive && receiptImage != null) {
        futures.add(_uploadImageToGoogleDrive(uploadFilename));
      }

      Future.wait(futures).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => SuccessScreen(
                    message: AppLocalizations.of(context)!
                        .expenseSubmittedSuccessfully)),
            (Route<dynamic> route) => false);
      }).catchError((error) {
        Navigator.of(context).pop();
        if (kDebugMode) {
          print(error);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error submitting expense form'),
          ),
        );
      });
    }
  }

  Future<sheets.AppendValuesResponse> _addRecordToGoogleSheet(
      String date, String receiptFilename) {
    return GoogleSheetHelper.insert(
        itemName: itemName!,
        category: category!,
        currency: currency!.code,
        amount: price!.toString(),
        submitDate: date,
        receiptDate: receiptDate!,
        filename: receiptFilename);
  }

  Future<Map<String, dynamic>> _uploadImageToGoogleDrive(
      String uploadFilename) {
    return GoogleDriveHelper.upload(
        fileData: receiptImage!, filename: uploadFilename);
  }

  void pickDate({required void Function(DateTime) callback}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        callback(value);
      }
    });
  }

  Future<void> _processWithGemini(String filename, Uint8List imageData) async {
    final settings = Provider.of<SettingProvider>(context, listen: false);
    if (!(settings.geminiKey.isNotEmpty && settings.geminiModel.isNotEmpty)) {
      return;
    }

    setState(() {
      isProcessingGemini = true;
      geminiError = null;
    });

    try {
      String mime = lookupMimeType(filename) ?? 'image/jpeg';
      final prompt = _buildGeminiPrompt();
      final response =
          await _getGeminiResponse(mime, imageData, prompt, settings);

      if (response?.text == null) {
        FirebaseAnalytics.instance
            .logEvent(name: 'receipt_gemini_request', parameters: {
          'status': "empty",
        });
        setState(() {
          geminiError = 'Failed to process receipt with AI';
        });
        return;
      }

      final json = jsonDecode(response!.text!);
      FirebaseAnalytics.instance
          .logEvent(name: 'receipt_gemini_request', parameters: {
        'status': "succuss",
      });
      _updateFormWithGeminiResponse(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error processing with Gemini: $e');
      }
      FirebaseAnalytics.instance
          .logEvent(name: 'receipt_gemini_request', parameters: {
        'status': "failed",
      });
      setState(() {
        geminiError = 'Error processing receipt: ${e.toString()}';
      });
    } finally {
      setState(() {
        isProcessingGemini = false;
      });
    }
  }

  String _buildGeminiPrompt() {
    final todayDate = DateFormat('d MMM y').format(DateTime.now());
    return '''
Retrieve the following information and return in strict json format without other text. If the information not found, fill with empty string.
1. Item name (key: "item_name", type: string)  // It could be general item name, or the place is the item bought
2. Category (key: "category", type: string)    // The category must be one of the following [${categories.entries.expand((entry) {
      return entry.value;
    }).join(', ')}]
3. Price (key: "price", type : number) // The price must be a number.  If there is multiple items, the price must be the total price
4. Currency Code (key: "currency", type: string) // The currency code must be one of the following [${CurrencyServiceCustom.getAllCurrencies().join(', ')}]. Analyze the currency by the location of the receipt.  If there is no information, return as ${Provider.of<SettingProvider>(context, listen: false).currency}.
5. Receipt Date (key: "receipt_date", format: d MMM YYYY) // The receipt date must be in the format of "d MMM YYYY"
Note: Today date is $todayDate, so the receipt date must be today or before today.

Strict json format:
{
  "item_name": "<item name>",
  "category": "<category>",
  "price": "<price>",
  "currency": "<currency code>",
  "receipt_date": "<receipt date>"
}
''';
  }

  Future<GenerateContentResponse?> _getGeminiResponse(String mime,
      Uint8List imageData, String prompt, SettingProvider settings) {
    final dataPart = InlineDataPart(mime, imageData);
    final parts = [TextPart(prompt), dataPart];

    final model = getFirebaseAI().generativeModel(
        model: settings.geminiModel,
        generationConfig:
            GenerationConfig(responseMimeType: 'application/json'));

    return model.generateContent([Content.multi(parts)]);
  }

  void _updateFormWithGeminiResponse(Map<String, dynamic> json) {
    setState(() {
      if (json['item_name']?.isNotEmpty == true) {
        itemNameController.text = json['item_name'];
      }

      if (json['category']?.isNotEmpty == true) {
        final categoryValue = json['category'];
        if (categories.entries
            .any((entry) => entry.value.contains(categoryValue))) {
          category = categoryValue;
        }
      }

      if (json['price'] != null) {
        priceController.text = json['price'].toString();
      }

      if (json['currency']?.isNotEmpty == true) {
        currency = CurrencyServiceCustom.findByCode(json['currency']);
      }

      if (json['receipt_date']?.isNotEmpty == true) {
        _updateReceiptDate(json['receipt_date']);
      }
    });
  }

  void _updateReceiptDate(String dateStr) {
    try {
      final parsedDate = DateFormat('d MMM y').parse(dateStr);
      receiptDate = parsedDate;
      receiptDateController.text = DateFormat('d MMM y').format(parsedDate);
    } catch (e) {
      if (kDebugMode) {
        print('Invalid date format: $dateStr');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: AppLocalizations.of(context)!.expenseForm,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 700),
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.expenseForm,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      // Update FormField validation
                      FormField<Uint8List>(
                        builder: (state) => Column(
                          children: [
                            ImageSelector(
                              state: state,
                              onChange: (filename, file) {
                                filename = filename;
                                receiptImage = file;
                                if (file != null && filename != null) {
                                  _processWithGemini(filename, file);
                                }
                              },
                            ),
                            if (isProcessingGemini) ...[
                              const SizedBox(height: 10),
                              const CircularProgressIndicator(),
                              const SizedBox(height: 5),
                              Text(AppLocalizations.of(context)!
                                  .processingReceiptWithAI),
                            ],
                            if (geminiError != null) ...[
                              const SizedBox(height: 10),
                              Text(
                                geminiError!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ],
                          ],
                        ),
                        validator: (value) {
                          if (uploadToGDrive &&
                              (receiptImage == null || receiptImage!.isEmpty)) {
                            return AppLocalizations.of(context)!
                                .pleaseSelectReceiptImage;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: receiptDateController,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterReceiptDate;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.date,
                          prefixIcon: IconButton(
                            onPressed: () {
                              pickDate(callback: (value) {
                                receiptDate = value;
                                receiptDateController.text =
                                    DateFormat('d MMM y').format(value);
                              });
                            },
                            icon: const Icon(Icons.calendar_month_outlined),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              pickDate(callback: (value) {
                                receiptDate = value;
                                receiptDateController.text =
                                    DateFormat('d MMM y').format(value);
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: itemNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.fact_check),
                          border: const OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.itemName,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterItemName;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          itemName = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.category),
                            border: const OutlineInputBorder(),
                            labelText:
                                AppLocalizations.of(context)!.categoryLabel,
                          ),
                          value: category,
                          items: categories.entries.expand((entry) {
                            return [
                              DropdownMenuItem<String>(
                                enabled: false,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .getCategoryLocalization(entry.key),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...entry.value
                                  .map((subCategory) => DropdownMenuItem(
                                        value: subCategory,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .getCategorySubcategoryLocalization(
                                                    entry.key, subCategory),
                                          ),
                                        ),
                                      )),
                            ];
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseSelectCategory;
                            }
                            return null;
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue;
                            });
                          },
                          onSaved: (newValue) {
                            category = newValue;
                          },
                        );
                      }),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: priceController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.money),
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)!.price +
                                    ' ${(currency == null) ? "" : "(${currency!.symbol})"}',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text.replaceAll(',', '.'),
                                  ),
                                ),
                              ],
                              validator: (value) {
                                if (currency == null) {
                                  return AppLocalizations.of(context)!
                                      .pleaseSelectCurrency;
                                }
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterPrice;
                                }
                                if (double.tryParse(value) == null) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterValidPrice;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                price = double.parse(value!);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 54,
                            child: InkWell(
                              onTap: () {
                                CurrencyServiceCustom.pickCurrency(
                                  context,
                                  onSelect: (Currency c) => setState(() {
                                    currency = c;
                                  }),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                      (currency != null)
                                          ? "${currency?.code} ${currency?.symbol}"
                                          : AppLocalizations.of(context)!
                                              .chooseCurrency,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Add upload toggle before the image selector
                      SwitchListTile(
                        title: Text(AppLocalizations.of(context)!
                            .uploadReceiptToGoogleDrive),
                        value: uploadToGDrive,
                        onChanged: (bool value) {
                          setState(() {
                            uploadToGDrive = value;
                          });
                          Provider.of<SettingProvider>(context, listen: false)
                              .updateUploadToGDrive(value);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FilledButton(
                        onPressed: _submitForm,
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key, required this.onChange, this.state});
  final FormFieldState? state;
  final void Function(String?, Uint8List?) onChange;
  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  bool loading = false;
  Uint8List? bytes;
  String? filename;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            FilePicker.platform.pickFiles(type: FileType.image).then((data) {
              setState(() {
                bytes = data?.files.first.bytes;
                filename = data?.files.first.name;
                widget.onChange(filename, bytes);
              });
            });
          },
          child: Text(AppLocalizations.of(context)!.pickTheReceipt),
        ),
        (widget.state != null && widget.state!.hasError)
            ? Text(widget.state!.errorText ?? "Invalid field",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ))
            : (bytes == null)
                ? Text(AppLocalizations.of(context)!.noFileSelected)
                : Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.memory(bytes!),
                      ),
                      (filename == null)
                          ? Text(AppLocalizations.of(context)!.noFileSelected)
                          : Text('filename: $filename'),
                    ],
                  ),
      ],
    );
  }
}
