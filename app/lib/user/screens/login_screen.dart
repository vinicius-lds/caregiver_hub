import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/utils/gui.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = getIt<AuthService>();

  final _formKey = GlobalKey<FormState>();

  bool _disabled = false;

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

  void _login(BuildContext context) async {
    setState(() => _disabled = true);
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await _authService.login(
          email: _email!,
          password: _password!,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          appStateProvider.isCaregiver
              ? Routes.jobList
              : Routes.caregiverFilter,
          (route) => false, // Remove todas as telas do stack
        );
      } on ServiceException catch (e) {
        showSnackBar(context, e.message);
      }
    }
    setState(() => _disabled = false);
  }

  void _signIn() {
    Navigator.pushNamed(context, Routes.profile, arguments: {'isEdit': false});
  }

  void _signInWithGoogle() {
    print('signInWithGoogle');
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.caregiverFilter,
      (route) => false, // Remove todas as telas do stack
    );
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
                      readOnly: _disabled,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: _focusOn(context, _passwordFocusNode),
                      onSaved: (value) => _email = value,
                      textInputAction: TextInputAction.next,
                      validator: composeValidators([
                        requiredValue(message: 'O campo é obrigatório'),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      readOnly: _disabled,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) => _login(context),
                      obscureText: true,
                      onSaved: (value) => _password = value,
                      textInputAction: TextInputAction.next,
                      validator: composeValidators([
                        requiredValue(message: 'O campo é obrigatório'),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ButtonFooter(
                      primaryText: 'Entrar',
                      secondaryText: 'Criar conta',
                      disabled: _disabled,
                      onPrimary: () => _login(context),
                      onSecondary: _signIn,
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
