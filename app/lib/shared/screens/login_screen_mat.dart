import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void Function(String) _focusOn(BuildContext context, FocusNode focusNode) {
    return (_) => FocusScope.of(context).requestFocus(focusNode);
  }

  void _login() {
    print('login');
    Navigator.pushNamed(context, Routes.caregiverFilter);
  }

  void _signIn() {
    print('signIn');
    Navigator.pushNamed(context, Routes.profileForm);
  }

  void _signInWithGoogle() {
    print('signInWithGoogle');
    Navigator.pushNamed(context, Routes.caregiverFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (bContext, constraints) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05,
                      vertical: constraints.maxHeight * 0.05,
                    ),
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: _focusOn(context, _passwordFocusNode),
                      onSaved: (value) => _email = value,
                      textInputAction: TextInputAction.next,
                      validator: composeValidators([requiredValue]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) => _login,
                      onSaved: (value) => _email = value,
                      textInputAction: TextInputAction.next,
                      validator: composeValidators([requiredValue]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ButtonFooter(
                      primaryText: 'Entrar',
                      secondaryText: 'Criar conta',
                      onPrimary: _login,
                      onSecondary: _signIn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GoogleSignInButton(
                      onPressed: _signInWithGoogle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
