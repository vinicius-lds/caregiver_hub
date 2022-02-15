import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/user/models/user_form_data.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/user/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  final UserFormData? data;

  const ProfileForm({Key? key, this.data}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _userService = getIt<UserService>();

  final _formKey = GlobalKey<FormState>();

  final _phoneTextEditingController = TextEditingController();

  final _fullNameFocusNode = FocusNode();
  final _cpfFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _disabled = false;

  String? _imagePath;
  String? _fullName;
  String? _cpf;
  String? _phone;
  String? _email;
  String? _password;
  String? _confirmPassword;

  @override
  void dispose() {
    super.dispose();
    _fullNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
  }

  void Function(String) _focusOn(BuildContext context, FocusNode focusNode) {
    return (_) => FocusScope.of(context).requestFocus(focusNode);
  }

  void _setImage(String? image) {
    _imagePath = image;
  }

  void _submit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() => _disabled = true);
    try {
      if (widget.data == null) {
        final userCredential = await _userService.createUser(
          imagePath: _imagePath,
          fullName: _fullName!,
          cpf: _cpf!,
          phone: _phone!,
          email: _email!,
          password: _password!,
        );
        Provider.of<ProfileProvider>(context, listen: false).id =
            userCredential.user!.uid;
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.caregiverFilter,
          (route) => false, // Remove todas as telas do stack
        );
      } else {
        await _userService.updateUser(
          imagePath: _imagePath,
          fullName: _fullName!,
          cpf: _cpf!,
          phone: _phone!,
          email: _email!,
          password: _password,
        );
        Navigator.of(context).pop();
      }
    } on ServiceException catch (e) {
      _showSnackBar(context, e.message);
    }
    setState(() => _disabled = false);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  MaskTextInputFormatter get _cpfMask {
    return MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    if (widget.data != null) {
      PhoneNumber.getRegionInfoFromPhoneNumber(widget.data!.phone, 'BR').then(
        (value) => _phoneTextEditingController.text = value.phoneNumber ?? '',
      );
    }
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ImageInput(
                    onSaved: _setImage,
                    readOnly: _disabled,
                    size: constraints.maxWidth * 0.5,
                    initialValue: widget.data?.imageURL,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                    ),
                    initialValue: widget.data?.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _fullNameFocusNode,
                    readOnly: _disabled,
                    onFieldSubmitted: _focusOn(context, _cpfFocusNode),
                    onSaved: (value) => _fullName = value,
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
                      labelText: 'CPF',
                    ),
                    initialValue: widget.data != null
                        ? _cpfMask.maskText(widget.data!.cpf)
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _cpfFocusNode,
                    inputFormatters: [_cpfMask],
                    keyboardType: TextInputType.number,
                    readOnly: _disabled,
                    onFieldSubmitted: _focusOn(context, _phoneFocusNode),
                    onSaved: (value) =>
                        _cpf = value?.replaceAll('.', '').replaceAll('-', ''),
                    textInputAction: TextInputAction.next,
                    validator: composeValidators([
                      requiredValue(message: 'O campo é obrigatório'),
                      validCPF(message: 'O CPF é inválido'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: null,
                    countries: const ['BR'],
                    hintText: 'Telefone',
                    errorMessage: 'Telefone inválido',
                    onSaved: (value) => _phone = value.phoneNumber,
                    textFieldController: _phoneTextEditingController,
                    focusNode: _phoneFocusNode,
                    isEnabled: !_disabled,
                    onFieldSubmitted: _focusOn(context, _emailFocusNode),
                    keyboardAction: TextInputAction.next,
                    validator: composeValidators([
                      requiredValue(message: 'O campo é obrigatório'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    initialValue: widget.data?.email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _emailFocusNode,
                    readOnly: _disabled,
                    keyboardType: TextInputType.emailAddress,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    readOnly: _disabled,
                    onFieldSubmitted:
                        _focusOn(context, _confirmPasswordFocusNode),
                    onChanged: (value) => setState(() => _password = value),
                    onSaved: (value) => _password = value,
                    textInputAction: TextInputAction.next,
                    validator: composeValidators([
                      if (widget.data == null)
                        requiredValue(message: 'O campo é obrigatório'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar senha',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _confirmPasswordFocusNode,
                    obscureText: true,
                    readOnly: _disabled,
                    onFieldSubmitted: (_) => _submit(context),
                    onSaved: (value) => _confirmPassword = value,
                    textInputAction: TextInputAction.done,
                    validator: composeValidators([
                      if (widget.data == null)
                        requiredValue(message: 'O campo é obrigatório'),
                      if (widget.data == null)
                        equalTo(
                          _password,
                          message: 'Os valores não são iguais',
                        ),
                    ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: constraints.maxWidth,
                  child: ElevatedButton(
                    child: Text(
                      widget.data == null ? 'Criar conta' : 'Salvar alterações',
                      style: TextStyle(
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: _disabled ? null : () => _submit(context),
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
