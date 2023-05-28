import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/unsplash_client.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard({Key? key}) : super(key: key);

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
            height: 160,
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                    imageUrl:
                    'https://images.unsplash.com/photo-1682685797660-3d847763208e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80')),
                const SizedBox(width: 10),
                const Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description is asdjkansoi te asdoioii asd sdasdasd.",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Aakash Nilavan",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "2345 likes",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )),
                  ],
                ))
              ],
            )),
      ),
      onTap: () {
        Unsplash().searchImage("tree", 1);
      },
    );
  }
}
