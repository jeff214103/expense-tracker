import 'package:flutter/material.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';

class ServiceAgreementScreen extends StatelessWidget {
  const ServiceAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.serviceAgreement),
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
            _buildSectionTitle(AppLocalizations.of(context)!.serviceAgreement),
            _buildParagraph(AppLocalizations.of(context)!.serviceAgreementLastUpdated),

            _buildSectionTitle(AppLocalizations.of(context)!.acceptanceOfTermsTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.acceptanceOfTermsDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.servicesProvidedTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.servicesProvidedDescription,
            ),
            _buildBulletPoint(AppLocalizations.of(context)!.servicesProvidedSecureAuthentication),
            _buildBulletPoint(AppLocalizations.of(context)!.servicesProvidedDataStorage),
            _buildBulletPoint(AppLocalizations.of(context)!.servicesProvidedRealTimeTracking),
            _buildParagraph(
              AppLocalizations.of(context)!.servicesProvidedDisclaimer,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.userResponsibilitiesTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.userResponsibilitiesDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.accountSecurityAndDataPrivacyTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.accountSecurityAndDataPrivacyDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.intellectualPropertyRightsTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.intellectualPropertyRightsDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.limitationOfLiabilityTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.limitationOfLiabilityDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.changesToTheAgreementTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.changesToTheAgreementDescription,
            ),

            _buildSectionTitle(AppLocalizations.of(context)!.contactAndSupportTitle),
            _buildParagraph(
              AppLocalizations.of(context)!.contactAndSupportDescription,
            ),
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
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
