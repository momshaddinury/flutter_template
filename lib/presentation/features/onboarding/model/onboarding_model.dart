part of '../view/onboarding_page.dart';

typedef _OnboardingItem = ({
  int index,
  String title,
  Widget image,
  List<String> features,
});

List<_OnboardingItem> _onboardingItems = [
  (
    index: 0,
    title: 'Learn Flutter with comprehensive tutorials.',
    image: const FlutterLogo(size: 200),
    features: [
      'Step-by-step guides for building Flutter apps.',
      'Get notifications for new tutorials and updates.',
    ],
  ),
  (
    index: 1,
    title: 'Join the Flutter community.',
    image: const FlutterLogo(size: 200),
    features: [
      'Connect with other Flutter developers.',
      'Participate in community events and discussions.',
    ],
  ),
  (
    index: 2,
    title: 'Build and deploy Flutter apps easily.',
    image: const FlutterLogo(size: 200),
    features: [
      'Access tools and resources for app development.',
      'Deploy your apps to multiple platforms with ease.',
    ],
  ),
];
