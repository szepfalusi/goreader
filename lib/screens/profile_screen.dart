import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../helpers/authentication_helper.dart';
import '../models/custom_user.dart';
import '../models/custom_user_provider.dart';
import '../models/tags.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/my-profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<CustomUserProvider>(context).getUser();
    if (kDebugMode) {
      print(userData.toJson());
    }
    return Scaffold(
      appBar: customAppBar('My profile'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: userData.name,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'address',
                    initialValue: userData.address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    name: 'phoneNumber',
                    initialValue: userData.phoneNumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    name: 'note',
                    initialValue: userData.note,
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
              onPressed: () async {
                _formKey.currentState?.validate();
                _formKey.currentState?.save();

                await Provider.of<CustomUserProvider>(context, listen: false)
                    .addUser(
                        CustomUser(
                          id: AuthenticationHelper().userId,
                          name: _formKey.currentState?.value['name'] ?? '',
                          address:
                              _formKey.currentState?.value['address'] ?? '',
                          phoneNumber:
                              _formKey.currentState?.value['phoneNumber'] ?? '',
                          note: _formKey.currentState?.value['note'] ?? '',
                        ),
                        Provider.of<Tags>(context, listen: false).tags);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Modifications saved succesfully.')));
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
                onPressed: () {
                  AuthenticationHelper().resetPassword();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                          'Password reset email sent to your email.')));
                },
                child: const Text('Reset my password'))
          ],
        ),
      ),
    );
  }
}
