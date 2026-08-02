part of '../view/login_page.dart';

class _FormFooter extends ConsumerWidget {
  const _FormFooter({required this.shouldRemember});

  final ValueNotifier<bool> shouldRemember;

  void _toggleRememberMe(bool? value) {
    shouldRemember.value = value ?? false;
  }

  void _navigateToResetPassword(BuildContext context) {
    context.pushNamed(Routes.resetPassword.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.translate(
          offset: const Offset(-10, 0),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: shouldRemember,
                builder: (context, value, _) {
                  return Checkbox(value: value, onChanged: _toggleRememberMe);
                },
              ),
              LabelText.muted(context.locale.rememberMe),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(10, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _navigateToResetPassword(context),
              child: Text(context.locale.forgotPassword),
            ),
          ),
        ),
      ],
    );
  }
}
