import 'package:flutter/material.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';

enum IncomeFormat {
  monthly,
  hourly,
  biWeekly,
  yearly,
}

class IncomeInputDialog extends StatefulWidget {
  final double currentValue;
  final String currency;
  final Function(double) onSave;

  const IncomeInputDialog({
    super.key,
    required this.currentValue,
    required this.currency,
    required this.onSave,
  });

  @override
  State<IncomeInputDialog> createState() => _IncomeInputDialogState();
}

class _IncomeInputDialogState extends State<IncomeInputDialog> {
  late IncomeFormat _selectedFormat;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedFormat = IncomeFormat.monthly;
    _amountController.text = widget.currentValue.toString();
    _hoursController.text = '40'; // Default 40 hours per week
  }

  @override
  void dispose() {
    _amountController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  double _convertToMonthly(double amount, IncomeFormat format, double hoursPerWeek) {
    switch (format) {
      case IncomeFormat.monthly:
        return amount;
      case IncomeFormat.hourly:
        // Monthly Income = (Hourly Wage × Hours per Week × 52) / 12
        return (amount * hoursPerWeek * 52) / 12;
      case IncomeFormat.biWeekly:
        // Monthly Income = Bi-weekly Income × 2.1667
        return amount * 2.1667;
      case IncomeFormat.yearly:
        // Monthly Income = Annual Salary / 12
        return amount / 12;
    }
  }

  String _getFormatLabel(IncomeFormat format) {
    switch (format) {
      case IncomeFormat.monthly:
        return AppLocalizations.of(context)!.monthly;
      case IncomeFormat.hourly:
        return AppLocalizations.of(context)!.hourly;
      case IncomeFormat.biWeekly:
        return AppLocalizations.of(context)!.biWeekly;
      case IncomeFormat.yearly:
        return AppLocalizations.of(context)!.yearly;
    }
  }

  String _getAmountLabel(IncomeFormat format) {
    switch (format) {
      case IncomeFormat.monthly:
        return '${AppLocalizations.of(context)!.income} (${widget.currency})';
      case IncomeFormat.hourly:
        return '${AppLocalizations.of(context)!.hourly} ${AppLocalizations.of(context)!.income} (${widget.currency})';
      case IncomeFormat.biWeekly:
        return '${AppLocalizations.of(context)!.biWeekly} ${AppLocalizations.of(context)!.income} (${widget.currency})';
      case IncomeFormat.yearly:
        return '${AppLocalizations.of(context)!.yearly} ${AppLocalizations.of(context)!.income} (${widget.currency})';
    }
  }

  void _showConfirmationDialog(double monthlyIncome) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.monthlyIncomeConfirmation,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.incomeConversionNote,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.convertedMonthlyIncome,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${monthlyIncome.toStringAsFixed(2)} ${widget.currency}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              widget.onSave(monthlyIncome);
            },
            child: Text(AppLocalizations.of(context)!.confirmMonthlyIncome),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final hoursPerWeek = _selectedFormat == IncomeFormat.hourly
          ? double.parse(_hoursController.text)
          : 40.0;

      final monthlyIncome = _convertToMonthly(amount, _selectedFormat, hoursPerWeek);
      final roundedMonthlyIncome = double.parse(monthlyIncome.toStringAsFixed(2));

      if (_selectedFormat == IncomeFormat.monthly) {
        // Direct save for monthly income
        Navigator.of(context).pop();
        widget.onSave(roundedMonthlyIncome);
      } else {
        // Show confirmation dialog for converted income
        _showConfirmationDialog(roundedMonthlyIncome);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${AppLocalizations.of(context)!.update} ${AppLocalizations.of(context)!.income}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Format selection
            Text(
              AppLocalizations.of(context)!.incomeFormat,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.incomeFormatDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: IncomeFormat.values.map((format) {
                return ChoiceChip(
                  label: Text(_getFormatLabel(format)),
                  selected: _selectedFormat == format,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFormat = format;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // Amount input
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _getAmountLabel(_selectedFormat),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterValue;
                }
                final parsedValue = double.tryParse(value);
                if (parsedValue == null) {
                  return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                }
                if (parsedValue <= 0) {
                  return AppLocalizations.of(context)!.pleaseEnterValidNumber;
                }
                return null;
              },
            ),
            
            // Hours per week input (only for hourly format)
            if (_selectedFormat == IncomeFormat.hourly) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.enterHoursPerWeek,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.access_time),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterHoursPerWeek;
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0 || parsedValue > 168) {
                    return AppLocalizations.of(context)!.pleaseEnterValidHoursPerWeek;
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: _handleSave,
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
