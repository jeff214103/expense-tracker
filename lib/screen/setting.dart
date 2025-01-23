import 'package:flutter/material.dart';
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

class _SettingScreenState extends State<SettingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = false;

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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
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
        title: Text('Update $title', style: Theme.of(context).textTheme.titleMedium),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: title,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return 'Please enter a valid number';
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final value = double.parse(controller.text);
                onSave(value);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter API Key',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a valid API key';
              }
              return null;
            },
            obscureText: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSave(controller.text.trim());
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
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
    final models = ['gemini-1.5-flash', 'gemini-1.5-proa'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Gemini Model'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: models.map((model) {
            return RadioListTile<String>(
              title: Text(model),
              value: model,
              groupValue: currentModel,
              onChanged: (value) {
                if (value != null) {
                  onModelSelect(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settings, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: (widget.isFirstTime) ? const SizedBox() : null,
          elevation: 1,
          shadowColor: Theme.of(context).shadowColor,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildGeneralSettingsCard(context, settings),
                  const SizedBox(height: 16),
                  _buildAIAssistanceCard(context, settings),
                  if (settings.currency != null && widget.isFirstTime)
                    _buildGetStartedButton(context),
                ],
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Card _buildGeneralSettingsCard(BuildContext context, SettingProvider settings) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General'.toUpperCase(),
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
                  'You must choose the currency you use for your expenses. Click on this section to set it. You can always change it later.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            _buildSettingListTile(
              context,
              title: 'Currency',
              subtitle: settings.currency ?? "Not set",
              description: 'Default currency in calculations and reports',
              onTap: () {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) {
                    settings.updateCurrency(currency.code);
                  },
                );
              },
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: 'Income',
              subtitle: settings.income.toString(),
              description: 'Your monthly income. Stored only on your device.',
              onTap: () => _showNumberInputDialog(
                context: context,
                title: 'Income',
                hintText: 'Your monthly income. It will only store on your device, not used anywhere else.',
                currentValue: settings.income,
                onSave: (value) => settings.updateIncome(value),
              ),
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: 'Regular Cost',
              subtitle: settings.regularCost.toString(),
              description: 'Your monthly cost deducted from your income.',
              onTap: () => _showNumberInputDialog(
                context: context,
                title: 'Regular Cost',
                hintText: 'Your monthly cost that deducted from your income. It will only store on your device, not used anywhere else.',
                currentValue: settings.regularCost,
                onSave: (value) => settings.updateRegularCost(value),
              ),
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
              'AI Assistance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'OPTIONAL: To better use the application, you\'ll need a Gemini API key. '
              'If you don\'t already have one, '
              'create a key in Google AI Studio.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'By inputting your Gemini API key, you agree to the terms of service.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Center(
              child: Link(
                uri: Uri.https('makersuite.google.com', '/app/apikey'),
                target: LinkTarget.blank,
                builder: (context, followLink) => ElevatedButton.icon(
                  onPressed: followLink,
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Get an API Key'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingListTile(
              context,
              title: 'Gemini API Key',
              subtitle: settings.geminiKey.isEmpty ? 'Not set' : '****',
              description: 'Configure your Gemini API access',
              onTap: () => _showTextInputDialog(
                context,
                'Gemini API Key',
                settings.geminiKey,
                (value) => settings.updateGeminiKey(value),
              ),
            ),
            const Divider(),
            _buildSettingListTile(
              context,
              title: 'Gemini Model',
              subtitle: settings.geminiModel.isEmpty ? 'Not set' : settings.geminiModel,
              description: 'Select the AI model for assistance',
              onTap: () => _showModelSelectionDialog(
                context,
                settings.geminiModel,
                (value) => settings.updateGeminiModel(value),
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
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Get Started'),
        ),
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
        'Disclaimer: AI features are optional and require a valid Gemini API key. '
        'Usage is subject to Google\'s terms of service.',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontStyle: FontStyle.italic,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
