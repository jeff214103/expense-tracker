import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Tracker'**
  String get appTitle;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @categoryValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get categoryValidationError;

  /// No description provided for @expenseForm.
  ///
  /// In en, this message translates to:
  /// **'Expense Form'**
  String get expenseForm;

  /// No description provided for @processingReceiptWithAI.
  ///
  /// In en, this message translates to:
  /// **'Processing receipt with AI...'**
  String get processingReceiptWithAI;

  /// No description provided for @expenseSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The expense form has been submitted successfully.'**
  String get expenseSubmittedSuccessfully;

  /// No description provided for @submittingExpenseForm.
  ///
  /// In en, this message translates to:
  /// **'Submitting expense form...'**
  String get submittingExpenseForm;

  /// No description provided for @pleaseSelectReceiptImage.
  ///
  /// In en, this message translates to:
  /// **'Please select a receipt image'**
  String get pleaseSelectReceiptImage;

  /// No description provided for @pleaseEnterReceiptDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter the receipt date'**
  String get pleaseEnterReceiptDate;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @pleaseEnterItemName.
  ///
  /// In en, this message translates to:
  /// **'Please enter an item name'**
  String get pleaseEnterItemName;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @pleaseSelectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Please select the currency'**
  String get pleaseSelectCurrency;

  /// No description provided for @pleaseEnterPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter the price'**
  String get pleaseEnterPrice;

  /// No description provided for @pleaseEnterValidPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid price'**
  String get pleaseEnterValidPrice;

  /// No description provided for @chooseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Choose Currency'**
  String get chooseCurrency;

  /// No description provided for @uploadReceiptToGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Upload receipt to Google Drive'**
  String get uploadReceiptToGoogleDrive;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @pickTheReceipt.
  ///
  /// In en, this message translates to:
  /// **'Pick the receipt'**
  String get pickTheReceipt;

  /// No description provided for @noFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// No description provided for @finalPaymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Payment Amount in {currency}'**
  String finalPaymentAmount(Object currency);

  /// No description provided for @editAmount.
  ///
  /// In en, this message translates to:
  /// **'Edit Amount'**
  String get editAmount;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @expenseList.
  ///
  /// In en, this message translates to:
  /// **'Expense List'**
  String get expenseList;

  /// No description provided for @noSpreadsheetsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No spreadsheets available'**
  String get noSpreadsheetsAvailable;

  /// No description provided for @failedToLoadSpreadsheets.
  ///
  /// In en, this message translates to:
  /// **'Failed to load spreadsheets: {error}'**
  String failedToLoadSpreadsheets(Object error);

  /// No description provided for @failedToLoadExpenseData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load expense data: {error}'**
  String failedToLoadExpenseData(Object error);

  /// No description provided for @noExpenseRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No expense records found'**
  String get noExpenseRecordsFound;

  /// No description provided for @errorNotification.
  ///
  /// In en, this message translates to:
  /// **'Error notification'**
  String get errorNotification;

  /// No description provided for @anErrorOccurredWhileLoadingData.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading data'**
  String get anErrorOccurredWhileLoadingData;

  /// No description provided for @categorySummary.
  ///
  /// In en, this message translates to:
  /// **'Category Summary'**
  String get categorySummary;

  /// No description provided for @changeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Change Currency'**
  String get changeCurrency;

  /// No description provided for @totalExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Expense'**
  String get totalExpense;

  /// No description provided for @noDataForPieChart.
  ///
  /// In en, this message translates to:
  /// **'No data for pie chart'**
  String get noDataForPieChart;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @inputFinalPaymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Input your final payment amount in {currency}, and all calculation will be based on this amount and the setting currency.'**
  String inputFinalPaymentAmount(Object currency);

  /// No description provided for @finalAmountUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Final amount updated successfully'**
  String get finalAmountUpdatedSuccessfully;

  /// No description provided for @failedToUpdateFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Failed to update final amount'**
  String get failedToUpdateFinalAmount;

  /// No description provided for @errorUpdatingFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Error updating final amount: {error}'**
  String errorUpdatingFinalAmount(Object error);

  /// No description provided for @viewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View receipt'**
  String get viewReceipt;

  /// No description provided for @expenseRecord.
  ///
  /// In en, this message translates to:
  /// **'Expense record'**
  String get expenseRecord;

  /// No description provided for @expenseDetails.
  ///
  /// In en, this message translates to:
  /// **'Expense details'**
  String get expenseDetails;

  /// No description provided for @finalChargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Charge Amount'**
  String get finalChargeAmount;

  /// No description provided for @failedToLoadFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load file: {error}'**
  String failedToLoadFile(Object error);

  /// No description provided for @fileRemovedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'File removed successfully'**
  String get fileRemovedSuccessfully;

  /// No description provided for @failedToRemoveFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove file'**
  String get failedToRemoveFile;

  /// No description provided for @errorRemovingFile.
  ///
  /// In en, this message translates to:
  /// **'Error removing file: {error}'**
  String errorRemovingFile(Object error);

  /// No description provided for @removeFile.
  ///
  /// In en, this message translates to:
  /// **'Remove File'**
  String get removeFile;

  /// No description provided for @areYouSureYouWantToRemoveThisFile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this file?'**
  String get areYouSureYouWantToRemoveThisFile;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @noFileToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No file to display'**
  String get noFileToDisplay;

  /// No description provided for @failedToLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get failedToLoadImage;

  /// No description provided for @filePreview.
  ///
  /// In en, this message translates to:
  /// **'File Preview'**
  String get filePreview;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @exchangeRates.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rates'**
  String get exchangeRates;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @expenseTracker.
  ///
  /// In en, this message translates to:
  /// **'Expense Tracker'**
  String get expenseTracker;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @exchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeRate;

  /// No description provided for @monthlySummary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Summary'**
  String get monthlySummary;

  /// No description provided for @overspending.
  ///
  /// In en, this message translates to:
  /// **'Overspending'**
  String get overspending;

  /// No description provided for @monthlyUsable.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% of monthly usable'**
  String monthlyUsable(Object percentage);

  /// No description provided for @spending.
  ///
  /// In en, this message translates to:
  /// **'Spending'**
  String get spending;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @overConsumed.
  ///
  /// In en, this message translates to:
  /// **'Over consumed'**
  String get overConsumed;

  /// No description provided for @monthlyRemain.
  ///
  /// In en, this message translates to:
  /// **'{amount} left per day'**
  String monthlyRemain(Object amount);

  /// No description provided for @serviceAgreement.
  ///
  /// In en, this message translates to:
  /// **'Service Agreement'**
  String get serviceAgreement;

  /// No description provided for @serviceAgreementLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: January 2025'**
  String get serviceAgreementLastUpdated;

  /// No description provided for @acceptanceOfTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms'**
  String get acceptanceOfTermsTitle;

  /// No description provided for @acceptanceOfTermsDescription.
  ///
  /// In en, this message translates to:
  /// **'By accessing and using the Expense Tracker System, you agree to be bound by this Service Agreement. If you do not agree with any part of these terms, please refrain from using our services.'**
  String get acceptanceOfTermsDescription;

  /// No description provided for @servicesProvidedTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Services Provided'**
  String get servicesProvidedTitle;

  /// No description provided for @servicesProvidedDescription.
  ///
  /// In en, this message translates to:
  /// **'Our Expense Tracker System provides a secure and efficient way to manage your financial information. Key features include:'**
  String get servicesProvidedDescription;

  /// No description provided for @servicesProvidedSecureAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Secure authentication using Google Sign-In.'**
  String get servicesProvidedSecureAuthentication;

  /// No description provided for @servicesProvidedDataStorage.
  ///
  /// In en, this message translates to:
  /// **'Data storage in your personal Google Drive and management via Google Sheets.'**
  String get servicesProvidedDataStorage;

  /// No description provided for @servicesProvidedRealTimeTracking.
  ///
  /// In en, this message translates to:
  /// **'Real-time tracking and analysis of your expenses.'**
  String get servicesProvidedRealTimeTracking;

  /// No description provided for @servicesProvidedDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Services are provided on an \"as is\" basis without any express or implied warranties.'**
  String get servicesProvidedDisclaimer;

  /// No description provided for @userResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'3. User Responsibilities'**
  String get userResponsibilitiesTitle;

  /// No description provided for @userResponsibilitiesDescription.
  ///
  /// In en, this message translates to:
  /// **'Users are responsible for ensuring that all account information is accurate and up-to-date. You must maintain the confidentiality of your account credentials and abide by all applicable laws.'**
  String get userResponsibilitiesDescription;

  /// No description provided for @accountSecurityAndDataPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Account Security and Data Privacy'**
  String get accountSecurityAndDataPrivacyTitle;

  /// No description provided for @accountSecurityAndDataPrivacyDescription.
  ///
  /// In en, this message translates to:
  /// **'We employ Google Sign-In for secure authentication. Your financial data remains under your control and is securely stored within your Google services. It is your responsibility to keep your login details confidential.'**
  String get accountSecurityAndDataPrivacyDescription;

  /// No description provided for @intellectualPropertyRightsTitle.
  ///
  /// In en, this message translates to:
  /// **'5. Intellectual Property Rights'**
  String get intellectualPropertyRightsTitle;

  /// No description provided for @intellectualPropertyRightsDescription.
  ///
  /// In en, this message translates to:
  /// **'All content, features, and functionalities related to the Expense Tracker System— including software, design, text, and graphics—are the intellectual property of the developers. Unauthorized use, reproduction, or distribution is strictly prohibited.'**
  String get intellectualPropertyRightsDescription;

  /// No description provided for @limitationOfLiabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'6. Limitation of Liability'**
  String get limitationOfLiabilityTitle;

  /// No description provided for @limitationOfLiabilityDescription.
  ///
  /// In en, this message translates to:
  /// **'To the fullest extent permitted by law, neither the developers nor any affiliated parties shall be liable for any indirect, incidental, or consequential damages arising from the use of the Expense Tracker System. Your use of the service is at your own risk.'**
  String get limitationOfLiabilityDescription;

  /// No description provided for @changesToTheAgreementTitle.
  ///
  /// In en, this message translates to:
  /// **'7. Changes to the Agreement'**
  String get changesToTheAgreementTitle;

  /// No description provided for @changesToTheAgreementDescription.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify or update this Service Agreement at any time. It is your responsibility to review these terms periodically. Continued use of the service constitutes acceptance of any changes made to the agreement.'**
  String get changesToTheAgreementDescription;

  /// No description provided for @contactAndSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'8. Contact and Support'**
  String get contactAndSupportTitle;

  /// No description provided for @contactAndSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'For any questions or concerns regarding this Service Agreement, please contact our support team or reach out via our GitHub repository.'**
  String get contactAndSupportDescription;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: January 2025'**
  String get privacyPolicyLastUpdated;

  /// No description provided for @openSourceAndNonProfitMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Open Source and Non-Profit Mission'**
  String get openSourceAndNonProfitMissionTitle;

  /// No description provided for @openSourceAndNonProfitMissionDescription.
  ///
  /// In en, this message translates to:
  /// **'This application is an open-source, non-profit project dedicated to empowering users with personal financial tracking and analysis.'**
  String get openSourceAndNonProfitMissionDescription;

  /// No description provided for @dataCollectionAndUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Data Collection and Usage'**
  String get dataCollectionAndUsageTitle;

  /// No description provided for @dataCollectionAndUsageDescription.
  ///
  /// In en, this message translates to:
  /// **'We do not collect, store, or sell any personal information beyond what is necessary for the app\'s core functionality:'**
  String get dataCollectionAndUsageDescription;

  /// No description provided for @dataCollectionGoogleSignInBullet.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is used solely for authentication and accessing your personal Google Drive and Sheets'**
  String get dataCollectionGoogleSignInBullet;

  /// No description provided for @dataCollectionFinancialDataBullet.
  ///
  /// In en, this message translates to:
  /// **'Expense data is stored exclusively in your personal Google Drive and Sheets'**
  String get dataCollectionFinancialDataBullet;

  /// No description provided for @dataCollectionDataOwnershipBullet.
  ///
  /// In en, this message translates to:
  /// **'All data remains under your complete control and ownership'**
  String get dataCollectionDataOwnershipBullet;

  /// No description provided for @authenticationTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Authentication'**
  String get authenticationTitle;

  /// No description provided for @authenticationDescription.
  ///
  /// In en, this message translates to:
  /// **'The app uses Google Sign-In with the following limited scopes:'**
  String get authenticationDescription;

  /// No description provided for @authenticationEmailVerificationBullet.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get authenticationEmailVerificationBullet;

  /// No description provided for @authenticationGoogleDriveFileAccessBullet.
  ///
  /// In en, this message translates to:
  /// **'Google Drive file access'**
  String get authenticationGoogleDriveFileAccessBullet;

  /// No description provided for @dataStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Data Storage'**
  String get dataStorageTitle;

  /// No description provided for @dataStorageDescription.
  ///
  /// In en, this message translates to:
  /// **'Your expense records are:'**
  String get dataStorageDescription;

  /// No description provided for @dataStorageGoogleSpreadsheetBullet.
  ///
  /// In en, this message translates to:
  /// **'Stored in a personal Google Spreadsheet'**
  String get dataStorageGoogleSpreadsheetBullet;

  /// No description provided for @dataStorageManagedThroughGoogleAccountBullet.
  ///
  /// In en, this message translates to:
  /// **'Managed through your authenticated Google account'**
  String get dataStorageManagedThroughGoogleAccountBullet;

  /// No description provided for @dataStorageNotAccessibleByDevelopersBullet.
  ///
  /// In en, this message translates to:
  /// **'Not accessible by the app developers'**
  String get dataStorageNotAccessibleByDevelopersBullet;

  /// No description provided for @userControlTitle.
  ///
  /// In en, this message translates to:
  /// **'5. User Control'**
  String get userControlTitle;

  /// No description provided for @userControlDescription.
  ///
  /// In en, this message translates to:
  /// **'You have full control over your data:'**
  String get userControlDescription;

  /// No description provided for @userControlRevokeAppAccessBullet.
  ///
  /// In en, this message translates to:
  /// **'Revoke app access at any time through Google account settings'**
  String get userControlRevokeAppAccessBullet;

  /// No description provided for @userControlDeleteStoredFilesBullet.
  ///
  /// In en, this message translates to:
  /// **'Delete stored files directly from your Google Drive'**
  String get userControlDeleteStoredFilesBullet;

  /// No description provided for @userControlOptOutDataStorageBullet.
  ///
  /// In en, this message translates to:
  /// **'Opt-out of data storage by not using the app'**
  String get userControlOptOutDataStorageBullet;

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'6. Security'**
  String get securityTitle;

  /// No description provided for @securityDescription.
  ///
  /// In en, this message translates to:
  /// **'While we implement standard security practices, we recommend:'**
  String get securityDescription;

  /// No description provided for @securityStrongGoogleAccountCredentialsBullet.
  ///
  /// In en, this message translates to:
  /// **'Using strong Google account credentials'**
  String get securityStrongGoogleAccountCredentialsBullet;

  /// No description provided for @securityRegularlyReviewConnectedApplicationsBullet.
  ///
  /// In en, this message translates to:
  /// **'Regularly reviewing connected applications'**
  String get securityRegularlyReviewConnectedApplicationsBullet;

  /// No description provided for @openSourceTransparencyTitle.
  ///
  /// In en, this message translates to:
  /// **'7. Open Source Transparency'**
  String get openSourceTransparencyTitle;

  /// No description provided for @openSourceTransparencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Our complete source code is available for public review at our GitHub repository, ensuring full transparency in data handling.'**
  String get openSourceTransparencyDescription;

  /// No description provided for @contactAndFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'8. Contact and Feedback'**
  String get contactAndFeedbackTitle;

  /// No description provided for @contactAndFeedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'For any privacy-related inquiries or feedback, please open an issue on our GitHub repository.'**
  String get contactAndFeedbackDescription;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @currencySelectionHint.
  ///
  /// In en, this message translates to:
  /// **'You must choose the currency you use for your expenses. Click on this section to set it. You can always change it later.'**
  String get currencySelectionHint;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @currencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Default currency in calculations and reports'**
  String get currencyDescription;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @incomeDescription.
  ///
  /// In en, this message translates to:
  /// **'(OPTIONAL) Your monthly income ({currency}).'**
  String incomeDescription(Object currency);

  /// No description provided for @incomeHint.
  ///
  /// In en, this message translates to:
  /// **'Your monthly income ({currency}). It will store on your sheet setting.'**
  String incomeHint(Object currency);

  /// No description provided for @regularCost.
  ///
  /// In en, this message translates to:
  /// **'Regular Cost'**
  String get regularCost;

  /// No description provided for @regularCostDescription.
  ///
  /// In en, this message translates to:
  /// **'(OPTIONAL) Your monthly cost ({currency}) deducted from your income.'**
  String regularCostDescription(Object currency);

  /// No description provided for @regularCostHint.
  ///
  /// In en, this message translates to:
  /// **'Your monthly cost ({currency}) that deducted from your income. It will store on your sheet setting, not used anywhere else.'**
  String regularCostHint(Object currency);

  /// No description provided for @aiAssistance.
  ///
  /// In en, this message translates to:
  /// **'AI Assistance'**
  String get aiAssistance;

  /// No description provided for @selectGeminiModel.
  ///
  /// In en, this message translates to:
  /// **'Select Gemini Model'**
  String get selectGeminiModel;

  /// No description provided for @geminiApiKeyDescription.
  ///
  /// In en, this message translates to:
  /// **'OPTIONAL: To better use the application, you\'ll need a Gemini API key. If you don\'t already have one, create a key in Google AI Studio.'**
  String get geminiApiKeyDescription;

  /// No description provided for @geminiApiKeyAgreement.
  ///
  /// In en, this message translates to:
  /// **'By inputting your Gemini API key, you agree to the terms of service.'**
  String get geminiApiKeyAgreement;

  /// No description provided for @getAnApiKey.
  ///
  /// In en, this message translates to:
  /// **'Get an API Key'**
  String get getAnApiKey;

  /// No description provided for @geminiApiKey.
  ///
  /// In en, this message translates to:
  /// **'Gemini API Key'**
  String get geminiApiKey;

  /// No description provided for @geminiApiKeyConfig.
  ///
  /// In en, this message translates to:
  /// **'Configure your Gemini API access'**
  String get geminiApiKeyConfig;

  /// No description provided for @geminiModel.
  ///
  /// In en, this message translates to:
  /// **'Gemini Model'**
  String get geminiModel;

  /// No description provided for @geminiModelDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the AI model for assistance'**
  String get geminiModelDescription;

  /// No description provided for @enterApiKey.
  ///
  /// In en, this message translates to:
  /// **'Enter API Key'**
  String get enterApiKey;

  /// No description provided for @pleaseEnterValidApiKey.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid API key'**
  String get pleaseEnterValidApiKey;

  /// No description provided for @exchangeRatesDescription.
  ///
  /// In en, this message translates to:
  /// **'For every 1 USD, the app will compute based on the exchange rate from Google Finance. List of available currencies below.'**
  String get exchangeRatesDescription;

  /// No description provided for @noExchangeRatesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No exchange rates available'**
  String get noExchangeRatesAvailable;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @pleaseEnterValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get pleaseEnterValue;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @actionInProgress.
  ///
  /// In en, this message translates to:
  /// **'Action in progress...'**
  String get actionInProgress;

  /// No description provided for @geminiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer: AI features are optional and require a valid Gemini API key. Usage is subject to Google\'s terms of service.'**
  String get geminiDisclaimer;

  /// No description provided for @expenseTrackerSystem.
  ///
  /// In en, this message translates to:
  /// **'Expense Tracker System'**
  String get expenseTrackerSystem;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.1.4'**
  String get appVersion;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @appInformation.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInformation;

  /// No description provided for @authenticationError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error: {error}'**
  String authenticationError(Object error);

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'SUCCESS'**
  String get success;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @welcomePageHeader.
  ///
  /// In en, this message translates to:
  /// **'{header, select, welcome{Welcome} privacy{Privacy} input{Input} view{View} manage{Manage} author{Author} almostThere{Almost There} other{Unknown}}'**
  String welcomePageHeader(String header);

  /// No description provided for @welcomePageDescription.
  ///
  /// In en, this message translates to:
  /// **'{description, select, welcomeDescription{Welcome to your expense management app. Track your daily expenses efficiently.\n\nAdd this app to your home screen by following the steps in the link below:} privacyDescription{Your data privacy matters. Here\'s where your information is stored:\n\n1. Google Drive - Receipt images\n2. Google Sheets - Expense records, Exchange Rates, Settings\n\nNote: You are responsible for your device and Google account security. The app developer is not liable for any data breaches due to your security settings.} inputDescription{Getting started is easy! Scan your receipt, and if you\'ve set up Gemini, the information will be extracted automatically. You can review and adjust the details as needed.\n\nNo receipt? You can also input expenses manually.} viewDescription{Easily track your spending history. All amounts are shown in your preferred currency. Currency conversion rates are preset and may need manual updates.} manageDescription{The app creates a Google Sheet named \"Expense Record\" and a Google Drive folder called \"Expense History (Automated)\". You can find these files in your Google Drive. If you run out of space, you may need to delete them manually.} authorDescription{This project is open source on GitHub. Contributions are welcome! If you find this app helpful, consider supporting the developer with a coffee!} almostThereDescription{You\'re all set! Let\'s start managing your expenses.} other{Unknown}}'**
  String welcomePageDescription(String description);

  /// No description provided for @welcomePageLinkName.
  ///
  /// In en, this message translates to:
  /// **'{name, select, tutorialLink{Tutorial link} privacyPolicy{Privacy Policy} termsOfService{Terms of Service} github{GitHub} itdogtics{ITDOGTICS} aboutAuthor{About Author} other{Unknown}}'**
  String welcomePageLinkName(String name);

  /// No description provided for @pageIndicatorLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {index} indicator'**
  String pageIndicatorLabel(Object index);

  /// No description provided for @pageIndicatorHint.
  ///
  /// In en, this message translates to:
  /// **'Navigate to page {index}'**
  String pageIndicatorHint(Object index);

  /// No description provided for @skipTutorial.
  ///
  /// In en, this message translates to:
  /// **'Skip tutorial'**
  String get skipTutorial;

  /// No description provided for @skipTutorialHint.
  ///
  /// In en, this message translates to:
  /// **'Skip the welcome tutorial'**
  String get skipTutorialHint;

  /// No description provided for @goBackToFirstPage.
  ///
  /// In en, this message translates to:
  /// **'Go back to first page'**
  String get goBackToFirstPage;

  /// No description provided for @goBackToFirstPageHint.
  ///
  /// In en, this message translates to:
  /// **'Return to the first page of the tutorial'**
  String get goBackToFirstPageHint;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// No description provided for @nextPageHint.
  ///
  /// In en, this message translates to:
  /// **'Go to the next page'**
  String get nextPageHint;

  /// No description provided for @finishTutorial.
  ///
  /// In en, this message translates to:
  /// **'Finish tutorial'**
  String get finishTutorial;

  /// No description provided for @finishTutorialHint.
  ///
  /// In en, this message translates to:
  /// **'Complete the welcome tutorial'**
  String get finishTutorialHint;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @poweredByGoogleFinance.
  ///
  /// In en, this message translates to:
  /// **'Powered by Google Finance'**
  String get poweredByGoogleFinance;

  /// No description provided for @currencyExchange.
  ///
  /// In en, this message translates to:
  /// **'Currency Exchange'**
  String get currencyExchange;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @enterAmountToConvert.
  ///
  /// In en, this message translates to:
  /// **'Enter amount to convert'**
  String get enterAmountToConvert;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @selectTarget.
  ///
  /// In en, this message translates to:
  /// **'Select Target'**
  String get selectTarget;

  /// No description provided for @swapCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Swap Currencies'**
  String get swapCurrencies;

  /// No description provided for @convertedAmount.
  ///
  /// In en, this message translates to:
  /// **'Converted Amount'**
  String get convertedAmount;

  /// No description provided for @currencySelectionError.
  ///
  /// In en, this message translates to:
  /// **'Please select both source and target currencies'**
  String get currencySelectionError;

  /// No description provided for @invalidAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidAmountError;

  /// No description provided for @currencyConversionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to convert currency. Please try again.'**
  String get currencyConversionError;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred app language'**
  String get languageDescription;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @category_Housing.
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get category_Housing;

  /// No description provided for @category_Housing_MortgageRent.
  ///
  /// In en, this message translates to:
  /// **'Mortgage or rent'**
  String get category_Housing_MortgageRent;

  /// No description provided for @category_Housing_PropertyTaxes.
  ///
  /// In en, this message translates to:
  /// **'Property taxes'**
  String get category_Housing_PropertyTaxes;

  /// No description provided for @category_Housing_HouseholdRepairs.
  ///
  /// In en, this message translates to:
  /// **'Household repairs'**
  String get category_Housing_HouseholdRepairs;

  /// No description provided for @category_Housing_HOAFees.
  ///
  /// In en, this message translates to:
  /// **'HOA fees'**
  String get category_Housing_HOAFees;

  /// No description provided for @category_Transportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get category_Transportation;

  /// No description provided for @category_Transportation_PublicTransportation.
  ///
  /// In en, this message translates to:
  /// **'Public transportation'**
  String get category_Transportation_PublicTransportation;

  /// No description provided for @category_Transportation_TaxiUber.
  ///
  /// In en, this message translates to:
  /// **'Taxi/Uber'**
  String get category_Transportation_TaxiUber;

  /// No description provided for @category_Transportation_PrepaidCard.
  ///
  /// In en, this message translates to:
  /// **'Prepaid card'**
  String get category_Transportation_PrepaidCard;

  /// No description provided for @category_Transportation_CarPayment.
  ///
  /// In en, this message translates to:
  /// **'Car payment'**
  String get category_Transportation_CarPayment;

  /// No description provided for @category_Transportation_CarWarranty.
  ///
  /// In en, this message translates to:
  /// **'Car warranty'**
  String get category_Transportation_CarWarranty;

  /// No description provided for @category_Transportation_Gas.
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get category_Transportation_Gas;

  /// No description provided for @category_Transportation_Tires.
  ///
  /// In en, this message translates to:
  /// **'Tires'**
  String get category_Transportation_Tires;

  /// No description provided for @category_Transportation_MaintenanceOilChanges.
  ///
  /// In en, this message translates to:
  /// **'Maintenance and oil changes'**
  String get category_Transportation_MaintenanceOilChanges;

  /// No description provided for @category_Transportation_ParkingFees.
  ///
  /// In en, this message translates to:
  /// **'Parking fees'**
  String get category_Transportation_ParkingFees;

  /// No description provided for @category_Transportation_Repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get category_Transportation_Repairs;

  /// No description provided for @category_Transportation_RegistrationDMVFees.
  ///
  /// In en, this message translates to:
  /// **'Registration and DMV Fees'**
  String get category_Transportation_RegistrationDMVFees;

  /// No description provided for @category_Food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get category_Food;

  /// No description provided for @category_Food_Groceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get category_Food_Groceries;

  /// No description provided for @category_Food_Restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get category_Food_Restaurants;

  /// No description provided for @category_Food_Takeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get category_Food_Takeaway;

  /// No description provided for @category_Food_FromFriend.
  ///
  /// In en, this message translates to:
  /// **'From Friend'**
  String get category_Food_FromFriend;

  /// No description provided for @category_Food_StreetFood.
  ///
  /// In en, this message translates to:
  /// **'Street food'**
  String get category_Food_StreetFood;

  /// No description provided for @category_Food_Delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get category_Food_Delivery;

  /// No description provided for @category_Food_PetFood.
  ///
  /// In en, this message translates to:
  /// **'Pet food'**
  String get category_Food_PetFood;

  /// No description provided for @category_Utilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get category_Utilities;

  /// No description provided for @category_Utilities_Electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get category_Utilities_Electricity;

  /// No description provided for @category_Utilities_Water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get category_Utilities_Water;

  /// No description provided for @category_Utilities_Garbage.
  ///
  /// In en, this message translates to:
  /// **'Garbage'**
  String get category_Utilities_Garbage;

  /// No description provided for @category_Utilities_Phones.
  ///
  /// In en, this message translates to:
  /// **'Phones'**
  String get category_Utilities_Phones;

  /// No description provided for @category_Utilities_Cable.
  ///
  /// In en, this message translates to:
  /// **'Cable'**
  String get category_Utilities_Cable;

  /// No description provided for @category_Utilities_Internet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get category_Utilities_Internet;

  /// No description provided for @category_Clothing.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get category_Clothing;

  /// No description provided for @category_Clothing_AdultsClothing.
  ///
  /// In en, this message translates to:
  /// **'Adults\' clothing'**
  String get category_Clothing_AdultsClothing;

  /// No description provided for @category_Clothing_AdultsShoes.
  ///
  /// In en, this message translates to:
  /// **'Adults\' shoes'**
  String get category_Clothing_AdultsShoes;

  /// No description provided for @category_Clothing_ChildrensClothing.
  ///
  /// In en, this message translates to:
  /// **'Children\'s clothing'**
  String get category_Clothing_ChildrensClothing;

  /// No description provided for @category_Clothing_ChildrensShoes.
  ///
  /// In en, this message translates to:
  /// **'Children\'s shoes'**
  String get category_Clothing_ChildrensShoes;

  /// No description provided for @category_MedicalHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Medical/Healthcare'**
  String get category_MedicalHealthcare;

  /// No description provided for @category_MedicalHealthcare_PrimaryCare.
  ///
  /// In en, this message translates to:
  /// **'Primary care'**
  String get category_MedicalHealthcare_PrimaryCare;

  /// No description provided for @category_MedicalHealthcare_DentalCare.
  ///
  /// In en, this message translates to:
  /// **'Dental care'**
  String get category_MedicalHealthcare_DentalCare;

  /// No description provided for @category_MedicalHealthcare_SpecialtyCare.
  ///
  /// In en, this message translates to:
  /// **'Specialty care'**
  String get category_MedicalHealthcare_SpecialtyCare;

  /// No description provided for @category_MedicalHealthcare_UrgentCare.
  ///
  /// In en, this message translates to:
  /// **'Urgent care'**
  String get category_MedicalHealthcare_UrgentCare;

  /// No description provided for @category_MedicalHealthcare_Medications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get category_MedicalHealthcare_Medications;

  /// No description provided for @category_MedicalHealthcare_MedicalDevices.
  ///
  /// In en, this message translates to:
  /// **'Medical devices'**
  String get category_MedicalHealthcare_MedicalDevices;

  /// No description provided for @category_Insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get category_Insurance;

  /// No description provided for @category_Insurance_HealthInsurance.
  ///
  /// In en, this message translates to:
  /// **'Health insurance'**
  String get category_Insurance_HealthInsurance;

  /// No description provided for @category_Insurance_HomeownerRentersInsurance.
  ///
  /// In en, this message translates to:
  /// **'Homeowner\'s or renter\'s insurance'**
  String get category_Insurance_HomeownerRentersInsurance;

  /// No description provided for @category_Insurance_HomeWarrantyProtectionPlan.
  ///
  /// In en, this message translates to:
  /// **'Home warranty or protection plan'**
  String get category_Insurance_HomeWarrantyProtectionPlan;

  /// No description provided for @category_Insurance_AutoInsurance.
  ///
  /// In en, this message translates to:
  /// **'Auto insurance'**
  String get category_Insurance_AutoInsurance;

  /// No description provided for @category_Insurance_LifeInsurance.
  ///
  /// In en, this message translates to:
  /// **'Life insurance'**
  String get category_Insurance_LifeInsurance;

  /// No description provided for @category_Insurance_DisabilityInsurance.
  ///
  /// In en, this message translates to:
  /// **'Disability insurance'**
  String get category_Insurance_DisabilityInsurance;

  /// No description provided for @category_HouseholdItemsSupplies.
  ///
  /// In en, this message translates to:
  /// **'Household Items/Supplies'**
  String get category_HouseholdItemsSupplies;

  /// No description provided for @category_HouseholdItemsSupplies_Toiletries.
  ///
  /// In en, this message translates to:
  /// **'Toiletries'**
  String get category_HouseholdItemsSupplies_Toiletries;

  /// No description provided for @category_HouseholdItemsSupplies_LaundryDetergent.
  ///
  /// In en, this message translates to:
  /// **'Laundry detergent'**
  String get category_HouseholdItemsSupplies_LaundryDetergent;

  /// No description provided for @category_HouseholdItemsSupplies_DishwasherDetergent.
  ///
  /// In en, this message translates to:
  /// **'Dishwasher detergent'**
  String get category_HouseholdItemsSupplies_DishwasherDetergent;

  /// No description provided for @category_HouseholdItemsSupplies_CleaningSupplies.
  ///
  /// In en, this message translates to:
  /// **'Cleaning supplies'**
  String get category_HouseholdItemsSupplies_CleaningSupplies;

  /// No description provided for @category_HouseholdItemsSupplies_Tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get category_HouseholdItemsSupplies_Tools;

  /// No description provided for @category_Personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get category_Personal;

  /// No description provided for @category_Personal_GymMemberships.
  ///
  /// In en, this message translates to:
  /// **'Gym memberships'**
  String get category_Personal_GymMemberships;

  /// No description provided for @category_Personal_Haircuts.
  ///
  /// In en, this message translates to:
  /// **'Haircuts'**
  String get category_Personal_Haircuts;

  /// No description provided for @category_Personal_SalonServices.
  ///
  /// In en, this message translates to:
  /// **'Salon services'**
  String get category_Personal_SalonServices;

  /// No description provided for @category_Personal_Cosmetics.
  ///
  /// In en, this message translates to:
  /// **'Cosmetics'**
  String get category_Personal_Cosmetics;

  /// No description provided for @category_Personal_Babysitter.
  ///
  /// In en, this message translates to:
  /// **'Babysitter'**
  String get category_Personal_Babysitter;

  /// No description provided for @category_Personal_Subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get category_Personal_Subscriptions;

  /// No description provided for @category_Education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get category_Education;

  /// No description provided for @category_Education_ChildrenCollege.
  ///
  /// In en, this message translates to:
  /// **'Children\'s college'**
  String get category_Education_ChildrenCollege;

  /// No description provided for @category_Education_YourCollege.
  ///
  /// In en, this message translates to:
  /// **'Your college'**
  String get category_Education_YourCollege;

  /// No description provided for @category_Education_SchoolSupplies.
  ///
  /// In en, this message translates to:
  /// **'School supplies'**
  String get category_Education_SchoolSupplies;

  /// No description provided for @category_Education_Books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get category_Education_Books;

  /// No description provided for @category_Education_Tuition.
  ///
  /// In en, this message translates to:
  /// **'Tuition'**
  String get category_Education_Tuition;

  /// No description provided for @category_Education_Exams.
  ///
  /// In en, this message translates to:
  /// **'Exams'**
  String get category_Education_Exams;

  /// No description provided for @category_Savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get category_Savings;

  /// No description provided for @category_Savings_EmergencyFund.
  ///
  /// In en, this message translates to:
  /// **'Emergency fund'**
  String get category_Savings_EmergencyFund;

  /// No description provided for @category_Savings_BigPurchases.
  ///
  /// In en, this message translates to:
  /// **'Big purchases'**
  String get category_Savings_BigPurchases;

  /// No description provided for @category_Savings_OtherSavings.
  ///
  /// In en, this message translates to:
  /// **'Other savings'**
  String get category_Savings_OtherSavings;

  /// No description provided for @category_GiftsDonations.
  ///
  /// In en, this message translates to:
  /// **'Gifts/Donations'**
  String get category_GiftsDonations;

  /// No description provided for @category_GiftsDonations_Birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get category_GiftsDonations_Birthday;

  /// No description provided for @category_GiftsDonations_Anniversary.
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get category_GiftsDonations_Anniversary;

  /// No description provided for @category_GiftsDonations_Wedding.
  ///
  /// In en, this message translates to:
  /// **'Wedding'**
  String get category_GiftsDonations_Wedding;

  /// No description provided for @category_GiftsDonations_Christmas.
  ///
  /// In en, this message translates to:
  /// **'Christmas'**
  String get category_GiftsDonations_Christmas;

  /// No description provided for @category_GiftsDonations_SpecialOccasion.
  ///
  /// In en, this message translates to:
  /// **'Special occasion'**
  String get category_GiftsDonations_SpecialOccasion;

  /// No description provided for @category_GiftsDonations_Charities.
  ///
  /// In en, this message translates to:
  /// **'Charities'**
  String get category_GiftsDonations_Charities;

  /// No description provided for @category_GiftsDonations_Souvenir.
  ///
  /// In en, this message translates to:
  /// **'Souvenir'**
  String get category_GiftsDonations_Souvenir;

  /// No description provided for @category_Entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get category_Entertainment;

  /// No description provided for @category_Entertainment_AlcoholBars.
  ///
  /// In en, this message translates to:
  /// **'Alcohol and/or bars'**
  String get category_Entertainment_AlcoholBars;

  /// No description provided for @category_Entertainment_Games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get category_Entertainment_Games;

  /// No description provided for @category_Entertainment_Movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get category_Entertainment_Movies;

  /// No description provided for @category_Entertainment_Concerts.
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get category_Entertainment_Concerts;

  /// No description provided for @category_Entertainment_Vacations.
  ///
  /// In en, this message translates to:
  /// **'Vacations'**
  String get category_Entertainment_Vacations;

  /// No description provided for @category_Entertainment_Subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions (Netflix, Amazon, Hulu, etc.)'**
  String get category_Entertainment_Subscriptions;

  /// No description provided for @category_Entertainment_Other.
  ///
  /// In en, this message translates to:
  /// **'Other Entertainment'**
  String get category_Entertainment_Other;

  /// No description provided for @category_Debt.
  ///
  /// In en, this message translates to:
  /// **'Debt'**
  String get category_Debt;

  /// No description provided for @category_Debt_CreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get category_Debt_CreditCard;

  /// No description provided for @category_Debt_PersonalLoans.
  ///
  /// In en, this message translates to:
  /// **'Personal loans'**
  String get category_Debt_PersonalLoans;

  /// No description provided for @category_Debt_StudentLoans.
  ///
  /// In en, this message translates to:
  /// **'Student loans'**
  String get category_Debt_StudentLoans;

  /// No description provided for @category_Debt_OtherDebtPayments.
  ///
  /// In en, this message translates to:
  /// **'Other debt payments'**
  String get category_Debt_OtherDebtPayments;

  /// No description provided for @category_Other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_Other;

  /// No description provided for @category_Other_OtherExpenses.
  ///
  /// In en, this message translates to:
  /// **'Other expenses'**
  String get category_Other_OtherExpenses;

  /// No description provided for @notSignedIn.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in'**
  String get notSignedIn;

  /// No description provided for @sessionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Session timeout'**
  String get sessionTimeout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
