import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/presentation/core/theme/theme.dart';

import '../../../../../core/extensions/app_localization.dart';
import '../../../../../core/gen/l10n/app_localizations.dart';
import '../../../../core/application_state/localization_provider/localization_provider.dart';

class LanguageSwitcherWidget extends ConsumerWidget {
  const LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localizationProvider);
    final notifier = ref.read(localizationProvider.notifier);

    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.language,
            color: context.color.primary,
          ),
          const SizedBox(width: 4),
          Text(
            context.locale.getLanguageName(state.languageCode),
            style: context.textStyle.bodyMedium,
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
      onSelected: (Locale locale) => notifier.changeLocale(locale),
      itemBuilder: (BuildContext context) {
        return AppLocalizations.supportedLocales.map((Locale locale) {
          return PopupMenuItem<Locale>(
            value: locale,
            child: Row(
              children: [
                Text(context.locale.getLanguageName(locale.languageCode)),
                if (locale == state) ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
