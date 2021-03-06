import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../helpers/authentication_helper.dart';
import '../widgets/custom_app_bar.dart';
import 'signup_screen.dart';

final _formKey = GlobalKey<FormBuilderState>();

class LogInScreen extends StatelessWidget {
  static String routeName = '/login-screen';

  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Log in'),
      body: SingleChildScrollView(
        child: Padding(
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
                  AuthenticationHelper()
                      .signIn(
                          email: _formKey.currentState!.value['email'],
                          password: _formKey.currentState!.value['password'])
                      .then((value) {
                    if (value == null) {
                      Navigator.of(context).pop();
                    } else {
                      if (value == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('??? Wrong password.???')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went wrong')));
                      }
                      log(value);
                    }
                  });
                },
                child: const Text('Log in'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: const Text('Don\'t have an account yet? Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
