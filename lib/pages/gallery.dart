import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/bloc/gallery_bloc.dart';
import 'package:photo_gallery/pages/ui_components/gallery_card.dart';

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
            onChanged: (value) => BlocProvider.of<GalleryBloc>(context)
                .add(GalleryEvent.searchPhoto(query: value, page: 1)),
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
              child: BlocBuilder<GalleryBloc, GalleryState>(

            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                );
              } else if (state.results != null) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return GalleryCard(photo: state.results!.results[index]);
                  },
                  itemCount: state.results!.results.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                );
              } else if (state.error != null) {
                return const Center(
                  child: Text("Error Occurred"),
                );
              } else if (state.error == null && state.results == null) {
                return const Center(
                  child: Text("Search to get images"),
                );
              }
              return const Center(
                child: Text("Some Error Occurred"),
              );
            },
          )),
        ],
      ),
    ));
  }
}
