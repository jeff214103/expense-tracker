import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';
import 'package:expense_tracker_web/widgets/dialog_body.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:url_launcher/link.dart';
import 'package:expense_tracker_web/provider/setting_provider.dart';

class SettingScreen extends StatefulWidget {
  final bool isFirstTime;
  const SettingScreen({super.key, this.isFirstTime = false});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Locale> _availableLanguages = AppLocalizations.supportedLocales;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showActionWaitingDialog({Future<void> Function()? callback}) async {
    // Show the dialog and wait for it to be displayed
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialogBody(
        text: AppLocalizations.of(context)!.actionInProgress,
      ),
    );

    if (callback != null) {
      await callback();
    }
    Navigator.of(context).pop();
  }

  Future<void> _showNumberInputDialog({
    required BuildContext context,
    required String title,
    String? hintText,
    required double currentValue,
    required Function(double) onSave,
  }) async {
    final controller = TextEditingController(text: currentValue.toString());
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${AppLocalizations.of(context)!.update} $title',
            style: Theme.of(context).textTheme.titleMedium),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: title,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterValue;
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                  }
                  return null;
                },
              ),
              if (hintText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    hintText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final value = double.parse(controller.text);
                Navigator.of(context).pop();
                _showActionWaitingDialog(callback: () => onSave(value));
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Future<void> _showTextInputDialog(
    BuildContext context,
    String title,
    String currentValue,
    Function(String) onSave,
  ) async {
    final controller = TextEditingController(text: currentValue);
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.enterApiKey,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.pleaseEnterValidApiKey;
              }
              return null;
            },
            obscureText: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                _showActionWaitingDialog(
                    callback: () => onSave(controller.text.trim()));
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  void _showModelSelectionDialog(
    BuildContext context,
    String currentModel,
    Function(String) onModelSelect,
  ) {
    final models =
        Provider.of<SettingProvider>(context, listen: false).availableModels;
    if (!models.contains(currentModel)) {
      currentModel = models.first;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectGeminiModel),
        content: RadioGroup<String>(
          groupValue: currentModel,
          onChanged: (value) {
            if (value != null) {
              Navigator.of(context).pop();
              _showActionWaitingDialog(callback: () => onModelSelect(value));
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: models.map((model) {
            return ListTile(
              title: Text(model),
              leading: Radio<String>(toggleable: true, value: model),
            );
          }).toList()),
        ),
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _availableLanguages.map((locale) {
            return RadioListTile<Locale>(
              title: Text(_getLanguageName(locale)),
              value: locale,
              groupValue: Localizations.localeOf(context),
              onChanged: (value) {
                if (value != null) {
                  // Update app language
                  _updateLanguage(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      default:
        return locale.languageCode;
    }
  }

  void _updateLanguage(Locale locale) {
    Provider.of<SettingProvider>(context, listen: false)
        .updateLanguage(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settings, child) => CustomScafold(
        title: AppLocalizations.of(context)!.settings,
        leading: (widget.isFirstTime) ? const SizedBox() : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildGeneralSettingsCard(context, settings),
              const SizedBox(height: 16),
              if (settings.currency != null)
                _buildAIAssistanceCard(context, settings),
              const SizedBox(height: 16),
              if (settings.currency != null && widget.isFirstTime)
                _buildGetStartedButton(context),
              if (settings.currency != null && !widget.isFirstTime)
                _buildExchangeRatesCard(context, settings),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildGeneralSettingsCard(
      BuildContext context, SettingProvider settings) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.general.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            if (settings.currency == null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.currencySelectionHint,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            _buildSettingListTile(
              context,
              title: AppLocalizations.of(context)!.currency,
              subtitle:
                  settings.currency ?? AppLocalizations.of(context)!.notSet,
              description: AppLocalizations.of(context)!.currencyDescription,
              onTap: () {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) {
                    _showActionWaitingDialog(
                        callback: () => settings.updateCurrency(currency.code));
                  },
                );
              },
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: AppLocalizations.of(context)!.income,
              subtitle: settings.income.toString(),
              description: AppLocalizations.of(context)!.incomeDescription(
                  settings.currency ?? AppLocalizations.of(context)!.notSet),
              onTap: () => _showNumberInputDialog(
                context: context,
                title: AppLocalizations.of(context)!.income,
                hintText: AppLocalizations.of(context)!.incomeHint(
                    settings.currency ?? AppLocalizations.of(context)!.notSet),
                currentValue: settings.income,
                onSave: (value) => settings.updateIncome(value),
              ),
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: AppLocalizations.of(context)!.regularCost,
              subtitle: settings.regularCost.toString(),
              description: AppLocalizations.of(context)!.regularCostDescription(
                  settings.currency ?? AppLocalizations.of(context)!.notSet),
              onTap: () => _showNumberInputDialog(
                context: context,
                title: AppLocalizations.of(context)!.regularCost,
                hintText: AppLocalizations.of(context)!.regularCostHint(
                    settings.currency ?? AppLocalizations.of(context)!.notSet),
                currentValue: settings.regularCost,
                onSave: (value) => settings.updateRegularCost(value),
              ),
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: AppLocalizations.of(context)!.language,
              subtitle: _getLanguageName(Localizations.localeOf(context)),
              description: AppLocalizations.of(context)!.languageDescription,
              onTap: () => _showLanguageSelectionDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildAIAssistanceCard(BuildContext context, SettingProvider settings) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.aiAssistance,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.geminiApiKeyDescription,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.geminiApiKeyAgreement,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Center(
            //   child: Link(
            //     uri: Uri.https('makersuite.google.com', '/app/apikey'),
            //     target: LinkTarget.blank,
            //     builder: (context, followLink) => ElevatedButton.icon(
            //       onPressed: followLink,
            //       icon: const Icon(Icons.open_in_new),
            //       label: Text(AppLocalizations.of(context)!.getAnApiKey),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16),
            // _buildSettingListTile(
            //   context,
            //   title: AppLocalizations.of(context)!.geminiApiKey,
            //   subtitle: settings.geminiKey.isEmpty
            //       ? AppLocalizations.of(context)!.notSet
            //       : '****',
            //   description: AppLocalizations.of(context)!.geminiApiKeyConfig,
            //   onTap: () => _showTextInputDialog(
            //     context,
            //     AppLocalizations.of(context)!.geminiApiKey,
            //     settings.geminiKey,
            //     (value) async => (await settings.updateGeminiKey(value)),
            //   ),
            // ),
            // const Divider(),
            _buildSettingListTile(
              context,
              title: AppLocalizations.of(context)!.geminiModel,
              subtitle: settings.geminiModel.isEmpty
                  ? AppLocalizations.of(context)!.notSet
                  : settings.geminiModel,
              description: AppLocalizations.of(context)!.geminiModelDescription,
              onTap: () => _showModelSelectionDialog(
                context,
                settings.geminiModel,
                (value) async => (await settings.updateGeminiModel(value)),
              ),
            ),
            const SizedBox(height: 8),
            const GeminiDisclaimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingListTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Container _buildGetStartedButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      child: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.getStarted),
        ),
      ),
    );
  }

  Widget _buildExchangeRatesCard(
      BuildContext context, SettingProvider settings) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.exchangeRates,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.exchangeRatesDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: _buildExchangeRatesList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExchangeRatesList(BuildContext context) {
    final rates = CurrencyServiceCustom.exchangeRates;
    final sortedCurrencies = rates.keys
        .where((code) => rates[code] != 0.0 && rates[code] != 1.0)
        .toList()
      ..sort((a, b) => a.compareTo(b));

    return (sortedCurrencies.isEmpty)
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.noExchangeRatesAvailable,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ListView.builder(
              itemCount: sortedCurrencies.length,
              itemBuilder: (context, index) {
                final currencyCode = sortedCurrencies[index];
                final rate = rates[currencyCode];
                final currencyName =
                    CurrencyServiceCustom.findByCode(currencyCode)?.name ??
                        currencyCode;

                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        (MediaQuery.of(context).size.width > 800)
                            ? "$currencyCode - $currencyName"
                            : currencyCode,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      (MediaQuery.of(context).size.width < 800)
                          ? Tooltip(
                              message: currencyName,
                              child: Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  subtitle: Text(
                    rate?.toStringAsFixed(4) ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                );
              },
            ),
          );
  }
}

class GeminiDisclaimer extends StatelessWidget {
  const GeminiDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        AppLocalizations.of(context)!.geminiDisclaimer,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontStyle: FontStyle.italic,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
