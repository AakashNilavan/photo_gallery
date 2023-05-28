part of 'gallery_bloc.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    @Default(false) bool loading,
    String? error,
    SearchResults<Photo>? results,
    int? currentPage
  }) = _GalleryState;

  factory GalleryState.initial({
    bool loading = false,
    String? error,
    SearchResults<Photo>? results,
    int? currentPage,
  }) =>
      GalleryState(
        loading: loading,
        error: error,
        results: results,
        currentPage: currentPage
      );

}
