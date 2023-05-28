import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_client/unsplash_client.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

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
                        imageUrl: widget.photo.urls.small.toString())),
                const SizedBox(width: 10),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.photo.user.name,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(widget.photo.description ?? "",
                          style: const TextStyle(fontSize: 16)),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${widget.photo.likes} likes",
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      )),
                    ],
                  ),
                ))
              ],
            )),
      ),
      onTap: () {
        print(widget.photo.id);
      },
    );
  }
}
