part of '../view/login_page.dart';

class _FormFooter extends ConsumerWidget {
  const _FormFooter({
    required this.shouldRemember,
  });

  final ValueNotifier<bool> shouldRemember;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ValueListenableBuilder(
              valueListenable: shouldRemember,
              builder: (context, value, _) {
                return Checkbox(
                  value: value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  onChanged: (bool? value) {
                    shouldRemember.value = value ?? false;
                  },
                );
              },
            ),
            const Text('Remember me'),
          ],
        ),
        Transform.translate(
          offset: const Offset(10, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.pushNamed(Routes.resetPassword);
              },
              child: const Text('Forgot password'),
            ),
          ),
        ),
      ],
    );
  }
}
