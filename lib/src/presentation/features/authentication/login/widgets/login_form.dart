part of '../view/login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.shouldRemember,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> shouldRemember;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
          decoration: InputDecoration(hintText: context.locale.email),
          validator: context.validator.apply([RequiredValidation()]),
        ),
        Gap(context.spacing.s16),
        TextFormField(
          controller: widget.passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: context.locale.password,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: context.validator.apply([
            RequiredValidation(),
            PasswordValidation(minLength: 6),
          ]),
        ),
        _FormFooter(shouldRemember: widget.shouldRemember),
      ],
    );
  }
}
