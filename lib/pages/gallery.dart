import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/bloc/gallery_bloc.dart';
import 'package:photo_gallery/pages/photo_detailed.dart';
import 'package:photo_gallery/pages/ui_components/gallery_card.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  TextEditingController queryController = TextEditingController();
  ScrollController? scrollController;
  Timer? _debounce;

  String? query;
  int? currPage;
  int? limit;
  int? current;
  bool? isLoading;

  _update(q, cp, l, c, il) {
    query = q;
    currPage = cp;
    limit = l;
    current = c;
    isLoading = il;
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<GalleryBloc>(context).add(
          GalleryEvent.searchPhoto(query: query, page: 1, clearPrev: true));
    });
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(_scrollListener);
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
            onChanged: (value) => _onSearchChanged(value),
            controller: queryController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: "Search"),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: BlocBuilder<GalleryBloc, GalleryState>(
            builder: (context, state) {
              if (state.showPhotoDetail && state.photoDetails != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetail(photo: state.photoDetails!),
                      ));
                });
              }
              if (((state.loading && (state.currentPage ?? 0) > 1) ||
                  state.searchResults != null)) {
                _update(state.query, state.currentPage, state.total,
                    state.searchResults?.length, state.loading);
                if (state.searchResults!.isEmpty) {
                  return Center(
                    child: Text('No results found',
                        style: TextStyle(
                            fontSize: 20, color: Colors.cyan.withOpacity(0.5))),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return GalleryCard(photo: state.searchResults![index]);
                      },
                      itemCount: state.searchResults!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                    )),
                    if (!state.showPhotoDetail && state.loading)
                      const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                  ],
                );
              } else if (state.error != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error!)));
                });
              } else if (state.error == null && state.searchResults == null) {
                return Center(
                  child: Text("Search to get images",
                      style: TextStyle(
                          fontSize: 20, color: Colors.blue.withOpacity(0.5))),
                );
              }
              return Center(
                child: Text('Some error occurred',
                    style: TextStyle(
                        fontSize: 20, color: Colors.yellow.withOpacity(0.5))),
              );
            },
          )),
        ],
      ),
    ));
  }

  void _scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      if (limit! > current!) {
        if (!isLoading!) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            BlocProvider.of<GalleryBloc>(context).add(GalleryEvent.searchPhoto(
                query: query!, page: currPage! + 1, clearPrev: false));
          });
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController?.removeListener(_scrollListener);
    _debounce?.cancel();
    scrollController?.dispose();
    queryController.dispose();
    super.dispose();
  }
}
