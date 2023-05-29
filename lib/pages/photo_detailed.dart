import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/bloc/gallery_bloc.dart';
import 'package:unsplash_client/unsplash_client.dart';

class PhotoDetail extends StatelessWidget {
  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(width: double.infinity,child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back_outlined),
                  onTap: (){
                    BlocProvider.of<GalleryBloc>(context).state.showPhotoDetail = false;
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                      size: 22,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      photo.user.name,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover, imageUrl: photo.urls.small.toString())),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${photo.likes} likes",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.download,
                      color: Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${photo.downloads}",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                if (photo.description != null)...[
                  Text(photo.description!, overflow: TextOverflow.ellipsis, maxLines: 5,),
                  const SizedBox(height: 8),
                ],
                if (photo.tags != null)...[
                  Wrap(
                    children: [
                      for (Tag element in photo.tags!)
                        Text('#${element.title}  ')
                    ],
                  ),
                  const SizedBox(height: 8),

                ]


              ],
            ))),
      )),
    );
  }
}
