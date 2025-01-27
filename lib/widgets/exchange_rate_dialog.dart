import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:provider/provider.dart';

import '../provider/setting_provider.dart';
import '../util/currency_service.dart';

class ExchangeRateDialog extends StatefulWidget {
  const ExchangeRateDialog({super.key});

  @override
  _ExchangeRateDialogState createState() => _ExchangeRateDialogState();
}

class _ExchangeRateDialogState extends State<ExchangeRateDialog>
    with SingleTickerProviderStateMixin {
  late TextEditingController _amountController;
  Currency? _sourceCurrency;
  Currency? _targetCurrency;
  double _convertedAmount = 0.0;
  bool _isLoading = false;
  String? _errorMessage;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _initializeDefaultCurrencies();

    // Add animation for smoother UX
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _initializeDefaultCurrencies() {
    final settingProvider =
        Provider.of<SettingProvider>(context, listen: false);

    setState(() {
      _sourceCurrency = CurrencyService().findByCode(settingProvider.currencyCalculationSource);
      _targetCurrency =
          CurrencyService().findByCode(settingProvider.currency ?? 'USD');
    });
  }

  void _convertCurrency() {
    if (_sourceCurrency == null || _targetCurrency == null) {
      _showErrorSnackBar('Please select both source and target currencies');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final amount = double.tryParse(_amountController.text) ?? 0.0;
      if (amount < 0) {
        _showErrorSnackBar('Please enter a valid amount');
        setState(() => _isLoading = false);
        return;
      }

      setState(() {
        _convertedAmount = CurrencyServiceCustom.convertCurrency(
            amount, _sourceCurrency!.code, _targetCurrency!.code);
        _isLoading = false;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to convert currency. Please try again.');
      setState(() => _isLoading = false);
    }
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
      ),
    );
  }

  void _selectSourceCurrency() {
    CurrencyServiceCustom.pickCurrency(
      context,
      onSelect: (Currency currency) {
        setState(() {
          _sourceCurrency = currency;
          Provider.of<SettingProvider>(context, listen: false).updateCurrencyCalculationSource(currency.code);
          _convertCurrency();
        });
      },
    );
  }

  void _selectTargetCurrency() {
    CurrencyServiceCustom.pickCurrency(
      context,
      onSelect: (Currency currency) {
        setState(() {
          _targetCurrency = currency;
          _convertCurrency();
        });
      },
    );
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _sourceCurrency;
      _sourceCurrency = _targetCurrency;
      _targetCurrency = temp;
      _convertCurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrowScreen = screenWidth < 350;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // Make dialog fill less screen width on mobile
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: FadeTransition(
        opacity: _animation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                // Adjust constraints for better mobile responsiveness
                constraints: BoxConstraints(
                  maxWidth: 500,
                  minWidth: 300,
                  maxHeight: MediaQuery.of(context).size.height * 0.8, // Limit height
                ),
                padding: const EdgeInsets.all(16.0), // Slightly reduced padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Currency Exchange',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: isNarrowScreen ? 18 : null, // Adjust font size for narrow screens
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          color: Theme.of(context).colorScheme.error,
                          tooltip: 'Close',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCurrencyInputField(),
                    const SizedBox(height: 16),
                    _buildCurrencySwapSection(),
                    const SizedBox(height: 16),
                    _buildConversionResult(),
                    const SizedBox(height: 8),
                    Text(
                      "Powered by Google Finance",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrencyInputField() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrowScreen = screenWidth < 350;

    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: 'Amount',
        labelStyle: TextStyle(fontSize: isNarrowScreen ? 14 : null),
        hintText: 'Enter amount to convert',
        hintStyle: TextStyle(fontSize: isNarrowScreen ? 14 : null),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        suffixIcon: TextButton(
          onPressed: _selectSourceCurrency,
          child: Text(
            _sourceCurrency?.code ?? 'Select',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: isNarrowScreen ? 14 : null,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (_) => _convertCurrency(),
      style: TextStyle(fontSize: isNarrowScreen ? 14 : 16),
      autofocus: true,
    );
  }

  Widget _buildCurrencySwapSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrowScreen = constraints.maxWidth < 350;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              color: Theme.of(context).colorScheme.secondary,
              tooltip: 'Swap Currencies',
              onPressed: _swapCurrencies,
              iconSize: isNarrowScreen ? 24 : 32,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  _targetCurrency?.code ?? 'Select Target',
                  style: TextStyle(fontSize: isNarrowScreen ? 14 : null),
                ),
                onPressed: _selectTargetCurrency,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConversionResult() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrowScreen = screenWidth < 350;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isLoading
          ? const Center(
              key: ValueKey('loading'),
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Text(
                  key: const ValueKey('error'),
                  _errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: isNarrowScreen ? 14 : null,
                  ),
                  textAlign: TextAlign.center,
                )
              : Card(
                  key: const ValueKey('result'),
                  elevation: 4,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0), // Slightly reduced padding
                    child: Column(
                      children: [
                        Text(
                          'Converted Amount',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontSize: isNarrowScreen ? 14 : null,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${CurrencyServiceCustom.formatCurrency(_convertedAmount, _targetCurrency?.code ?? 'USD')} ${_targetCurrency?.code ?? ''}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: isNarrowScreen ? 18 : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
