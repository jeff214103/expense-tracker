import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_web/util/google_sheet.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';
import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:expense_tracker_web/models/expense_record.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> with SingleTickerProviderStateMixin {
  String? selectedSheet;
  List<String> sheetsNames = [];
  List<ExpenseRecord>? expenseData;
  Map<String, double> categorySums = {};
  double totalExpense = 0;
  bool isLoading = false;
  String? selectedCurrency;
  Map<String, int> currencyFrequency = {};
  
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
    
    final settingProvider = Provider.of<SettingProvider>(context, listen: false);
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

      if (record.finalAmount.isNotEmpty && record.finalAmount != record.amount) {
        amount = double.tryParse(record.finalAmount) ?? 0;
        sourceCurrency = Provider.of<SettingProvider>(context, listen: false).currency ?? "USD";
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
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut,
                    ),
                  ),
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
                );
              },
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
        mainAxisSize: MainAxisSize.min,
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
          if (isMobile)
            _buildCategoryList()
          else
            Expanded(child: _buildCategoryList()),
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
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categorySums.length,
      itemBuilder: (context, index) {
        final entry = categorySums.entries.elementAt(index);
        return ListTile(
          title: Text(
            entry.key,
            overflow: TextOverflow.ellipsis,
            maxLines: isMobileScreen ? 2 : 1,
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

  Widget _buildExpenseList({bool isMobile = false}) {
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
          if (expenseData == null || expenseData!.isEmpty)
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
              itemCount: expenseData?.length ?? 0,
              itemBuilder: (context, index) {
                return _buildExpenseListItem(expenseData![index]);
              },
            )
          else
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: expenseData?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildExpenseListItem(expenseData![index]);
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
          _buildCategorySummary(isMobile: true),
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

  Widget _buildExpenseListItem(ExpenseRecord record) {
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
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('d MMM y').format(record.invoiceDate),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${record.amount} ${record.currency}',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
              Expanded(
                child: Text(
                  record.category,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                DateFormat('d MMM y').format(record.invoiceDate),
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          trailing: Container(
            constraints: BoxConstraints(
              maxWidth: isMobileScreen ? 120 : 200,
            ),
            child: Text(
              '${record.amount} ${record.currency}',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
