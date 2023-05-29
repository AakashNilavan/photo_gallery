part of 'gallery_bloc.dart';

@unfreezed
class GalleryState with _$GalleryState {
  factory GalleryState(
      {@Default(false) bool loading,
      String? error,
      int? total,
      List<Photo>? searchResults,
      Photo? photoDetails,
      @Default(false) bool showPhotoDetail,
      String? query,
      int? currentPage}) = _GalleryState;

  factory GalleryState.initial({
    bool loading = false,
    String? error,
    int? total,
    List<Photo>? searchResults,
    Photo? photoDetails,
    bool showPhotoDetail = false,
    String? query,
    int? currentPage,
  }) =>
      GalleryState(
          loading: loading,
          error: error,
          total: total,
          searchResults: searchResults,
          photoDetails: photoDetails,
          showPhotoDetail: showPhotoDetail,
          query: query,
          currentPage: currentPage);
}
