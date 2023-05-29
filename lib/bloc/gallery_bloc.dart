import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../utils/unsplash_client.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState.initial()) {
    on<GetSearchPhoto>((event, emit) async {
      if (event.clearPrev) {
        emit(GalleryState(loading: true, showPhotoDetail: false));
      } else {
        emit(state.copyWith(loading: true, showPhotoDetail: false));
      }

      final result = await Unsplash().searchImage(event.query, event.page);

      if (result.hasData) {
        emit(state.copyWith(
            loading: false,
            currentPage: event.page,
            query: event.query,
            total: result.data!.total,
            searchResults: (state.searchResults ?? []) + result.data!.results,
            showPhotoDetail: false));
      } else {
        emit(state.copyWith(
            loading: false,
            currentPage: event.page,
            query: event.query,
            error: 'Error Occurred : ${result.statusCode}',
            showPhotoDetail: false));
      }
    });
    on<GetPhotoDetail>((event, emit) async {
      final result = await Unsplash().getPhotoDetail(event.id);
      if (result.hasData) {
        emit(state.copyWith(photoDetails: result.data, showPhotoDetail: true));
      } else {
        emit(state.copyWith(error: 'Error Occurred : ${result.statusCode}'));
      }
    });
  }
}
