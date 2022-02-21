import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:goreader/widgets/custom_app_bar.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = '/auth-screen';

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Authentication'),
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
                _formKey.currentState?.save();
                print(_formKey.currentState?.value);
              },
              child: const Text('Log in / Sign up'),
            )
          ],
        ),
      ),
    );
  }
}
