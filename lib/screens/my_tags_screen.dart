import 'package:flutter/material.dart';
import '../models/tag.dart';
import '../models/tags.dart';
import 'tag_form_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/tag_item.dart';
import '../widgets/tag_list_item.dart';
import 'package:provider/provider.dart';

class MyTagsScreen extends StatelessWidget {
  static String routeName = '/my-tags-screen';
  static Future<void> rebuildTags(BuildContext context) async {
    await Provider.of<Tags>(context, listen: false).getTagsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final tagsData = Provider.of<Tags>(context);

    return Scaffold(
      appBar: customAppBar('My tags'),
      body: RefreshIndicator(
        onRefresh: () => rebuildTags(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<Tags>(builder: (_, tagsData, widget) {
            return ListView.builder(
                itemCount: tagsData.tags.length + 1,
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.blue,
                          child: ListTile(
                            title: Text('Add new tag'),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(TagFormScreen.routeName);
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TagItem(
                          tagsData.tags[i - 1].id,
                          tagsData.tags[i - 1].name,
                        ),
                      ],
                    );
                  }
                });
          }),
        ),
      ),
    );
  }
}
