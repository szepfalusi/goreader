import 'package:flutter/material.dart';
import '../models/tags.dart';
import 'tag_form_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/tag_item.dart';
import 'package:provider/provider.dart';

class MyTagsScreen extends StatefulWidget {
  static String routeName = '/my-tags-screen';

  const MyTagsScreen({Key? key}) : super(key: key);

  @override
  State<MyTagsScreen> createState() => _MyTagsScreenState();
}

class _MyTagsScreenState extends State<MyTagsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<Tags>(context, listen: false).getTagsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, this was used in this file
    final tagsData = Provider.of<Tags>(context);

    return Scaffold(
      appBar: customAppBar('My tags'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Tags>(context, listen: false).getTagsFromAPI();
        },
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
                            title: const Text('Add new tag'),
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
