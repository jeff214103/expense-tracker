// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Expense Tracker';

  @override
  String get categoryLabel => 'Category';

  @override
  String get categoryValidationError => 'Please select a category';

  @override
  String get expenseForm => 'Expense Form';

  @override
  String get processingReceiptWithAI => 'Processing receipt with AI...';

  @override
  String get expenseSubmittedSuccessfully =>
      'The expense form has been submitted successfully.';

  @override
  String get submittingExpenseForm => 'Submitting expense form...';

  @override
  String get pleaseSelectReceiptImage => 'Please select a receipt image';

  @override
  String get pleaseEnterReceiptDate => 'Please enter the receipt date';

  @override
  String get date => 'Date';

  @override
  String get itemName => 'Item Name';

  @override
  String get pleaseEnterItemName => 'Please enter an item name';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get price => 'Price';

  @override
  String get pleaseSelectCurrency => 'Please select the currency';

  @override
  String get pleaseEnterPrice => 'Please enter the price';

  @override
  String get pleaseEnterValidPrice => 'Please enter valid price';

  @override
  String get chooseCurrency => 'Choose Currency';

  @override
  String get uploadReceiptToGoogleDrive => 'Upload receipt to Google Drive';

  @override
  String get submit => 'Submit';

  @override
  String get pickTheReceipt => 'Pick the receipt';

  @override
  String get noFileSelected => 'No file selected';

  @override
  String finalPaymentAmount(Object currency) {
    return 'Final Payment Amount in $currency';
  }

  @override
  String get editAmount => 'Edit Amount';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get expenseList => 'Expense List';

  @override
  String get noSpreadsheetsAvailable => 'No spreadsheets available';

  @override
  String failedToLoadSpreadsheets(Object error) {
    return 'Failed to load spreadsheets: $error';
  }

  @override
  String failedToLoadExpenseData(Object error) {
    return 'Failed to load expense data: $error';
  }

  @override
  String get noExpenseRecordsFound => 'No expense records found';

  @override
  String get errorNotification => 'Error notification';

  @override
  String get anErrorOccurredWhileLoadingData =>
      'An error occurred while loading data';

  @override
  String get categorySummary => 'Category Summary';

  @override
  String get changeCurrency => 'Change Currency';

  @override
  String get totalExpense => 'Total Expense';

  @override
  String get noDataForPieChart => 'No data for pie chart';

  @override
  String get selectMonth => 'Select Month';

  @override
  String inputFinalPaymentAmount(Object currency) {
    return 'Input your final payment amount in $currency, and all calculation will be based on this amount and the setting currency.';
  }

  @override
  String get finalAmountUpdatedSuccessfully =>
      'Final amount updated successfully';

  @override
  String get failedToUpdateFinalAmount => 'Failed to update final amount';

  @override
  String errorUpdatingFinalAmount(Object error) {
    return 'Error updating final amount: $error';
  }

  @override
  String get viewReceipt => 'View receipt';

  @override
  String get expenseRecord => 'Expense record';

  @override
  String get expenseDetails => 'Expense details';

  @override
  String get finalChargeAmount => 'Final Charge Amount';

  @override
  String failedToLoadFile(Object error) {
    return 'Failed to load file: $error';
  }

  @override
  String get fileRemovedSuccessfully => 'File removed successfully';

  @override
  String get failedToRemoveFile => 'Failed to remove file';

  @override
  String errorRemovingFile(Object error) {
    return 'Error removing file: $error';
  }

  @override
  String get removeFile => 'Remove File';

  @override
  String get areYouSureYouWantToRemoveThisFile =>
      'Are you sure you want to remove this file?';

  @override
  String get remove => 'Remove';

  @override
  String get noFileToDisplay => 'No file to display';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get filePreview => 'File Preview';

  @override
  String get close => 'Close';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Settings';

  @override
  String get signOut => 'Sign Out';

  @override
  String get exchangeRates => 'Exchange Rates';

  @override
  String get signIn => 'Sign In';

  @override
  String get expenseTracker => 'Expense Tracker';

  @override
  String get help => 'Help';

  @override
  String get logout => 'Logout';

  @override
  String get hello => 'Hello';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get add => 'Add';

  @override
  String get view => 'View';

  @override
  String get setting => 'Setting';

  @override
  String get exchangeRate => 'Exchange Rate';

  @override
  String get monthlySummary => 'Monthly Summary';

  @override
  String get overspending => 'Overspending';

  @override
  String monthlyUsable(Object percentage) {
    return '$percentage% of monthly usable';
  }

  @override
  String get spending => 'Spending';

  @override
  String get remaining => 'Remaining';

  @override
  String get overConsumed => 'Over consumed';

  @override
  String monthlyRemain(Object amount) {
    return '$amount left per day';
  }

  @override
  String get serviceAgreement => 'Service Agreement';

  @override
  String get serviceAgreementLastUpdated => 'Last Updated: January 2025';

  @override
  String get acceptanceOfTermsTitle => '1. Acceptance of Terms';

  @override
  String get acceptanceOfTermsDescription =>
      'By accessing and using the Expense Tracker System, you agree to be bound by this Service Agreement. If you do not agree with any part of these terms, please refrain from using our services.';

  @override
  String get servicesProvidedTitle => '2. Services Provided';

  @override
  String get servicesProvidedDescription =>
      'Our Expense Tracker System provides a secure and efficient way to manage your financial information. Key features include:';

  @override
  String get servicesProvidedSecureAuthentication =>
      'Secure authentication using Google Sign-In.';

  @override
  String get servicesProvidedDataStorage =>
      'Data storage in your personal Google Drive and management via Google Sheets.';

  @override
  String get servicesProvidedRealTimeTracking =>
      'Real-time tracking and analysis of your expenses.';

  @override
  String get servicesProvidedDisclaimer =>
      'Services are provided on an \"as is\" basis without any express or implied warranties.';

  @override
  String get userResponsibilitiesTitle => '3. User Responsibilities';

  @override
  String get userResponsibilitiesDescription =>
      'Users are responsible for ensuring that all account information is accurate and up-to-date. You must maintain the confidentiality of your account credentials and abide by all applicable laws.';

  @override
  String get accountSecurityAndDataPrivacyTitle =>
      '4. Account Security and Data Privacy';

  @override
  String get accountSecurityAndDataPrivacyDescription =>
      'We employ Google Sign-In for secure authentication. Your financial data remains under your control and is securely stored within your Google services. It is your responsibility to keep your login details confidential.';

  @override
  String get intellectualPropertyRightsTitle =>
      '5. Intellectual Property Rights';

  @override
  String get intellectualPropertyRightsDescription =>
      'All content, features, and functionalities related to the Expense Tracker System— including software, design, text, and graphics—are the intellectual property of the developers. Unauthorized use, reproduction, or distribution is strictly prohibited.';

  @override
  String get limitationOfLiabilityTitle => '6. Limitation of Liability';

  @override
  String get limitationOfLiabilityDescription =>
      'To the fullest extent permitted by law, neither the developers nor any affiliated parties shall be liable for any indirect, incidental, or consequential damages arising from the use of the Expense Tracker System. Your use of the service is at your own risk.';

  @override
  String get changesToTheAgreementTitle => '7. Changes to the Agreement';

  @override
  String get changesToTheAgreementDescription =>
      'We reserve the right to modify or update this Service Agreement at any time. It is your responsibility to review these terms periodically. Continued use of the service constitutes acceptance of any changes made to the agreement.';

  @override
  String get contactAndSupportTitle => '8. Contact and Support';

  @override
  String get contactAndSupportDescription =>
      'For any questions or concerns regarding this Service Agreement, please contact our support team or reach out via our GitHub repository.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicyLastUpdated => 'Last Updated: January 2025';

  @override
  String get openSourceAndNonProfitMissionTitle =>
      '1. Open Source and Non-Profit Mission';

  @override
  String get openSourceAndNonProfitMissionDescription =>
      'This application is an open-source, non-profit project dedicated to empowering users with personal financial tracking and analysis.';

  @override
  String get dataCollectionAndUsageTitle => '2. Data Collection and Usage';

  @override
  String get dataCollectionAndUsageDescription =>
      'We do not collect, store, or sell any personal information beyond what is necessary for the app\'s core functionality:';

  @override
  String get dataCollectionGoogleSignInBullet =>
      'Google Sign-In is used solely for authentication and accessing your personal Google Drive and Sheets';

  @override
  String get dataCollectionFinancialDataBullet =>
      'Expense data is stored exclusively in your personal Google Drive and Sheets';

  @override
  String get dataCollectionDataOwnershipBullet =>
      'All data remains under your complete control and ownership';

  @override
  String get authenticationTitle => '3. Authentication';

  @override
  String get authenticationDescription =>
      'The app uses Google Sign-In with the following limited scopes:';

  @override
  String get authenticationEmailVerificationBullet => 'Email verification';

  @override
  String get authenticationGoogleDriveFileAccessBullet =>
      'Google Drive file access';

  @override
  String get dataStorageTitle => '4. Data Storage';

  @override
  String get dataStorageDescription => 'Your expense records are:';

  @override
  String get dataStorageGoogleSpreadsheetBullet =>
      'Stored in a personal Google Spreadsheet';

  @override
  String get dataStorageManagedThroughGoogleAccountBullet =>
      'Managed through your authenticated Google account';

  @override
  String get dataStorageNotAccessibleByDevelopersBullet =>
      'Not accessible by the app developers';

  @override
  String get userControlTitle => '5. User Control';

  @override
  String get userControlDescription => 'You have full control over your data:';

  @override
  String get userControlRevokeAppAccessBullet =>
      'Revoke app access at any time through Google account settings';

  @override
  String get userControlDeleteStoredFilesBullet =>
      'Delete stored files directly from your Google Drive';

  @override
  String get userControlOptOutDataStorageBullet =>
      'Opt-out of data storage by not using the app';

  @override
  String get securityTitle => '6. Security';

  @override
  String get securityDescription =>
      'While we implement standard security practices, we recommend:';

  @override
  String get securityStrongGoogleAccountCredentialsBullet =>
      'Using strong Google account credentials';

  @override
  String get securityRegularlyReviewConnectedApplicationsBullet =>
      'Regularly reviewing connected applications';

  @override
  String get openSourceTransparencyTitle => '7. Open Source Transparency';

  @override
  String get openSourceTransparencyDescription =>
      'Our complete source code is available for public review at our GitHub repository, ensuring full transparency in data handling.';

  @override
  String get contactAndFeedbackTitle => '8. Contact and Feedback';

  @override
  String get contactAndFeedbackDescription =>
      'For any privacy-related inquiries or feedback, please open an issue on our GitHub repository.';

  @override
  String get general => 'General';

  @override
  String get currencySelectionHint =>
      'You must choose the currency you use for your expenses. Click on this section to set it. You can always change it later.';

  @override
  String get currency => 'Currency';

  @override
  String get currencyDescription =>
      'Default currency in calculations and reports';

  @override
  String get notSet => 'Not set';

  @override
  String get income => 'Income';

  @override
  String incomeDescription(Object currency) {
    return '(OPTIONAL) Your monthly income ($currency).';
  }

  @override
  String incomeHint(Object currency) {
    return 'Your monthly income ($currency). It will store on your sheet setting.';
  }

  @override
  String get regularCost => 'Regular Cost';

  @override
  String regularCostDescription(Object currency) {
    return '(OPTIONAL) Your monthly cost ($currency) deducted from your income.';
  }

  @override
  String regularCostHint(Object currency) {
    return 'Your monthly cost ($currency) that deducted from your income. It will store on your sheet setting, not used anywhere else.';
  }

  @override
  String get aiAssistance => 'AI Assistance';

  @override
  String get selectGeminiModel => 'Select Gemini Model';

  @override
  String get geminiApiKeyDescription =>
      'OPTIONAL: To better use the application, you\'ll need a Gemini API key. If you don\'t already have one, create a key in Google AI Studio.';

  @override
  String get geminiApiKeyAgreement =>
      'By inputting your Gemini API key, you agree to the terms of service.';

  @override
  String get getAnApiKey => 'Get an API Key';

  @override
  String get geminiApiKey => 'Gemini API Key';

  @override
  String get geminiApiKeyConfig => 'Configure your Gemini API access';

  @override
  String get geminiModel => 'Gemini Model';

  @override
  String get geminiModelDescription => 'Select the AI model for assistance';

  @override
  String get enterApiKey => 'Enter API Key';

  @override
  String get pleaseEnterValidApiKey => 'Please enter a valid API key';

  @override
  String get exchangeRatesDescription =>
      'For every 1 USD, the app will compute based on the exchange rate from Google Finance. List of available currencies below.';

  @override
  String get noExchangeRatesAvailable => 'No exchange rates available';

  @override
  String get update => 'Update';

  @override
  String get pleaseEnterValue => 'Please enter a value';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get getStarted => 'Get Started';

  @override
  String get actionInProgress => 'Action in progress...';

  @override
  String get geminiDisclaimer =>
      'Disclaimer: AI features are optional and require a valid Gemini API key. Usage is subject to Google\'s terms of service.';

  @override
  String get expenseTrackerSystem => 'Expense Tracker System';

  @override
  String get appVersion => 'Version 1.1.5';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get appInformation => 'App Information';

  @override
  String authenticationError(Object error) {
    return 'Authentication error: $error';
  }

  @override
  String get success => 'SUCCESS';

  @override
  String get done => 'Done';

  @override
  String welcomePageHeader(String header) {
    String _temp0 = intl.Intl.selectLogic(
      header,
      {
        'welcome': 'Welcome',
        'privacy': 'Privacy',
        'input': 'Input',
        'view': 'View',
        'manage': 'Manage',
        'author': 'Author',
        'almostThere': 'Almost There',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String welcomePageDescription(String description) {
    String _temp0 = intl.Intl.selectLogic(
      description,
      {
        'welcomeDescription':
            'Welcome to your expense management app. Track your daily expenses efficiently.\n\nAdd this app to your home screen by following the steps in the link below:',
        'privacyDescription':
            'Your data privacy matters. Here\'s where your information is stored:\n\n1. Google Drive - Receipt images\n2. Google Sheets - Expense records, Exchange Rates, Settings\n\nNote: You are responsible for your device and Google account security. The app developer is not liable for any data breaches due to your security settings.',
        'inputDescription':
            'Getting started is easy! Scan your receipt, and if you\'ve set up Gemini, the information will be extracted automatically. You can review and adjust the details as needed.\n\nNo receipt? You can also input expenses manually.',
        'viewDescription':
            'Easily track your spending history. All amounts are shown in your preferred currency. Currency conversion rates are preset and may need manual updates.',
        'manageDescription':
            'The app creates a Google Sheet named \"Expense Record\" and a Google Drive folder called \"Expense History (Automated)\". You can find these files in your Google Drive. If you run out of space, you may need to delete them manually.',
        'authorDescription':
            'This project is open source on GitHub. Contributions are welcome! If you find this app helpful, consider supporting the developer with a coffee!',
        'almostThereDescription':
            'You\'re all set! Let\'s start managing your expenses.',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String welcomePageLinkName(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'tutorialLink': 'Tutorial link',
        'privacyPolicy': 'Privacy Policy',
        'termsOfService': 'Terms of Service',
        'github': 'GitHub',
        'itdogtics': 'ITDOGTICS',
        'aboutAuthor': 'About Author',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String pageIndicatorLabel(Object index) {
    return 'Page $index indicator';
  }

  @override
  String pageIndicatorHint(Object index) {
    return 'Navigate to page $index';
  }

  @override
  String get skipTutorial => 'Skip tutorial';

  @override
  String get skipTutorialHint => 'Skip the welcome tutorial';

  @override
  String get goBackToFirstPage => 'Go back to first page';

  @override
  String get goBackToFirstPageHint =>
      'Return to the first page of the tutorial';

  @override
  String get nextPage => 'Next page';

  @override
  String get nextPageHint => 'Go to the next page';

  @override
  String get finishTutorial => 'Finish tutorial';

  @override
  String get finishTutorialHint => 'Complete the welcome tutorial';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get go => 'Go';

  @override
  String get back => 'Back';

  @override
  String get poweredByGoogleFinance => 'Powered by Google Finance';

  @override
  String get currencyExchange => 'Currency Exchange';

  @override
  String get amount => 'Amount';

  @override
  String get enterAmountToConvert => 'Enter amount to convert';

  @override
  String get select => 'Select';

  @override
  String get selectTarget => 'Select Target';

  @override
  String get swapCurrencies => 'Swap Currencies';

  @override
  String get convertedAmount => 'Converted Amount';

  @override
  String get currencySelectionError =>
      'Please select both source and target currencies';

  @override
  String get invalidAmountError => 'Please enter a valid amount';

  @override
  String get currencyConversionError =>
      'Failed to convert currency. Please try again.';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Select your preferred app language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get incomeFormat => 'Income Format';

  @override
  String get incomeFormatDescription =>
      'Select how you want to input your income';

  @override
  String get monthly => 'Monthly';

  @override
  String get hourly => 'Hourly';

  @override
  String get biWeekly => 'Bi-weekly';

  @override
  String get yearly => 'Yearly';

  @override
  String get hoursPerWeek => 'Hours per week';

  @override
  String get enterHoursPerWeek => 'Enter hours per week';

  @override
  String get pleaseEnterHoursPerWeek => 'Please enter hours per week';

  @override
  String get pleaseEnterValidHoursPerWeek =>
      'Please enter valid hours per week (1-168)';

  @override
  String get monthlyIncomeConfirmation => 'Monthly Income Confirmation';

  @override
  String get convertedMonthlyIncome => 'Converted Monthly Income';

  @override
  String get confirmMonthlyIncome => 'Confirm Monthly Income';

  @override
  String get incomeConversionNote =>
      'Based on your input, your monthly income would be:';

  @override
  String get category_Housing => 'Housing';

  @override
  String get category_Housing_MortgageRent => 'Mortgage or rent';

  @override
  String get category_Housing_PropertyTaxes => 'Property taxes';

  @override
  String get category_Housing_HouseholdRepairs => 'Household repairs';

  @override
  String get category_Housing_HOAFees => 'HOA fees';

  @override
  String get category_Transportation => 'Transportation';

  @override
  String get category_Transportation_PublicTransportation =>
      'Public transportation';

  @override
  String get category_Transportation_TaxiUber => 'Taxi/Uber';

  @override
  String get category_Transportation_PrepaidCard => 'Prepaid card';

  @override
  String get category_Transportation_CarPayment => 'Car payment';

  @override
  String get category_Transportation_CarWarranty => 'Car warranty';

  @override
  String get category_Transportation_Gas => 'Gas';

  @override
  String get category_Transportation_Tires => 'Tires';

  @override
  String get category_Transportation_MaintenanceOilChanges =>
      'Maintenance and oil changes';

  @override
  String get category_Transportation_ParkingFees => 'Parking fees';

  @override
  String get category_Transportation_Repairs => 'Repairs';

  @override
  String get category_Transportation_RegistrationDMVFees =>
      'Registration and DMV Fees';

  @override
  String get category_Food => 'Food';

  @override
  String get category_Food_Groceries => 'Groceries';

  @override
  String get category_Food_Restaurants => 'Restaurants';

  @override
  String get category_Food_Takeaway => 'Takeaway';

  @override
  String get category_Food_FromFriend => 'From Friend';

  @override
  String get category_Food_StreetFood => 'Street food';

  @override
  String get category_Food_Delivery => 'Delivery';

  @override
  String get category_Food_PetFood => 'Pet food';

  @override
  String get category_Utilities => 'Utilities';

  @override
  String get category_Utilities_Electricity => 'Electricity';

  @override
  String get category_Utilities_Water => 'Water';

  @override
  String get category_Utilities_Garbage => 'Garbage';

  @override
  String get category_Utilities_Phones => 'Phones';

  @override
  String get category_Utilities_Cable => 'Cable';

  @override
  String get category_Utilities_Internet => 'Internet';

  @override
  String get category_Clothing => 'Clothing';

  @override
  String get category_Clothing_AdultsClothing => 'Adults\' clothing';

  @override
  String get category_Clothing_AdultsShoes => 'Adults\' shoes';

  @override
  String get category_Clothing_ChildrensClothing => 'Children\'s clothing';

  @override
  String get category_Clothing_ChildrensShoes => 'Children\'s shoes';

  @override
  String get category_MedicalHealthcare => 'Medical/Healthcare';

  @override
  String get category_MedicalHealthcare_PrimaryCare => 'Primary care';

  @override
  String get category_MedicalHealthcare_DentalCare => 'Dental care';

  @override
  String get category_MedicalHealthcare_SpecialtyCare => 'Specialty care';

  @override
  String get category_MedicalHealthcare_UrgentCare => 'Urgent care';

  @override
  String get category_MedicalHealthcare_Medications => 'Medications';

  @override
  String get category_MedicalHealthcare_MedicalDevices => 'Medical devices';

  @override
  String get category_Insurance => 'Insurance';

  @override
  String get category_Insurance_HealthInsurance => 'Health insurance';

  @override
  String get category_Insurance_HomeownerRentersInsurance =>
      'Homeowner\'s or renter\'s insurance';

  @override
  String get category_Insurance_HomeWarrantyProtectionPlan =>
      'Home warranty or protection plan';

  @override
  String get category_Insurance_AutoInsurance => 'Auto insurance';

  @override
  String get category_Insurance_LifeInsurance => 'Life insurance';

  @override
  String get category_Insurance_DisabilityInsurance => 'Disability insurance';

  @override
  String get category_HouseholdItemsSupplies => 'Household Items/Supplies';

  @override
  String get category_HouseholdItemsSupplies_Toiletries => 'Toiletries';

  @override
  String get category_HouseholdItemsSupplies_LaundryDetergent =>
      'Laundry detergent';

  @override
  String get category_HouseholdItemsSupplies_DishwasherDetergent =>
      'Dishwasher detergent';

  @override
  String get category_HouseholdItemsSupplies_CleaningSupplies =>
      'Cleaning supplies';

  @override
  String get category_HouseholdItemsSupplies_Tools => 'Tools';

  @override
  String get category_Personal => 'Personal';

  @override
  String get category_Personal_GymMemberships => 'Gym memberships';

  @override
  String get category_Personal_Haircuts => 'Haircuts';

  @override
  String get category_Personal_SalonServices => 'Salon services';

  @override
  String get category_Personal_Cosmetics => 'Cosmetics';

  @override
  String get category_Personal_Babysitter => 'Babysitter';

  @override
  String get category_Personal_Subscriptions => 'Subscriptions';

  @override
  String get category_Education => 'Education';

  @override
  String get category_Education_ChildrenCollege => 'Children\'s college';

  @override
  String get category_Education_YourCollege => 'Your college';

  @override
  String get category_Education_SchoolSupplies => 'School supplies';

  @override
  String get category_Education_Books => 'Books';

  @override
  String get category_Education_Tuition => 'Tuition';

  @override
  String get category_Education_Exams => 'Exams';

  @override
  String get category_Savings => 'Savings';

  @override
  String get category_Savings_EmergencyFund => 'Emergency fund';

  @override
  String get category_Savings_BigPurchases => 'Big purchases';

  @override
  String get category_Savings_OtherSavings => 'Other savings';

  @override
  String get category_GiftsDonations => 'Gifts/Donations';

  @override
  String get category_GiftsDonations_Birthday => 'Birthday';

  @override
  String get category_GiftsDonations_Anniversary => 'Anniversary';

  @override
  String get category_GiftsDonations_Wedding => 'Wedding';

  @override
  String get category_GiftsDonations_Christmas => 'Christmas';

  @override
  String get category_GiftsDonations_SpecialOccasion => 'Special occasion';

  @override
  String get category_GiftsDonations_Charities => 'Charities';

  @override
  String get category_GiftsDonations_Souvenir => 'Souvenir';

  @override
  String get category_Entertainment => 'Entertainment';

  @override
  String get category_Entertainment_AlcoholBars => 'Alcohol and/or bars';

  @override
  String get category_Entertainment_Games => 'Games';

  @override
  String get category_Entertainment_Movies => 'Movies';

  @override
  String get category_Entertainment_Concerts => 'Concerts';

  @override
  String get category_Entertainment_Vacations => 'Vacations';

  @override
  String get category_Entertainment_Subscriptions =>
      'Subscriptions (Netflix, Amazon, Hulu, etc.)';

  @override
  String get category_Entertainment_Other => 'Other Entertainment';

  @override
  String get category_Debt => 'Debt';

  @override
  String get category_Debt_CreditCard => 'Credit card';

  @override
  String get category_Debt_PersonalLoans => 'Personal loans';

  @override
  String get category_Debt_StudentLoans => 'Student loans';

  @override
  String get category_Debt_OtherDebtPayments => 'Other debt payments';

  @override
  String get category_Other => 'Other';

  @override
  String get category_Other_OtherExpenses => 'Other expenses';

  @override
  String get notSignedIn => 'You are not signed in';

  @override
  String get sessionTimeout => 'Session timeout';
}
