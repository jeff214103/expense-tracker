import 'package:flutter/material.dart';

class ServiceAgreementScreen extends StatelessWidget {
  const ServiceAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Agreement'),
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
            _buildSectionTitle('Service Agreement'),
            _buildParagraph('Last Updated: January 2025'),

            _buildSectionTitle('1. Acceptance of Terms'),
            _buildParagraph(
              'By accessing and using the Expense Tracker System, you agree to be bound by this Service Agreement. '
              'If you do not agree with any part of these terms, please refrain from using our services.',
            ),

            _buildSectionTitle('2. Services Provided'),
            _buildParagraph(
              'Our Expense Tracker System provides a secure and efficient way to manage your financial information. '
              'Key features include:',
            ),
            _buildBulletPoint('Secure authentication using Google Sign-In.'),
            _buildBulletPoint('Data storage in your personal Google Drive and management via Google Sheets.'),
            _buildBulletPoint('Real-time tracking and analysis of your expenses.'),
            _buildParagraph(
              'Services are provided on an "as is" basis without any express or implied warranties.',
            ),

            _buildSectionTitle('3. User Responsibilities'),
            _buildParagraph(
              'Users are responsible for ensuring that all account information is accurate and up-to-date. '
              'You must maintain the confidentiality of your account credentials and abide by all applicable laws.',
            ),

            _buildSectionTitle('4. Account Security and Data Privacy'),
            _buildParagraph(
              'We employ Google Sign-In for secure authentication. Your financial data remains under your control '
              'and is securely stored within your Google services. It is your responsibility to keep your login details confidential.',
            ),

            _buildSectionTitle('5. Intellectual Property Rights'),
            _buildParagraph(
              'All content, features, and functionalities related to the Expense Tracker System— '
              'including software, design, text, and graphics—are the intellectual property of the developers. '
              'Unauthorized use, reproduction, or distribution is strictly prohibited.',
            ),

            _buildSectionTitle('6. Limitation of Liability'),
            _buildParagraph(
              'To the fullest extent permitted by law, neither the developers nor any affiliated parties shall be liable '
              'for any indirect, incidental, or consequential damages arising from the use of the Expense Tracker System. '
              'Your use of the service is at your own risk.',
            ),

            _buildSectionTitle('7. Changes to the Agreement'),
            _buildParagraph(
              'We reserve the right to modify or update this Service Agreement at any time. '
              'It is your responsibility to review these terms periodically. Continued use of the service constitutes '
              'acceptance of any changes made to the agreement.',
            ),

            _buildSectionTitle('8. Contact and Support'),
            _buildParagraph(
              'For any questions or concerns regarding this Service Agreement, please contact our support team or reach out '
              'via our GitHub repository.',
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
