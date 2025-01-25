import 'package:expense_tracker_web/models/expense_record.dart';
import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:expense_tracker_web/screen/expense_list.dart';
import 'package:expense_tracker_web/screen/signin.dart';
import 'package:expense_tracker_web/screen/welcome.dart';
import 'package:expense_tracker_web/widgets/loading_hint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_web/screen/expense_form.dart';
import 'package:expense_tracker_web/widgets/custom_scafold.dart';
import 'package:expense_tracker_web/util/google_sheet.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:expense_tracker_web/screen/setting.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';

void _redirectTo(BuildContext context, Widget widget,
    {void Function(dynamic)? callback}) {
  Navigator.of(context)
      .push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  )
      .then((value) {
    if (callback != null) {
      callback(value);
    }
  });
}

class HomePage extends StatefulWidget {
  final GoogleSignInAccount account;
  const HomePage({super.key, required this.account});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Future applicationLoaded;
  late AnimationController _animationController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for smooth transitions
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Initialize exchange rates when home page loads
    applicationLoaded = Future.wait([
      CurrencyServiceCustom.updateExchangeRates(),
      configureApplication(context),
    ]);
  }

  Future<void> configureApplication(BuildContext context) async {
    try {
      SettingProvider settingProvider =
          Provider.of<SettingProvider>(context, listen: false);
      await settingProvider.init();

      if (settingProvider.currency == null) {
        _redirectTo(
          context,
          const WelcomeScreen(allowSkip: false),
          callback: (value) {
            _redirectTo(
              context,
              const SettingScreen(isFirstTime: true),
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to configure application: ${e.toString()}';
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Enhanced error notification widget
  Widget _buildErrorNotification() {
    return _errorMessage != null
        ? Semantics(
            label: 'Error notification',
            hint: 'An error occurred while loading the application',
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
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _animationController.reverse();
                            setState(() => _errorMessage = null);
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
    return CustomScafold(
      title: 'Expense Tracker',
      actions: [
        IconButton(
          tooltip: 'Help',
          onPressed: () {
            _redirectTo(
              context,
              const WelcomeScreen(allowSkip: true),
            );
          },
          icon: const Icon(Icons.help),
        ),
        IconButton(
          tooltip: 'Logout',
          onPressed: () async {
            // Sign out the user
            GoogleSignInHelper.signOut().then((GoogleSignInAccount? account) {
              // Navigate back to the login screen
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const GoogleSignInPage()),
                  (Route<dynamic> route) => false);
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ],
      child: Column(
        children: [
          // Error Notification
          _buildErrorNotification(),

          Expanded(
            child: FutureBuilder(
              future: applicationLoaded,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingHint(text: 'Configuring application...');
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load application',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() {
                            applicationLoaded = Future.wait([
                              CurrencyServiceCustom.updateExchangeRates(),
                              configureApplication(context),
                            ]);
                          }),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            title: Text(
                              'Hello ${widget.account.displayName}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                            subtitle: Text(
                              'Welcome back',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                            trailing: Hero(
                              tag: 'user_avatar',
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    (widget.account.photoUrl != null)
                                        ? NetworkImage(widget.account.photoUrl!)
                                        : null,
                                child: (widget.account.photoUrl == null)
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    ),
                    const DashboardLayout(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate responsive values
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 30,
        vertical: 10,
      ),
      child: Column(
        children: [
          const ExpenseSummary(),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // Adjust grid based on screen size
            crossAxisCount: isSmallScreen ? 2 : (screenWidth ~/ 200.0),
            childAspectRatio: isSmallScreen ? 1.2 : 1,
            crossAxisSpacing: isSmallScreen ? 16 : 40,
            mainAxisSpacing: isSmallScreen ? 16 : 30,
            children: [
              Dashboarditem(
                title: 'ADD',
                iconData: Icons.money,
                background: Colors.deepOrange,
                onTap: () {
                  _redirectTo(
                    context,
                    const ExpenseScreen(),
                  );
                },
              ),
              Dashboarditem(
                title: 'VIEW',
                iconData: Icons.list,
                background: Colors.blue,
                onTap: () {
                  _redirectTo(
                    context,
                    const ExpenseList(),
                  );
                },
              ),
              Dashboarditem(
                title: 'SETTING',
                iconData: Icons.settings,
                background: Colors.green,
                onTap: () {
                  _redirectTo(
                    context,
                    const SettingScreen(),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ExpenseSummary extends StatefulWidget {
  const ExpenseSummary({super.key});

  @override
  State<ExpenseSummary> createState() => _ExpenseSummaryState();
}

class _ExpenseSummaryState extends State<ExpenseSummary> {
  String? selectedCurrency;
  Map<String, int> currencyFrequency = {};
  List<ExpenseRecord>? currentMonthData;
  List<ExpenseRecord>? lastMonthData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final now = DateTime.now();
    final currentMonth = DateFormat('y MMM').format(now);
    final lastMonth =
        DateFormat('y MMM').format(DateTime(now.year, now.month - 1));

    try {
      final currentData =
          await GoogleSheetHelper.getSheetData('Expense ($currentMonth)', force: true);
      final lastData =
          await GoogleSheetHelper.getSheetData('Expense ($lastMonth)');

      // Calculate currency frequency from current month
      currencyFrequency.clear();
      if (currentData != null) {
        for (var record in currentData) {
          String currency = record.currency.trim();
          currencyFrequency[currency] = (currencyFrequency[currency] ?? 0) + 1;
        }
      }

      // Set default currency if not selected
      if (selectedCurrency == null && currencyFrequency.isNotEmpty) {
        selectedCurrency = currencyFrequency.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;
      }

      setState(() {
        currentMonthData = currentData;
        lastMonthData = lastData;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately
    }
  }

  Map<String, double?> _calculateStats(SettingProvider setting) {
    double? calculateTotal(List<ExpenseRecord>? records) {
      if (records == null || records.isEmpty) return null;
      return records.fold(0.0, (sum, record) {
        double amount;
        String sourceCurrency;

        if (record.finalAmount.isNotEmpty &&
            record.finalAmount != record.amount) {
          amount = double.tryParse(record.finalAmount) ?? 0;
          sourceCurrency = setting.currency ?? "USD";
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

        return sum! + amount;
      });
    }

    final double? currentTotal = calculateTotal(currentMonthData);
    final double? lastTotal = calculateTotal(lastMonthData);
    final currentRemain = CurrencyServiceCustom.convert(
            setting.income, setting.currency ?? "USD", selectedCurrency!) -
        CurrencyServiceCustom.convert(
            setting.regularCost, setting.currency ?? "USD", selectedCurrency!) -
        (currentTotal ?? 0.0);

    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final remainingDays = daysInMonth - now.day;
    final double dailyBudget =
        remainingDays > 0 ? currentRemain / remainingDays : 0;

    return {
      'currentTotal': currentTotal,
      'currentRemain': currentRemain,
      'lastTotal': lastTotal,
      'dailyBudget': dailyBudget,
    };
  }

  void _showCurrencyPicker() {
    CurrencyServiceCustom.pickCurrency(context, onSelect: (currency) {
      setState(() {
        selectedCurrency = currency.code;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settings, child) {
        selectedCurrency ??= (settings.currency ?? "USD");
        final stats = _calculateStats(settings);

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Monthly Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showCurrencyPicker,
                      icon: const Icon(Icons.currency_exchange),
                      label: Text(selectedCurrency ?? "USD"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  _buildSummary(stats),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummary(Map<String, double?> stats) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    final difference = (stats['currentTotal'] ?? 0) - (stats['lastTotal'] ?? 0);
    final differenceText = (stats['lastTotal'] == null)
        ? 'No last month data'
        : (difference > 0
            ? '${CurrencyServiceCustom.formatCurrency(difference, selectedCurrency ?? "USD")} MORE than last month'
            : difference < 0
                ? '${CurrencyServiceCustom.formatCurrency(-difference, selectedCurrency ?? "USD")} LESS than last month'
                : 'Same as last month');

    return Flex(
      direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
      mainAxisSize: isSmallScreen ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: isSmallScreen
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: _SummaryItem(
            title: 'Spending',
            value: CurrencyServiceCustom.formatCurrency(
              stats['currentTotal'] ?? 0,
              selectedCurrency ?? "USD",
            ),
            subtitle: differenceText,
          ),
        ),
        SizedBox(width: isSmallScreen ? 0 : 16, height: isSmallScreen ? 16 : 0),
        Flexible(
          child: _SummaryItem(
            title: 'Remaining',
            value: CurrencyServiceCustom.formatCurrency(
              stats['currentRemain']!,
              selectedCurrency ?? "USD",
            ),
            subtitle: (stats['currentRemain']! < 0)
                ? 'Over consumed'
                : '${CurrencyServiceCustom.formatCurrency(stats['dailyBudget']!, selectedCurrency ?? "USD")} left per day',
          ),
        ),
      ],
    );
  }
}

class Dashboarditem extends StatefulWidget {
  const Dashboarditem(
      {super.key,
      required this.title,
      required this.iconData,
      required this.background,
      required this.onTap});
  final String title;
  final IconData iconData;
  final Color background;
  final VoidCallback onTap;

  @override
  State<Dashboarditem> createState() => _DashboarditemState();
}

class _DashboarditemState extends State<Dashboarditem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).shadowColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(widget.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      ),
    );
  }
}
