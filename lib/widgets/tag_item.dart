import 'package:flutter/material.dart';
import 'package:goreader/models/tags.dart';
import 'package:goreader/screens/tag_form_screen.dart';
import 'package:provider/provider.dart';

class TagItem extends StatelessWidget {
  final String id;
  final String name;

  TagItem(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Colors.green,
        child: ListTile(
          title: Text(name),
          trailing: Container(
            width: 100,
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
                  icon: Icon(Icons.delete_forever),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
