import 'package:flutter/material.dart';
import 'package:photo_gallery/pages/ui_components/gallery_card.dart';
import 'package:photo_gallery/utils/unsplash_client.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: queryController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: "Search"),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return const GalleryCard();
            },
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
          )),
        ],
      ),
    ));
  }
}
