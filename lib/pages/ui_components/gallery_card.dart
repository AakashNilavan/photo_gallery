import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../../bloc/gallery_bloc.dart';

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
            height: 180,
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
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
                            widget.photo.user.firstName,
                            style: const TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.photo.description ?? "",
                        style: const TextStyle(fontSize: 15),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${widget.photo.likes} likes",
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.download,
                            color: Colors.blue,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${widget.photo.downloads ?? 0}",
                            style: const TextStyle(fontSize: 15),
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
        BlocProvider.of<GalleryBloc>(context)
            .add(GalleryEvent.getPhotoDetail(id: widget.photo.id));
      },
    );
  }
}
