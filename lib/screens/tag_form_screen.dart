import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../models/tag.dart';
import '../models/tags.dart';
import '../widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class TagFormScreen extends StatefulWidget {
  static String routeName = '/tag-form';

  const TagFormScreen({Key? key}) : super(key: key);

  @override
  _TagFormScreenState createState() => _TagFormScreenState();
}

class _TagFormScreenState extends State<TagFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final tagId = ModalRoute.of(context)?.settings.arguments;
    Tag? tagData;
    File? imageFile;

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
                    initialValue: tagData?.name ?? '',
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
                          initialValue: tagData?.visibleName ?? false,
                          title: const Text(
                            'Visible name',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-address',
                          initialValue: tagData?.visibleAddress ?? false,
                          title: const Text(
                            'Visible address',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-phone',
                          initialValue: tagData?.visiblePhone ?? false,
                          title: const Text(
                            'Visible phone number',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FormBuilderCheckbox(
                          name: 'visible-note',
                          initialValue: tagData?.visibleNote ?? false,
                          title: const Text(
                            'Visible note',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormBuilderImagePicker(
                    name: 'imageUrl',
                    initialValue: [
                      tagData?.imageUrl == '' ? null : tagData?.imageUrl
                    ],
                    decoration:
                        const InputDecoration(labelText: 'Upload your photo'),
                    maxImages: 1,
                    imageQuality: 30,
                    onSaved: (images) {
                      // log('onSaved has started');
                      images?.forEach((element) async {
                        File newImage = File(element.path.toString());
                        imageFile = newImage;
                      });
                    },
                  ),
                  FormBuilderTextField(
                    name: 'note',
                    initialValue: tagData?.note ?? '',
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
                  var imageUrlDb = tagData?.imageUrl ?? '';
                  if (imageFile != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Image is uploading to the magic cloud, please wait...'),
                      ),
                    );
                    imageUrlDb = await Provider.of<Tags>(context, listen: false)
                        .saveImageURL(imageFile!);
                  }
                  log('ImageUrl' + imageUrlDb);
                  Provider.of<Tags>(context, listen: false).addTag(Tag(
                    id: tagData?.id ?? ' ',
                    name: _formKey.currentState?.value['name'],
                    note: _formKey.currentState?.value['note'],
                    imageUrl: imageUrlDb,
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
                  log("validation failed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
