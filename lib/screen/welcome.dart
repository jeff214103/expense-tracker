import 'package:flutter/material.dart';
import 'package:expense_tracker_web/l10n/app_localizations.dart';
import 'package:url_launcher/link.dart';

List<Map<String, dynamic>> items = [
  {
    "id": 1,
    "header": "welcome",
    "description": "welcomeDescription",
    "image": "assets/images/1.png",
    "link": [
      {
        "name": "tutorialLink",
        "url":
            "https://www.howtogeek.com/196087/how-to-add-websites-to-the-home-screen-on-any-smartphone-or-tablet/"
      }
    ],
  },
  {
    "id": 2,
    "header": "privacy",
    "description": "privacyDescription",
    "image": "assets/images/2.png",
    "link": [
      {
        "name": "privacyPolicy",
        "url": Uri.parse('/privacy-policy').toString(),
      },
      {
        "name": "termsOfService",
        "url":  Uri.parse('/service-agreement').toString(),
      }
    ]
  },
  {
    "id": 3,
    "header": "input",
    "description": "inputDescription",
    "image": "assets/images/3.png"
  },
  {
    "id": 4,
    "header": "view",
    "description": "viewDescription",
    "image": "assets/images/4.png"
  },
  {
    "id": 5,
    "header": "manage",
    "description": "manageDescription",
    "image": "assets/images/5.png"
  },
  {
    "id": 6,
    "header": "author",
    "description": "authorDescription",
    "image": "assets/images/6.png",
    "link": [
      {
        "name": "github",
        "url": "https://github.com/jeff214103/resume-generator",
      }, 
      {
        "name": "itdogtics",
        "url": "https://itdogtics.com/",
      }, {
        "name": "aboutAuthor",
        "url": "https://author.itdogtics.com/",
      },
    ],
  },
  {
    "id": 7,
    "header": "almostThere",
    "description": "almostThereDescription",
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
          label: AppLocalizations.of(context)!.pageIndicatorLabel(index),
          hint: AppLocalizations.of(context)!.pageIndicatorHint(index),
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
                  header: AppLocalizations.of(context)!.welcomePageHeader(items[index]['header']),
                  description: AppLocalizations.of(context)!.welcomePageDescription(items[index]['description']),
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
                                  label: AppLocalizations.of(context)!.skipTutorial,
                                  hint: AppLocalizations.of(context)!.skipTutorialHint,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(AppLocalizations.of(context)!.skip.toUpperCase()),
                                  ),
                                )
                              : const SizedBox.shrink()
                          : Semantics(
                              label: AppLocalizations.of(context)!.goBackToFirstPage,
                              hint: AppLocalizations.of(context)!.goBackToFirstPageHint,
                              child: ElevatedButton(
                                onPressed: () {
                                  _pageViewController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(AppLocalizations.of(context)!.back),
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
                            ? AppLocalizations.of(context)!.nextPage
                            : AppLocalizations.of(context)!.finishTutorial,
                        hint: currentPage != items.length - 1
                            ? AppLocalizations.of(context)!.nextPageHint
                            : AppLocalizations.of(context)!.finishTutorialHint,
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
                            (currentPage != items.length - 1) 
                              ? AppLocalizations.of(context)!.next.toUpperCase() 
                              : AppLocalizations.of(context)!.go.toUpperCase(),
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

  List<Widget> buildLinks(BuildContext context, List<Map<String, String>> links) {
    return [
      for (final link in links)
        Center(
          child: Link(
            uri: Uri.tryParse(link['url'] ?? ''),
            target: LinkTarget.blank,
            builder: (context, followLink) => TextButton(
              onPressed: followLink,
              child: Text(AppLocalizations.of(context)!.welcomePageLinkName(link['name'] ?? '')),
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
                          children: buildLinks(context, link!),
                        ),
                      if (onFinish != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: FilledButton(
                              onPressed: onFinish,
                              child: Text(AppLocalizations.of(context)!.getStarted)),
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
