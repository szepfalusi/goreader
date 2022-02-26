import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:goreader/helpers/authentication_helper.dart';
import 'package:goreader/screens/login_screen.dart';
import 'package:goreader/widgets/custom_app_bar.dart';

final _formKey = GlobalKey<FormBuilderState>();

class SignUpScreen extends StatelessWidget {
  static String routeName = '/signup-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Sign up'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                    ]),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.validate();
                _formKey.currentState?.save();
                print(_formKey.currentState!.value['email']);
                AuthenticationHelper()
                    .signUp(
                        email: _formKey.currentState!.value['email'],
                        password: _formKey.currentState!.value['password'])
                    .then((value) {
                  if (value == null) {
                    Navigator.of(context).pop();
                  } else {
                    log(value);
                  }
                });
              },
              child: const Text('Sign up'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(LogInScreen.routeName);
                },
                child: const Text('Do you have an account? Log in'))
          ],
        ),
      ),
    );
  }
}
