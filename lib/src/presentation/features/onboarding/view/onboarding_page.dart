import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/app_localization.dart';
import '../../../core/application_state/onboarding_status_provider/onboarding_status_provider.dart';
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

  void _onGetStarted() {
    ref.read(markOnboardingCompletedUseCaseProvider).call();
    // WHY: the gate navigates, not the page — refreshing the onboarding
    // status flips routerState past onboarding to login or home.
    ref.invalidate(onboardingStatusProvider);
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
                          horizontal: context.dimensions.space.s24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeadingLevel1Text(
                              item.title,
                              textAlign: TextAlign.center,
                            ),
                            Gap(context.dimensions.space.s24),
                            item.image,
                            Gap(context.dimensions.space.s24),
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
                Gap(context.dimensions.space.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getOnboardingItems(context).map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.dimensions.space.s4,
                      ),
                      child: Icon(
                        Icons.circle,
                        size: context.dimensions.layout.dot,
                        color: _currentPage == item.index
                            ? context.color.primary.defaultValue
                            : context.color.text.muted,
                      ),
                    );
                  }).toList(),
                ),
                Gap(context.dimensions.size.iconDisplay),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.dimensions.space.s24,
                  ),
                  child: FilledButton(
                    onPressed: _onGetStarted,
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
      padding: EdgeInsets.only(bottom: context.dimensions.space.s16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: context.dimensions.layout.bullet,
            color: context.color.text.muted,
          ),
          Gap(context.dimensions.space.s8),
          Expanded(
            child: Baseline(
              baseline: context.dimensions.space.s8,
              baselineType: TextBaseline.alphabetic,
              child: BodySmallText(title),
            ),
          ),
        ],
      ),
    );
  }
}
