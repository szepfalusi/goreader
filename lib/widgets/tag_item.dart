import 'package:flutter/material.dart';
import 'package:goreader/helpers/nfc_helper.dart';
import '../models/tags.dart';
import '../screens/tag_form_screen.dart';
import 'package:provider/provider.dart';

class TagItem extends StatelessWidget {
  final String id;
  final String name;

  const TagItem(this.id, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Colors.green,
        child: ListTile(
          title: Text(name),
          trailing: SizedBox(
            width: 150,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(TagFormScreen.routeName, arguments: id);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Tags>(context, listen: false).removeTag(id);
                  },
                  icon: const Icon(Icons.delete_forever),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Push your phone to your NFC tag.')));
                    NfcHelper().writeNfc(id);
                  },
                  icon: const Icon(Icons.wifi),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
