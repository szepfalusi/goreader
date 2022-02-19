import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/my-profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('My profile'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'form_name',
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'form_address',
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'form_phone',
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      prefix: Text('+'),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    name: 'form_note',
                    decoration: const InputDecoration(
                      labelText: 'General note',
                    ),
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
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
