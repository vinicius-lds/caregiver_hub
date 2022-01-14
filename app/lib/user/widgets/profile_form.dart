import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/user/models/user_form_data.dart';
import 'package:caregiver_hub/user/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileForm extends StatefulWidget {
  final UserFormData? data;

  const ProfileForm({Key? key, this.data}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameFocusNode = FocusNode();
  final _cpfFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String? _image;
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
    print('setImage $image');
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    print('submit $_phone');
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
                    onFieldSubmitted: _focusOn(context, _phoneFocusNode),
                    onSaved: (value) => _cpf = value,
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
                    initialValue: widget.data != null
                        ? PhoneNumber(
                            phoneNumber: widget.data!.phone,
                            isoCode: 'BR',
                          )
                        : null,
                    focusNode: _phoneFocusNode,
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
                    onFieldSubmitted: (_) => _submit(),
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
                    onPressed: _submit,
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
