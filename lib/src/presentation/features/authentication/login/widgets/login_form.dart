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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
          decoration: InputDecoration(
            hintText: context.locale.email,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.locale.emailRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: context.locale.password,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.locale.passwordRequired;
            }
            return null;
          },
        ),
        _FormFooter(shouldRemember: widget.shouldRemember),
      ],
    );
  }
}
