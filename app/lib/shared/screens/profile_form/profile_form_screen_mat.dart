import 'dart:io';

import 'package:caregiver_hub/shared/utils/io/camera.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileFormScreenMat extends StatefulWidget {
  const ProfileFormScreenMat({Key? key}) : super(key: key);

  @override
  _ProfileFormScreenMatState createState() => _ProfileFormScreenMatState();
}

class _ProfileFormScreenMatState extends State<ProfileFormScreenMat> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameFocusNode = FocusNode();
  final _cpfFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  File? _image;
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

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    print('submit');
  }

  Future<void> _takePicture() async {
    final newImage = await takePicture();
    setState(() => _image = newImage);
  }

  Future<void> _findPicture() async {
    final newImage = await takePicture(galery: true);
    setState(() => _image = newImage);
  }

  Widget _buildProfilePicture() {
    if (_image == null) {
      return Image.asset(
        'assets/images/user_profile_placeholder.png',
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Image.file(
      _image as File,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: _findPicture,
                  icon: const Icon(Icons.file_present),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Criar conta'),
                background: _buildProfilePicture(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nome completo',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _fullNameFocusNode,
                            onFieldSubmitted: _focusOn(context, _cpfFocusNode),
                            onSaved: (value) => _fullName = value,
                            textInputAction: TextInputAction.next,
                            validator: composeValidators([requiredValue]),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'CPF',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _cpfFocusNode,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: '###.###.###-##',
                                filter: {'#': RegExp(r'[0-9]')},
                              )
                            ],
                            keyboardType: TextInputType.number,
                            onFieldSubmitted:
                                _focusOn(context, _phoneFocusNode),
                            onSaved: (value) => _cpf = value,
                            textInputAction: TextInputAction.next,
                            validator:
                                composeValidators([requiredValue, validCPF]),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _phoneFocusNode,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: '(##) ##### ####',
                                filter: {'#': RegExp(r'[0-9]')},
                              )
                            ],
                            keyboardType: TextInputType.number,
                            onFieldSubmitted:
                                _focusOn(context, _emailFocusNode),
                            onSaved: (value) => _phone = value,
                            textInputAction: TextInputAction.next,
                            validator: composeValidators([requiredValue]),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted:
                                _focusOn(context, _passwordFocusNode),
                            onSaved: (value) => _email = value,
                            textInputAction: TextInputAction.next,
                            validator: composeValidators([requiredValue]),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                            onFieldSubmitted:
                                _focusOn(context, _confirmPasswordFocusNode),
                            onSaved: (value) => _password = value,
                            textInputAction: TextInputAction.next,
                            validator: composeValidators([requiredValue]),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Confirmar senha',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: _confirmPasswordFocusNode,
                            obscureText: true,
                            onFieldSubmitted: (_) => _submit(),
                            onSaved: (value) => _confirmPassword = value,
                            textInputAction: TextInputAction.next,
                            validator: composeValidators([
                              requiredValue,
                              equalTo(_password),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: constraints.maxWidth,
                            child: ElevatedButton(
                              child: Text(
                                'Criar conta',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
