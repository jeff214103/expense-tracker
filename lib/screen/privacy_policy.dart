import 'package:flutter/material.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privacyPolicy),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(AppLocalizations.of(context)!.privacyPolicy),
            _buildParagraph(AppLocalizations.of(context)!.privacyPolicyLastUpdated),
            
            _buildSectionTitle(AppLocalizations.of(context)!.openSourceAndNonProfitMissionTitle),
            _buildParagraph(AppLocalizations.of(context)!.openSourceAndNonProfitMissionDescription),
            
            _buildSectionTitle(AppLocalizations.of(context)!.dataCollectionAndUsageTitle),
            _buildParagraph(AppLocalizations.of(context)!.dataCollectionAndUsageDescription),
            _buildBulletPoint(AppLocalizations.of(context)!.dataCollectionGoogleSignInBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.dataCollectionFinancialDataBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.dataCollectionDataOwnershipBullet),
            
            _buildSectionTitle(AppLocalizations.of(context)!.authenticationTitle),
            _buildParagraph(AppLocalizations.of(context)!.authenticationDescription),
            _buildBulletPoint(AppLocalizations.of(context)!.authenticationEmailVerificationBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.authenticationGoogleDriveFileAccessBullet),
            
            _buildSectionTitle(AppLocalizations.of(context)!.dataStorageTitle),
            _buildParagraph(AppLocalizations.of(context)!.dataStorageDescription),
            _buildBulletPoint(AppLocalizations.of(context)!.dataStorageGoogleSpreadsheetBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.dataStorageManagedThroughGoogleAccountBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.dataStorageNotAccessibleByDevelopersBullet),
            
            _buildSectionTitle(AppLocalizations.of(context)!.userControlTitle),
            _buildParagraph(AppLocalizations.of(context)!.userControlDescription),
            _buildBulletPoint(AppLocalizations.of(context)!.userControlRevokeAppAccessBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.userControlDeleteStoredFilesBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.userControlOptOutDataStorageBullet),
            
            _buildSectionTitle(AppLocalizations.of(context)!.securityTitle),
            _buildParagraph(AppLocalizations.of(context)!.securityDescription),
            _buildBulletPoint(AppLocalizations.of(context)!.securityStrongGoogleAccountCredentialsBullet),
            _buildBulletPoint(AppLocalizations.of(context)!.securityRegularlyReviewConnectedApplicationsBullet),
            
            _buildSectionTitle(AppLocalizations.of(context)!.openSourceTransparencyTitle),
            _buildParagraph(AppLocalizations.of(context)!.openSourceTransparencyDescription),
            
            _buildSectionTitle(AppLocalizations.of(context)!.contactAndFeedbackTitle),
            _buildParagraph(AppLocalizations.of(context)!.contactAndFeedbackDescription),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}