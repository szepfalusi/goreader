import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'my_tags_screen.dart';
import '../models/tag.dart';
import '../models/tags.dart';
import '../widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class TagFormScreen extends StatefulWidget {
  static String routeName = '/tag-form';

  @override
  _TagFormScreenState createState() => _TagFormScreenState();
}

class _TagFormScreenState extends State<TagFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final tagId = ModalRoute.of(context)?.settings.arguments;
    var tagData = Tag(
      id: DateTime.now().toIso8601String(),
      name: '',
      note: '',
      imageUrl: '',
      visibleName: false,
      visibleAddress: false,
      visiblePhone: false,
      visibleNote: false,
      userId: '',
    );

    if (tagId != null) {
      tagData = Provider.of<Tags>(context).findTag(tagId as String);
    }

    return Scaffold(
      appBar: customAppBar('Tag'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    textAlign: TextAlign.center,
                    name: 'name',
                    initialValue: tagData.name,
                    decoration: const InputDecoration(
                      labelText: 'Tag name',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  Container(
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Import these datas from profile?'),
                        FormBuilderCheckbox(
                          name: 'visible-name',
                          initialValue: tagData.visibleName,
                          title: const Text(
                            'Visible name',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-address',
                          initialValue: tagData.visibleAddress,
                          title: const Text(
                            'Visible address',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-phone',
                          initialValue: tagData.visiblePhone,
                          title: const Text(
                            'Visible phone number',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-note',
                          initialValue: tagData.visibleNote,
                          title: const Text(
                            'Visible note',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormBuilderImagePicker(
                    name: 'image_picker',
                    decoration:
                        const InputDecoration(labelText: 'Upload your photo'),
                    maxImages: 1,
                  ),
                  FormBuilderTextField(
                    name: 'note',
                    initialValue: tagData.note,
                    decoration: const InputDecoration(
                      labelText: 'Any note for this tag.',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _formKey.currentState?.save();
                if (_formKey.currentState!.validate()) {
                  Provider.of<Tags>(context, listen: false).addTag(Tag(
                    id: tagData.id != ''
                        ? tagData.id
                        : DateTime.now().toIso8601String(),
                    name: _formKey.currentState?.value['name'],
                    note: _formKey.currentState?.value['note'],
                    imageUrl: 'TODO',
                    visibleName: _formKey.currentState?.value['visible-name'],
                    visibleAddress:
                        _formKey.currentState?.value['visible-address'],
                    visiblePhone: _formKey.currentState?.value['visible-phone'],
                    visibleNote: _formKey.currentState?.value['visible-note'],
                    userId: '',
                  ));
                  await Provider.of<Tags>(context, listen: false)
                      .getTagsFromAPI();
                  Navigator.of(context).pop();
                } else {
                  print("validation failed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
