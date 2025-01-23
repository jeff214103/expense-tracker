import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
            _buildSectionTitle('Privacy Policy'),
            _buildParagraph('Last Updated: January 2025'),
            
            _buildSectionTitle('1. Open Source and Non-Profit Mission'),
            _buildParagraph('This application is an open-source, non-profit project dedicated to empowering users with personal financial tracking and analysis.'),
            
            _buildSectionTitle('2. Data Collection and Usage'),
            _buildParagraph('We do not collect, store, or sell any personal information beyond what is necessary for the app\'s core functionality:'),
            _buildBulletPoint('Google Sign-In is used solely for authentication and accessing your personal Google Drive and Sheets'),
            _buildBulletPoint('Financial data is stored exclusively in your personal Google Drive and Sheets'),
            _buildBulletPoint('All data remains under your complete control and ownership'),
            
            _buildSectionTitle('3. Authentication'),
            _buildParagraph('The app uses Google Sign-In with the following limited scopes:'),
            _buildBulletPoint('Email verification'),
            _buildBulletPoint('Google Drive file access'),
            
            _buildSectionTitle('4. Data Storage'),
            _buildParagraph('Your financial records are:'),
            _buildBulletPoint('Stored in a personal Google Spreadsheet'),
            _buildBulletPoint('Managed through your authenticated Google account'),
            _buildBulletPoint('Not accessible by the app developers'),
            
            _buildSectionTitle('5. User Control'),
            _buildParagraph('You have full control over your data:'),
            _buildBulletPoint('Revoke app access at any time through Google account settings'),
            _buildBulletPoint('Delete stored files directly from your Google Drive'),
            _buildBulletPoint('Opt-out of data storage by not using the app'),
            
            _buildSectionTitle('6. Security'),
            _buildParagraph('While we implement standard security practices, we recommend:'),
            _buildBulletPoint('Using strong Google account credentials'),
            _buildBulletPoint('Regularly reviewing connected applications'),
            
            _buildSectionTitle('7. Open Source Transparency'),
            _buildParagraph('Our complete source code is available for public review at our GitHub repository, ensuring full transparency in data handling.'),
            
            _buildSectionTitle('8. Contact and Feedback'),
            _buildParagraph('For any privacy-related inquiries or feedback, please open an issue on our GitHub repository.'),
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