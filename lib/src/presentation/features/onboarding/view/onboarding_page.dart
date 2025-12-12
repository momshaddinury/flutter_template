import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/app_localization.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/text/typography.dart';

part '../model/onboarding_model.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() => _currentPage = page);
                    },
                    children: _getOnboardingItems(context).map((item) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.padding.p24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeadingLargeText(
                              item.title,
                              textAlign: TextAlign.center,
                            ),
                            Gap(context.spacing.s24),
                            item.image,
                            Gap(context.spacing.s24),
                            Column(
                              children: item.features.map((feature) {
                                return _OnboardingListItem(title: feature);
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Gap(context.spacing.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getOnboardingItems(context).map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.padding.p4,
                      ),
                      child: Icon(
                        Icons.circle,
                        size: context.spacing.s8,
                        color: _currentPage == item.index
                            ? context.color.pageView.active
                            : context.color.pageView.inactive,
                      ),
                    );
                  }).toList(),
                ),
                Gap(context.spacing.s44),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.padding.p24,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      context.goNamed(Routes.login);
                    },
                    child: Text(context.locale.getStarted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingListItem extends StatelessWidget {
  const _OnboardingListItem({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.padding.p16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: context.spacing.s6,
            color: context.color.text.tertiary,
          ),
          Gap(context.spacing.s8),
          Expanded(
            child: Baseline(
              baseline: context.spacing.s8,
              baselineType: TextBaseline.alphabetic,
              child: BodyMediumText(title),
            ),
          ),
        ],
      ),
    );
  }
}
