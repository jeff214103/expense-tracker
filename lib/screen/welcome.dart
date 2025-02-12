import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

List<Map<String, dynamic>> items = [
  {
    "id": 1,
    "header": "Welcome",
    "description":
        """Welcome to your expense management app. Track your daily expenses efficiently. 

Add this app to your home screen by following the steps in the link below:""",
    "image": "assets/images/1.png",
    "link": [
      {
        "name": "Tutorial link",
        "url":
            "https://www.howtogeek.com/196087/how-to-add-websites-to-the-home-screen-on-any-smartphone-or-tablet/"
      }
    ],
  },
  {
    "id": 2,
    "header": "Privacy",
    "description":
        """Your data privacy matters. Here's where your information is stored:

1. Google Drive - Receipt images
2. Google Sheets - Expense records, Exchange Rates, Settings

Note: You are responsible for your device and Google account security. The app developer is not liable for any data breaches due to your security settings.""",
    "image": "assets/images/2.png",
    "link": [
      {
        "name": "privacy policy",
        "url": Uri.parse('/privacy-policy').toString(),
      },
      {
        "name": "terms of service",
        "url":  Uri.parse('/service-agreement').toString(),
      }
    ]
  },
  {
    "id": 3,
    "header": "Input",
    "description":
        """Getting started is easy! Scan your receipt, and if you've set up Gemini, the information will be extracted automatically. You can review and adjust the details as needed. 
 
No receipt? You can also input expenses manually.""",
    "image": "assets/images/3.png"
  },
  {
    "id": 4,
    "header": "View",
    "description":
        "Easily track your spending history. All amounts are shown in your preferred currency. Currency conversion rates are preset and may need manual updates.",
    "image": "assets/images/4.png"
  },
  {
    "id": 5,
    "header": "Manage",
    "description":
        """The app creates a Google Sheet named "Expense Record" and a Google Drive folder called "Expense History (Automated)". You can find these files in your Google Drive. If you run out of space, you may need to delete them manually.""",
    "image": "assets/images/5.png"
  },
  {
    "id": 6,
    "header": "Author",
    "description":
        "This project is open source on GitHub. Contributions are welcome! If you find this app helpful, consider supporting the developer with a coffee!",
    "image": "assets/images/6.png",
    "link": [
      {
        "name": "github",
        "url": "https://github.com/jeff214103/resume-generator",
      },
      {
        "name": "about author",
        "url": "https://jeff214103.github.io/personal-webpage/",
      },
    ],
    // Replace with the actual GitHub repository link
  },
  {
    "id": 7,
    "header": "Almost There",
    "description": "You're all set! Let's start managing your expenses.",
    "image": "assets/images/7.png"
  },
];

class WelcomeScreen extends StatefulWidget {
  final bool allowSkip;
  const WelcomeScreen({super.key, required this.allowSkip});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> indicator() => List<Widget>.generate(
        items.length,
        (index) => Semantics(
          label: 'Page $index indicator',
          hint: 'Navigate to page $index',
          child: GestureDetector(
            onTap: () {
              _pageViewController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              height: 10.0,
              width: 10.0,
              decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      );

  double currentPage = 0.0;
  final PageController _pageViewController = PageController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for smooth transitions
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pageViewController.addListener(() {
      setState(() {
        currentPage = _pageViewController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return WelcomePageLayout(
                  header: items[index]['header'],
                  description: items[index]['description'],
                  link: items[index]['link'],
                  image: items[index]['image'],
                  onFinish: (index == items.length - 1)
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : null,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 70.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip or Back Button
                    SizedBox(
                      width: 100,
                      child: (currentPage != items.length - 1)
                          ? (widget.allowSkip == true)
                              ? Semantics(
                                  label: 'Skip tutorial',
                                  hint: 'Skip the welcome tutorial',
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('SKIP'),
                                  ),
                                )
                              : const SizedBox.shrink()
                          : Semantics(
                              label: 'Go back to first page',
                              hint: 'Return to the first page of the tutorial',
                              child: ElevatedButton(
                                onPressed: () {
                                  _pageViewController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: const Text('Back'),
                              ),
                            ),
                    ),

                    // Page Indicators
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicator(),
                      ),
                    ),

                    // Next or Go Button
                    SizedBox(
                      width: 100,
                      child: Semantics(
                        label: currentPage != items.length - 1
                            ? 'Next page'
                            : 'Finish tutorial',
                        hint: currentPage != items.length - 1
                            ? 'Go to the next page'
                            : 'Complete the welcome tutorial',
                        child: FilledButton(
                          onPressed: () {
                            if (currentPage != items.length - 1) {
                              _pageViewController.animateToPage(
                                currentPage.toInt() + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            (currentPage != items.length - 1) ? 'NEXT' : 'GO',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomePageLayout extends StatelessWidget {
  final String? image;
  final List<Map<String, String>>? link;
  final String header;
  final String description;
  final void Function()? onFinish;
  const WelcomePageLayout(
      {super.key,
      this.image,
      this.link,
      required this.header,
      required this.description,
      this.onFinish});

  List<Widget> buildLinks(List<Map<String, String>> links) {
    return [
      for (final link in links)
        Center(
          child: Link(
            uri: Uri.tryParse(link['url'] ?? ''),
            target: LinkTarget.blank,
            builder: (context, followLink) => TextButton(
              onPressed: followLink,
              child: Text(link['name'] ?? ''),
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: (image == null)
                ? Container(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    constraints: const BoxConstraints(maxWidth: 700),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Image.asset(
                      image!,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Column(
                    children: <Widget>[
                      Text(header,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(height: 2)),
                      Center(
                        child: Text(
                          description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.3, letterSpacing: 1.2),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      if (link != null)
                        Wrap(
                          children: buildLinks(link!),
                        ),
                      if (onFinish != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: FilledButton(
                              onPressed: onFinish,
                              child: const Text('Get Started')),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
