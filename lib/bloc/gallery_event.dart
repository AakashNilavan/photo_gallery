part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.searchPhoto({required String query,required int page}) =
      GetSearchPhoto;
}
