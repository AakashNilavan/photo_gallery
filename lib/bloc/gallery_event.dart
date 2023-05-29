part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.searchPhoto(
      {required String query,
      required int page,
      required bool clearPrev}) = GetSearchPhoto;

  const factory GalleryEvent.getPhotoDetail({required String id}) =
      GetPhotoDetail;
}
