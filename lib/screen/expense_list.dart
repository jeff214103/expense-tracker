import 'dart:async';

import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/util/google_drive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_web/util/google_sheet.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';
import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:expense_tracker_web/models/expense_record.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList>
    with SingleTickerProviderStateMixin {
  String? selectedSheet;
  List<String> sheetsNames = [];
  List<ExpenseRecord>? expenseData;
  Map<String, double> categorySums = {};
  double totalExpense = 0;
  bool isLoading = false;
  String? selectedCurrency;
  Map<String, int> currencyFrequency = {};
  String? _selectedCategory;

  // Error handling
  String? errorMessage;

  // Performance & Accessibility
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
    selectedCurrency = settingProvider.currency;
    _loadSheets();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadSheets() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final sheets = await GoogleSheetHelper.getSpreadsheets();
      if (sheets.isNotEmpty) {
        sheetsNames = sheets;
        setState(() => selectedSheet = sheets.first);
        await _loadExpenseData(selectedSheet!);
      } else {
        setState(() => errorMessage = 'No spreadsheets available');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load spreadsheets: ${e.toString()}';
        _animationController.forward();
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadExpenseData(String sheetTitle) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      _selectedCategory = null;
    });

    try {
      final data = await GoogleSheetHelper.getSheetData(sheetTitle);
      setState(() {
        expenseData = data;
        _calculateCategorySums();
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load expense data: ${e.toString()}';
        _animationController.forward();
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _calculateCategorySums() {
    categorySums.clear();
    totalExpense = 0;
    currencyFrequency.clear();

    if (expenseData == null || expenseData!.isEmpty) {
      setState(() => errorMessage = 'No expense records found');
      return;
    }

    // Currency and category sum calculation logic remains the same
    for (var record in expenseData!) {
      String currency = record.currency.trim();
      currencyFrequency[currency] = (currencyFrequency[currency] ?? 0) + 1;
    }

    if (currencyFrequency.isNotEmpty && selectedCurrency == null) {
      selectedCurrency = currencyFrequency.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }

    for (var record in expenseData!) {
      String category = record.category.split('/')[0].trim();
      double amount;
      String sourceCurrency;

      if (record.finalAmount.isNotEmpty &&
          record.finalAmount != record.amount) {
        amount = double.tryParse(record.finalAmount) ?? 0;
        sourceCurrency =
            Provider.of<SettingProvider>(context, listen: false).currency ??
                "USD";
      } else {
        amount = double.tryParse(record.amount) ?? 0;
        sourceCurrency = record.currency.trim();
      }

      if (sourceCurrency != selectedCurrency) {
        amount = CurrencyServiceCustom.convert(
          amount,
          sourceCurrency,
          selectedCurrency!,
        );
      }

      categorySums[category] = (categorySums[category] ?? 0.0) + amount;
      totalExpense += amount;
    }
  }

  void _showCurrencyPicker() {
    CurrencyServiceCustom.pickCurrency(context, onSelect: (currency) {
      setState(() {
        selectedCurrency = currency.code;
        _calculateCategorySums();
      });
    });
  }

  Widget _buildErrorNotification() {
    return errorMessage != null
        ? Semantics(
            label: 'Error notification',
            hint: 'An error occurred while loading data',
            child: Container(
              width: double.infinity,
              color: Colors.red.shade100,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      _animationController.reverse();
                      setState(() => errorMessage = null);
                    },
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // Add this to check if we're on a mobile screen
    final isMobileScreen = MediaQuery.of(context).size.width < 768;

    return CustomScafold(
      title: 'Expense List',
      child: Column(
        children: [
          _buildErrorNotification(),
          if (isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return isMobileScreen
                    ? _buildMobileLayout()
                    : _buildDesktopLayout();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySummary({bool isMobile = false}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Category Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: IconButton(
              tooltip: 'Change Currency',
              icon: const Icon(Icons.currency_exchange),
              onPressed: _showCurrencyPicker,
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                // ConstrainedBox(
                //   constraints: const BoxConstraints(maxHeight: 250),
                //   child: _buildCategoryPieChart(),
                // ),
                Expanded(
                  child: _buildCategoryList(),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Expense',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalExpense.toStringAsFixed(2)} $selectedCurrency',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final isMobileScreen = MediaQuery.of(context).size.width < 768;

    // Sort category sums from largest to smallest
    final sortedCategorySums = Map.fromEntries(categorySums.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));

    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: sortedCategorySums.length,
      itemBuilder: (context, index) {
        final entry = sortedCategorySums.entries.elementAt(index);
        return ListTile(
          selected: _selectedCategory == entry.key,
          onTap: () {
            setState(() {
              // If the same category is tapped again, reset the filter
              _selectedCategory =
                  _selectedCategory == entry.key ? null : entry.key;
            });
          },
          title: Text(
            entry.key,
            overflow: TextOverflow.ellipsis,
            maxLines: isMobileScreen ? 2 : 1,
            style: TextStyle(
              fontWeight: _selectedCategory == entry.key
                  ? FontWeight.bold // Visually distinct for selected state
                  : FontWeight.normal,
            ),
          ),
          trailing: Container(
            constraints: BoxConstraints(
              maxWidth: isMobileScreen ? 120 : 200,
            ),
            child: Text(
              '${entry.value.toStringAsFixed(2)} $selectedCurrency',
              style: TextStyle(
                color: entry.value > 0
                    ? Colors.red.shade700
                    : Colors.green.shade700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryPieChart() {
    if (categorySums.isEmpty) {
      return const Center(
        child: Text(
          'No data for pie chart',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartSize = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        return Container(
          height: chartSize,
          width: chartSize,
          constraints: constraints,
          child: PieChart(
            dataMap: categorySums,
          ),
        );
      },
    );
  }

  Widget _buildExpenseList({bool isMobile = false}) {
    // Filter expenses based on the selected category
    final filteredExpenses = _selectedCategory != null
        ? expenseData
            ?.where(
                (expense) => expense.category.startsWith(_selectedCategory!))
            .toList()
        : expenseData;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildMonthSelector(),
          ),
          if (filteredExpenses == null || filteredExpenses!.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No expense records found',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else if (isMobile)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                int reverseIndex = filteredExpenses.length - index - 1;
                // Find the global index of the current filtered expense
                int globalIndex =
                    expenseData!.indexOf(filteredExpenses[reverseIndex]);
                return _buildExpenseListItem(
                    context, filteredExpenses[reverseIndex], globalIndex);
              },
            )
          else
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    int reverseIndex = filteredExpenses.length - index - 1;
                    // Find the global index of the current filtered expense
                    int globalIndex =
                        expenseData!.indexOf(filteredExpenses[reverseIndex]);

                    return _buildExpenseListItem(
                        context, filteredExpenses[reverseIndex], globalIndex);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedSheet,
      decoration: InputDecoration(
        labelText: 'Select Month${sheetsNames.isEmpty ? ' (No history)' : ''}',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_month),
      ),
      onChanged: (String? newValue) {
        if (newValue != null && selectedSheet != newValue) {
          setState(() => selectedSheet = newValue);
          _loadExpenseData(newValue);
        }
      },
      items: sheetsNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: _buildCategorySummary(isMobile: true),
          ),
          _buildExpenseList(isMobile: true),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildExpenseList(),
        ),
        Expanded(
          flex: 1,
          child: _buildCategorySummary(),
        ),
      ],
    );
  }

  Future<void> _updateFinalAmount(ExpenseRecord record, int index) async {
    final settingProvider =
        Provider.of<SettingProvider>(context, listen: false);

    // Show a dialog to input the final amount
    final updatedAmount = await showDialog<String>(
      context: context,
      builder: (context) {
        String? newAmount =
            record.finalAmount.isNotEmpty ? record.finalAmount : record.amount;

        return AlertDialog(
          title: Text(
            'Final Payment Amount in ${settingProvider.currency}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Final Amount (${settingProvider.currency})',
                  hintText: 'Enter final paid amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: TextEditingController(text: newAmount),
                onChanged: (value) => newAmount = value,
              ),
              Text(
                "Input your final payment amount in ${settingProvider.currency}, and all calcuation will be based on this amount and the setting currency.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child:
                  Text('Cancel', style: TextStyle(color: Colors.red.shade900)),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(newAmount),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (updatedAmount == null) return;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
        ),
      ),
    );

    try {
      // Attempt to update the final amount in Google Sheet
      final success = await GoogleSheetHelper.updateFinalAmount(
        sheetTitle: selectedSheet!,
        rowIndex: index,
        finalAmount: updatedAmount,
        currency: settingProvider.currency ?? 'USD',
      );

      // Close loading dialog
      Navigator.of(context).pop();

      if (success) {
        // Update local state
        setState(() {
          expenseData![index] = ExpenseRecord(
            uploadDate: expenseData![index].uploadDate,
            invoiceDate: expenseData![index].invoiceDate,
            item: expenseData![index].item,
            category: expenseData![index].category,
            currency: expenseData![index].currency,
            amount: expenseData![index].amount,
            fileName: expenseData![index].fileName,
            finalAmount: updatedAmount,
          );
          _calculateCategorySums(); // Recalculate sums with updated amount
        });

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Final amount updated successfully'),
            backgroundColor: Colors.green.shade700,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to update final amount'),
            backgroundColor: Colors.red.shade900,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show detailed error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating final amount: ${e.toString()}'),
          backgroundColor: Colors.red.shade900,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showFilePreviewModal(BuildContext context, String fileName) {
    showDialog(
      context: context,
      builder: (context) => FilePreviewDialog(fileName: fileName),
    );
  }

  Widget _buildExpenseAction(ExpenseRecord record, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (record.fileName != "")
          IconButton(
            iconSize: 16,
            color: Colors.grey.shade600,
            tooltip: 'View receipt',
            icon: const Icon(
              Icons.file_open,
            ),
            onPressed: () => _showFilePreviewModal(context, record.fileName),
          ),
        AmountText(
          expense: record,
          onPressed: () => _updateFinalAmount(record, index),
        ),
      ],
    );
  }

  Widget _buildExpenseListItem(
      BuildContext context, ExpenseRecord record, int index) {
    final isMobileScreen = MediaQuery.of(context).size.width < 768;
    final isVerySmallScreen = MediaQuery.of(context).size.width < 400;

    if (isVerySmallScreen) {
      // Compact vertical layout for very small screens
      return Semantics(
        label: 'Expense record',
        hint: 'Expense details',
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.item,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      record.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMM y').format(record.invoiceDate),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                _buildExpenseAction(record, index),
              ],
            ),
          ),
        ),
      );
    }

    // Regular layout for mobile and desktop
    return Semantics(
      label: 'Expense record',
      hint: 'Expense details',
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListTile(
          title: Text(
            record.item,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: isMobileScreen ? 2 : 1,
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  record.category,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                " (${DateFormat('d MMM y').format(record.invoiceDate)})",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          trailing: _buildExpenseAction(record, index),
        ),
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  final ExpenseRecord expense;
  final void Function()? onPressed;

  const AmountText({super.key, required this.expense, this.onPressed});

  @override
  Widget build(BuildContext context) {
    String? settingCurrency = Provider.of<SettingProvider>(context).currency;
    bool showFinalAmount = (expense.currency == settingCurrency ||
        expense.finalAmount != expense.amount);

    return Tooltip(
      message: 'Final Charge Amount',
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (expense.finalAmount != expense.amount)
                    Text(
                      '${expense.amount} ${expense.currency}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  Text(
                    (showFinalAmount)
                        ? '${expense.finalAmount} $settingCurrency'
                        : '${expense.amount} ${expense.currency}',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.edit,
              color: Colors.blue.shade700,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class FilePreviewDialog extends StatefulWidget {
  final String fileName;

  const FilePreviewDialog({super.key, required this.fileName});

  @override
  _FilePreviewDialogState createState() => _FilePreviewDialogState();
}

class _FilePreviewDialogState extends State<FilePreviewDialog> {
  Uint8List? _fileBytes;
  bool _isLoading = true;
  String? _errorMessage;
  double _scale = 1.0;
  double _previousScale = 1.0;
  ImageProvider? _imageProvider;
  Size? _originalImageSize;

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  Future<void> _loadFile() async {
    try {
      final bytes = await GoogleDriveHelper.downloadFile(widget.fileName);

      if (bytes == null) {
        // Log specific scenario for file not found
        if (kDebugMode) {
          print(
              'FilePreviewDialog: No file found with name ${widget.fileName}');
        }
        setState(() {
          _errorMessage = 'File not found';
          _isLoading = false;
        });
        return;
      }

      // Create image provider and get its size
      final imageProvider = MemoryImage(bytes);
      final completer = Completer<Size>();

      imageProvider.resolve(const ImageConfiguration()).addListener(
            ImageStreamListener(
              (ImageInfo info, bool _) {
                completer.complete(Size(
                    info.image.width.toDouble(), info.image.height.toDouble()));
              },
              onError: (exception, stackTrace) {
                completer.completeError(exception);
              },
            ),
          );

      setState(() {
        _fileBytes = bytes;
        _imageProvider = imageProvider;
      });

      _originalImageSize = await completer.future;

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      // Log the detailed error
      if (kDebugMode) {
        print(
            'FilePreviewDialog: Error loading file ${widget.fileName}: $error');
      }
      setState(() {
        _errorMessage = 'Failed to load file: ${error.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate max dialog dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxDialogWidth = screenWidth * 0.9;
    final maxDialogHeight = screenHeight * 0.8;

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            )
          else if (_errorMessage != null)
            Text(_errorMessage!)
          else if (_imageProvider != null && _originalImageSize != null)
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the best fit while maintaining aspect ratio
                  double width, height;
                  final aspectRatio =
                      _originalImageSize!.width / _originalImageSize!.height;

                  if (aspectRatio > 1) {
                    // Landscape image
                    width = min(constraints.maxWidth, maxDialogWidth);
                    height = width / aspectRatio;

                    // Adjust height if it exceeds max height
                    if (height > maxDialogHeight) {
                      height = maxDialogHeight;
                      width = height * aspectRatio;
                    }
                  } else {
                    // Portrait or square image
                    height = min(constraints.maxHeight, maxDialogHeight);
                    width = height * aspectRatio;

                    // Adjust width if it exceeds max width
                    if (width > maxDialogWidth) {
                      width = maxDialogWidth;
                      height = width / aspectRatio;
                    }
                  }

                  return SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: GestureDetector(
                        onScaleStart: (details) {
                          _previousScale = _scale;
                        },
                        onScaleUpdate: (details) {
                          setState(() {
                            _scale = _previousScale * details.scale;
                          });
                        },
                        child: InteractiveViewer(
                          maxScale: 5.0,
                          minScale: 0.5,
                          child: Image(
                            image: _imageProvider!,
                            width: width,
                            height: height,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Text('No image to display'),
          Text(
            widget.fileName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Utility method to find minimum of two values
  double min(double a, double b) => a < b ? a : b;
}
