// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '開銷追蹤器';

  @override
  String get categoryLabel => '類別';

  @override
  String get categoryValidationError => '請選擇一個類別';

  @override
  String get expenseForm => '開銷表單';

  @override
  String get processingReceiptWithAI => '正在使用 AI 處理收據...';

  @override
  String get expenseSubmittedSuccessfully => '開銷表單已成功提交。';

  @override
  String get submittingExpenseForm => '正在提交開銷表單...';

  @override
  String get pleaseSelectReceiptImage => '請選擇收據圖片';

  @override
  String get pleaseEnterReceiptDate => '請輸入收據日期';

  @override
  String get date => '日期';

  @override
  String get itemName => '項目名稱';

  @override
  String get pleaseEnterItemName => '請輸入項目名稱';

  @override
  String get pleaseSelectCategory => '請選擇一個類別';

  @override
  String get price => '價格';

  @override
  String get pleaseSelectCurrency => '請選擇貨幣';

  @override
  String get pleaseEnterPrice => '請輸入價格';

  @override
  String get pleaseEnterValidPrice => '請輸入有效的價格';

  @override
  String get chooseCurrency => '選擇貨幣';

  @override
  String get uploadReceiptToGoogleDrive => '上傳收據至 Google 雲端硬碟';

  @override
  String get submit => '提交';

  @override
  String get pickTheReceipt => '選取收據';

  @override
  String get noFileSelected => '未選擇檔案';

  @override
  String finalPaymentAmount(Object currency) {
    return '最終付款金額 ($currency)';
  }

  @override
  String get editAmount => '編輯金額';

  @override
  String get cancel => '取消';

  @override
  String get save => '儲存';

  @override
  String get expenseList => '開銷列表';

  @override
  String get noSpreadsheetsAvailable => '沒有可用的試算表';

  @override
  String failedToLoadSpreadsheets(Object error) {
    return '載入試算表失敗：$error';
  }

  @override
  String failedToLoadExpenseData(Object error) {
    return '載入開銷數據失敗：$error';
  }

  @override
  String get noExpenseRecordsFound => '找不到開銷記錄';

  @override
  String get errorNotification => '錯誤通知';

  @override
  String get anErrorOccurredWhileLoadingData => '載入數據時發生錯誤';

  @override
  String get categorySummary => '類別摘要';

  @override
  String get changeCurrency => '更改貨幣';

  @override
  String get totalExpense => '總開銷';

  @override
  String get noDataForPieChart => '沒有用於圓餅圖的數據';

  @override
  String get selectMonth => '選擇月份';

  @override
  String inputFinalPaymentAmount(Object currency) {
    return '請輸入您的最終付款金額 ($currency)，所有計算將基於此金額和設定的貨幣。';
  }

  @override
  String get finalAmountUpdatedSuccessfully => '最終金額更新成功';

  @override
  String get failedToUpdateFinalAmount => '更新最終金額失敗';

  @override
  String errorUpdatingFinalAmount(Object error) {
    return '更新最終金額時出錯：$error';
  }

  @override
  String get viewReceipt => '查看收據';

  @override
  String get expenseRecord => '開銷記錄';

  @override
  String get expenseDetails => '開銷詳情';

  @override
  String get finalChargeAmount => '最終收費金額';

  @override
  String failedToLoadFile(Object error) {
    return '載入檔案失敗：$error';
  }

  @override
  String get fileRemovedSuccessfully => '檔案移除成功';

  @override
  String get failedToRemoveFile => '移除檔案失敗';

  @override
  String errorRemovingFile(Object error) {
    return '移除檔案時出錯：$error';
  }

  @override
  String get removeFile => '移除檔案';

  @override
  String get areYouSureYouWantToRemoveThisFile => '您確定要移除此檔案嗎？';

  @override
  String get remove => '移除';

  @override
  String get noFileToDisplay => '沒有可顯示的檔案';

  @override
  String get failedToLoadImage => '載入圖片失敗';

  @override
  String get filePreview => '檔案預覽';

  @override
  String get close => '關閉';

  @override
  String get dashboard => '儀表板';

  @override
  String get settings => '設定';

  @override
  String get signOut => '登出';

  @override
  String get exchangeRates => '匯率';

  @override
  String get signIn => '登入';

  @override
  String get expenseTracker => '開銷追蹤器';

  @override
  String get help => '說明';

  @override
  String get logout => '登出';

  @override
  String get hello => '哈囉';

  @override
  String get welcomeBack => '歡迎回來';

  @override
  String get add => '新增';

  @override
  String get view => '查看';

  @override
  String get setting => '設定';

  @override
  String get exchangeRate => '匯率';

  @override
  String get monthlySummary => '每月摘要';

  @override
  String get overspending => '超支';

  @override
  String monthlyUsable(Object percentage) {
    return '佔可用開支 $percentage%';
  }

  @override
  String get spending => '花費';

  @override
  String get remaining => '剩餘';

  @override
  String get overConsumed => '超額消費';

  @override
  String monthlyRemain(Object amount) {
    return '平均每天剩下 $amount';
  }

  @override
  String get serviceAgreement => '服務協議';

  @override
  String get serviceAgreementLastUpdated => '最後更新：2025 年 1 月';

  @override
  String get acceptanceOfTermsTitle => '1. 接受條款';

  @override
  String get acceptanceOfTermsDescription =>
      '透過存取和使用開銷追蹤系統，即表示您同意受本服務協議的約束。如果您不同意這些條款的任何部分，請勿使用我們的服務。';

  @override
  String get servicesProvidedTitle => '2. 提供的服務';

  @override
  String get servicesProvidedDescription =>
      '我們的開銷追蹤系統提供安全有效的方式來管理您的財務資訊。主要功能包括：';

  @override
  String get servicesProvidedSecureAuthentication => '使用 Google 登入進行安全驗證。';

  @override
  String get servicesProvidedDataStorage =>
      '將數據儲存在您的個人 Google 雲端硬碟中，並透過 Google 試算表進行管理。';

  @override
  String get servicesProvidedRealTimeTracking => '即時追蹤和分析您的開銷。';

  @override
  String get servicesProvidedDisclaimer => '服務按「現狀」提供，不含任何明示或暗示的保證。';

  @override
  String get userResponsibilitiesTitle => '3. 使用者責任';

  @override
  String get userResponsibilitiesDescription =>
      '使用者有責任確保所有帳戶資訊準確且最新。您必須維護帳戶憑證的機密性並遵守所有適用法律。';

  @override
  String get accountSecurityAndDataPrivacyTitle => '4. 帳戶安全與數據隱私';

  @override
  String get accountSecurityAndDataPrivacyDescription =>
      '我們使用 Google 登入進行安全驗證。您的財務數據仍在您的控制之下，並安全地儲存在您的 Google 服務中。您有責任對您的登入詳細資訊保密。';

  @override
  String get intellectualPropertyRightsTitle => '5. 智慧財產權';

  @override
  String get intellectualPropertyRightsDescription =>
      '與開銷追蹤系統相關的所有內容、功能——包括軟體、設計、文字和圖形——均為開發者的智慧財產。嚴禁未經授權的使用、複製或分發。';

  @override
  String get limitationOfLiabilityTitle => '6. 責任限制';

  @override
  String get limitationOfLiabilityDescription =>
      '在法律允許的最大範圍內，開發者或任何關聯方均不對因使用開銷追蹤系統而產生的任何間接、附帶或後果性損害負責。您使用本服務的風險由您自行承擔。';

  @override
  String get changesToTheAgreementTitle => '7. 協議變更';

  @override
  String get changesToTheAgreementDescription =>
      '我們保留隨時修改或更新本服務協議的權利。您有責任定期查看這些條款。繼續使用本服務即表示接受對協議所做的任何更改。';

  @override
  String get contactAndSupportTitle => '8. 聯絡與支援';

  @override
  String get contactAndSupportDescription =>
      '如有任何關於本服務協議的問題或疑慮，請聯繫我們的支援團隊或透過我們的 GitHub 儲存庫與我們聯繫。';

  @override
  String get privacyPolicy => '隱私政策';

  @override
  String get privacyPolicyLastUpdated => '最後更新：2025 年 1 月';

  @override
  String get openSourceAndNonProfitMissionTitle => '1. 開源與非營利使命';

  @override
  String get openSourceAndNonProfitMissionDescription =>
      '本應用程式是一個開源、非營利的專案，致力於讓使用者能夠進行個人財務追蹤和分析。';

  @override
  String get dataCollectionAndUsageTitle => '2. 數據收集與使用';

  @override
  String get dataCollectionAndUsageDescription =>
      '除了應用程式核心功能所必需的資訊外，我們不收集、儲存或出售任何個人資訊：';

  @override
  String get dataCollectionGoogleSignInBullet =>
      'Google 登入僅用於驗證和存取您的個人 Google 雲端硬碟和試算表';

  @override
  String get dataCollectionFinancialDataBullet =>
      '開銷數據僅儲存在您的個人 Google 雲端硬碟和試算表中';

  @override
  String get dataCollectionDataOwnershipBullet => '所有數據完全由您控制和擁有';

  @override
  String get authenticationTitle => '3. 驗證';

  @override
  String get authenticationDescription => '本應用程式使用具有以下有限範圍的 Google 登入：';

  @override
  String get authenticationEmailVerificationBullet => '電子郵件驗證';

  @override
  String get authenticationGoogleDriveFileAccessBullet => 'Google 雲端硬碟檔案存取權';

  @override
  String get dataStorageTitle => '4. 數據儲存';

  @override
  String get dataStorageDescription => '您的開銷記錄：';

  @override
  String get dataStorageGoogleSpreadsheetBullet => '儲存在個人 Google 試算表中';

  @override
  String get dataStorageManagedThroughGoogleAccountBullet =>
      '透過您已驗證的 Google 帳戶管理';

  @override
  String get dataStorageNotAccessibleByDevelopersBullet => '應用程式開發者無法存取';

  @override
  String get userControlTitle => '5. 使用者控制權';

  @override
  String get userControlDescription => '您對自己的數據擁有完全控制權：';

  @override
  String get userControlRevokeAppAccessBullet => '隨時透過 Google 帳戶設定撤銷應用程式存取權';

  @override
  String get userControlDeleteStoredFilesBullet => '直接從您的 Google 雲端硬碟刪除儲存的檔案';

  @override
  String get userControlOptOutDataStorageBullet => '透過不使用應用程式選擇退出數據儲存';

  @override
  String get securityTitle => '6. 安全性';

  @override
  String get securityDescription => '雖然我們實施標準的安全措施，但我們建議：';

  @override
  String get securityStrongGoogleAccountCredentialsBullet => '使用強式 Google 帳戶憑證';

  @override
  String get securityRegularlyReviewConnectedApplicationsBullet =>
      '定期檢視已連接的應用程式';

  @override
  String get openSourceTransparencyTitle => '7. 開源透明度';

  @override
  String get openSourceTransparencyDescription =>
      '我們的完整原始碼可在我們的 GitHub 儲存庫公開審閱，確保數據處理的完全透明。';

  @override
  String get contactAndFeedbackTitle => '8. 聯絡與回饋';

  @override
  String get contactAndFeedbackDescription =>
      '如有任何與隱私相關的查詢或回饋，請在我們的 GitHub 儲存庫中提出問題。';

  @override
  String get general => '一般';

  @override
  String get currencySelectionHint => '您必須選擇用於開銷的貨幣。點擊此部分進行設定。您可以稍後隨時更改。';

  @override
  String get currency => '貨幣';

  @override
  String get currencyDescription => '計算和報告中的預設貨幣';

  @override
  String get notSet => '未設定';

  @override
  String get income => '收入';

  @override
  String incomeDescription(Object currency) {
    return '(選填) 您的每月收入 ($currency)。';
  }

  @override
  String incomeHint(Object currency) {
    return '您的每月收入 ($currency)。它將儲存在您的試算表設定中。';
  }

  @override
  String get regularCost => '固定成本';

  @override
  String regularCostDescription(Object currency) {
    return '(選填) 從您收入中扣除的每月成本 ($currency)。';
  }

  @override
  String regularCostHint(Object currency) {
    return '從您收入中扣除的每月成本 ($currency)。它將儲存在您的試算表設定中，不會在其他地方使用。';
  }

  @override
  String get aiAssistance => 'AI 協助';

  @override
  String get selectGeminiModel => '選擇 Gemini 模型';

  @override
  String get geminiApiKeyDescription =>
      '選填：為了更好地使用本應用程式，您需要一個 Gemini API 金鑰。如果您還沒有，請在 Google AI Studio 中建立一個金鑰。';

  @override
  String get geminiApiKeyAgreement => '輸入您的 Gemini API 金鑰即表示您同意服務條款。';

  @override
  String get getAnApiKey => '取得 API 金鑰';

  @override
  String get geminiApiKey => 'Gemini API 金鑰';

  @override
  String get geminiApiKeyConfig => '設定您的 Gemini API 存取權限';

  @override
  String get geminiModel => 'Gemini 模型';

  @override
  String get geminiModelDescription => '選擇用於協助的 AI 模型';

  @override
  String get enterApiKey => '輸入 API 金鑰';

  @override
  String get pleaseEnterValidApiKey => '請輸入有效的 API 金鑰';

  @override
  String get exchangeRatesDescription =>
      '對於每 1 美元，應用程式將根據 Google Finance 的匯率進行計算。可用貨幣列表如下。';

  @override
  String get noExchangeRatesAvailable => '沒有可用的匯率';

  @override
  String get update => '更新';

  @override
  String get pleaseEnterValue => '請輸入數值';

  @override
  String get pleaseEnterValidNumber => '請輸入有效的數字';

  @override
  String get getStarted => '開始使用';

  @override
  String get actionInProgress => '操作進行中...';

  @override
  String get geminiDisclaimer =>
      '免責聲明：AI 功能為選用，且需要有效的 Gemini API 金鑰。使用受 Google 服務條款約束。';

  @override
  String get expenseTrackerSystem => '開銷追蹤系統';

  @override
  String get appVersion => '版本 1.1.4';

  @override
  String get signInWithGoogle => '使用 Google 登入';

  @override
  String get appInformation => '程式資訊';

  @override
  String authenticationError(Object error) {
    return '驗證錯誤：$error';
  }

  @override
  String get success => '成功';

  @override
  String get done => '完成';

  @override
  String welcomePageHeader(String header) {
    String _temp0 = intl.Intl.selectLogic(
      header,
      {
        'welcome': '歡迎',
        'privacy': '隱私',
        'input': '輸入',
        'view': '查看',
        'manage': '管理',
        'author': '作者',
        'almostThere': '即將完成',
        'other': '未知',
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
            '歡迎使用您的開銷管理應用程式。有效率地追蹤您的日常開銷。\n\n請依照下方連結中的步驟將此應用程式新增至您的主畫面：',
        'privacyDescription':
            '您的數據隱私至關重要。以下是您的資訊儲存位置：\n\n1. Google 雲端硬碟 - 收據圖片\n2. Google 試算表 - 開銷記錄、匯率、設定\n\n注意：您有責任保護您的裝置和 Google 帳戶安全。應用程式開發者對因您的安全設定導致的任何數據洩露概不負責。',
        'inputDescription':
            '開始使用很簡單！掃描您的收據，如果您已設定 Gemini，資訊將自動擷取。您可以根據需要檢視和調整詳細資訊。\n\n沒有收據？您也可以手動輸入開銷。',
        'viewDescription': '輕鬆追蹤您的消費記錄。所有金額均以您偏好的貨幣顯示。貨幣轉換率是預設的，可能需要手動更新。',
        'manageDescription':
            '此應用程式會建立一個名為「Expense Record」的 Google 試算表和一個名為「Expense History (Automated)」的 Google 雲端硬碟資料夾。您可以在您的 Google 雲端硬碟中找到這些檔案。如果空間不足，您可能需要手動刪除它們。',
        'authorDescription':
            '此專案在 GitHub 上開源。歡迎貢獻！如果您覺得此應用程式有幫助，請考慮請開發者喝杯咖啡以示支持！',
        'almostThereDescription': '您已準備就緒！讓我們開始管理您的開銷吧。',
        'other': '未知',
      },
    );
    return '$_temp0';
  }

  @override
  String welcomePageLinkName(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'tutorialLink': '教學連結',
        'privacyPolicy': '隱私政策',
        'termsOfService': '服務條款',
        'github': 'GitHub',
        'itdogtics': 'ITDOGTICS',
        'aboutAuthor': '關於作者',
        'other': '未知',
      },
    );
    return '$_temp0';
  }

  @override
  String pageIndicatorLabel(Object index) {
    return '第 $index 頁指示器';
  }

  @override
  String pageIndicatorHint(Object index) {
    return '導覽至第 $index 頁';
  }

  @override
  String get skipTutorial => '略過教學';

  @override
  String get skipTutorialHint => '略過歡迎教學';

  @override
  String get goBackToFirstPage => '返回第一頁';

  @override
  String get goBackToFirstPageHint => '返回教學的第一頁';

  @override
  String get nextPage => '下一頁';

  @override
  String get nextPageHint => '前往下一頁';

  @override
  String get finishTutorial => '完成教學';

  @override
  String get finishTutorialHint => '完成歡迎教學';

  @override
  String get skip => '略過';

  @override
  String get next => '下一步';

  @override
  String get go => '前往';

  @override
  String get back => '返回';

  @override
  String get poweredByGoogleFinance => '由 Google Finance 提供技術支援';

  @override
  String get currencyExchange => '貨幣兌換';

  @override
  String get amount => '金額';

  @override
  String get enterAmountToConvert => '輸入要轉換的金額';

  @override
  String get select => '選擇';

  @override
  String get selectTarget => '選擇目標貨幣';

  @override
  String get swapCurrencies => '交換貨幣';

  @override
  String get convertedAmount => '轉換後金額';

  @override
  String get currencySelectionError => '請同時選擇來源和目標貨幣';

  @override
  String get invalidAmountError => '請輸入有效的金額';

  @override
  String get currencyConversionError => '貨幣轉換失敗。請再試一次。';

  @override
  String get language => '語言';

  @override
  String get languageDescription => '選擇您偏好的應用程式語言';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get category_Housing => '房屋';

  @override
  String get category_Housing_MortgageRent => '按揭或租金';

  @override
  String get category_Housing_PropertyTaxes => '物業稅';

  @override
  String get category_Housing_HouseholdRepairs => '家庭維修';

  @override
  String get category_Housing_HOAFees => '物業管理費';

  @override
  String get category_Transportation => '交通';

  @override
  String get category_Transportation_PublicTransportation => '公共交通';

  @override
  String get category_Transportation_TaxiUber => '計程車/網約車';

  @override
  String get category_Transportation_PrepaidCard => '預付卡';

  @override
  String get category_Transportation_CarPayment => '汽車貸款';

  @override
  String get category_Transportation_CarWarranty => '汽車保固';

  @override
  String get category_Transportation_Gas => '汽油';

  @override
  String get category_Transportation_Tires => '輪胎';

  @override
  String get category_Transportation_MaintenanceOilChanges => '保養及更換機油';

  @override
  String get category_Transportation_ParkingFees => '停車費';

  @override
  String get category_Transportation_Repairs => '維修';

  @override
  String get category_Transportation_RegistrationDMVFees => '註冊及牌照費';

  @override
  String get category_Food => '食物';

  @override
  String get category_Food_Groceries => '日常食品';

  @override
  String get category_Food_Restaurants => '餐廳';

  @override
  String get category_Food_Takeaway => '外賣';

  @override
  String get category_Food_FromFriend => '朋友招待';

  @override
  String get category_Food_StreetFood => '街頭小吃';

  @override
  String get category_Food_Delivery => '外送';

  @override
  String get category_Food_PetFood => '寵物食品';

  @override
  String get category_Utilities => '水電雜費';

  @override
  String get category_Utilities_Electricity => '電費';

  @override
  String get category_Utilities_Water => '水費';

  @override
  String get category_Utilities_Garbage => '垃圾處理費';

  @override
  String get category_Utilities_Phones => '電話費';

  @override
  String get category_Utilities_Cable => '有線電視費';

  @override
  String get category_Utilities_Internet => '網絡費';

  @override
  String get category_Clothing => '服裝';

  @override
  String get category_Clothing_AdultsClothing => '成人服裝';

  @override
  String get category_Clothing_AdultsShoes => '成人鞋履';

  @override
  String get category_Clothing_ChildrensClothing => '兒童服裝';

  @override
  String get category_Clothing_ChildrensShoes => '兒童鞋履';

  @override
  String get category_MedicalHealthcare => '醫療保健';

  @override
  String get category_MedicalHealthcare_PrimaryCare => '基層醫療';

  @override
  String get category_MedicalHealthcare_DentalCare => '牙科護理';

  @override
  String get category_MedicalHealthcare_SpecialtyCare => '專科護理';

  @override
  String get category_MedicalHealthcare_UrgentCare => '緊急護理';

  @override
  String get category_MedicalHealthcare_Medications => '藥物';

  @override
  String get category_MedicalHealthcare_MedicalDevices => '醫療器材';

  @override
  String get category_Insurance => '保險';

  @override
  String get category_Insurance_HealthInsurance => '健康保險';

  @override
  String get category_Insurance_HomeownerRentersInsurance => '業主或租客保險';

  @override
  String get category_Insurance_HomeWarrantyProtectionPlan => '房屋保固或保障計劃';

  @override
  String get category_Insurance_AutoInsurance => '汽車保險';

  @override
  String get category_Insurance_LifeInsurance => '人壽保險';

  @override
  String get category_Insurance_DisabilityInsurance => '傷殘保險';

  @override
  String get category_HouseholdItemsSupplies => '家居用品/物資';

  @override
  String get category_HouseholdItemsSupplies_Toiletries => '盥洗用品';

  @override
  String get category_HouseholdItemsSupplies_LaundryDetergent => '洗衣劑';

  @override
  String get category_HouseholdItemsSupplies_DishwasherDetergent => '洗碗機清潔劑';

  @override
  String get category_HouseholdItemsSupplies_CleaningSupplies => '清潔用品';

  @override
  String get category_HouseholdItemsSupplies_Tools => '工具';

  @override
  String get category_Personal => '個人開支';

  @override
  String get category_Personal_GymMemberships => '健身房會籍';

  @override
  String get category_Personal_Haircuts => '理髮';

  @override
  String get category_Personal_SalonServices => '美容院服務';

  @override
  String get category_Personal_Cosmetics => '化妝品';

  @override
  String get category_Personal_Babysitter => '保姆';

  @override
  String get category_Personal_Subscriptions => '訂閱項目';

  @override
  String get category_Education => '教育';

  @override
  String get category_Education_ChildrenCollege => '子女大學費用';

  @override
  String get category_Education_YourCollege => '您的大學費用';

  @override
  String get category_Education_SchoolSupplies => '學校用品';

  @override
  String get category_Education_Books => '書籍';

  @override
  String get category_Education_Tuition => '學費';

  @override
  String get category_Education_Exams => '考試費';

  @override
  String get category_Savings => '儲蓄';

  @override
  String get category_Savings_EmergencyFund => '緊急備用金';

  @override
  String get category_Savings_BigPurchases => '大額購物儲蓄';

  @override
  String get category_Savings_OtherSavings => '其他儲蓄';

  @override
  String get category_GiftsDonations => '禮物/捐贈';

  @override
  String get category_GiftsDonations_Birthday => '生日';

  @override
  String get category_GiftsDonations_Anniversary => '週年紀念';

  @override
  String get category_GiftsDonations_Wedding => '婚禮';

  @override
  String get category_GiftsDonations_Christmas => '聖誕節';

  @override
  String get category_GiftsDonations_SpecialOccasion => '特殊場合';

  @override
  String get category_GiftsDonations_Charities => '慈善捐款';

  @override
  String get category_GiftsDonations_Souvenir => '手信';

  @override
  String get category_Entertainment => '娛樂';

  @override
  String get category_Entertainment_AlcoholBars => '酒精及/或酒吧';

  @override
  String get category_Entertainment_Games => '遊戲';

  @override
  String get category_Entertainment_Movies => '電影';

  @override
  String get category_Entertainment_Concerts => '演唱會/音樂會';

  @override
  String get category_Entertainment_Vacations => '度假';

  @override
  String get category_Entertainment_Subscriptions =>
      '訂閱服務 (Netflix, Amazon, Hulu 等)';

  @override
  String get category_Entertainment_Other => '其他娛樂';

  @override
  String get category_Debt => '債務';

  @override
  String get category_Debt_CreditCard => '信用卡';

  @override
  String get category_Debt_PersonalLoans => '個人貸款';

  @override
  String get category_Debt_StudentLoans => '學生貸款';

  @override
  String get category_Debt_OtherDebtPayments => '其他債務還款';

  @override
  String get category_Other => '其他';

  @override
  String get category_Other_OtherExpenses => '其他開支';

  @override
  String get notSignedIn => '未登入';

  @override
  String get sessionTimeout => '連線超時';
}
