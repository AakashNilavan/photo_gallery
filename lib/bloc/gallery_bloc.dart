import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../utils/unsplash_client.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState.initial()) {
    on<GalleryEvent>((event, emit) async {

        emit(const GalleryState(loading: true));

        final result = await Unsplash().searchImage(event.query, event.page);

        if(result.hasData){
          print(result.data);
          emit(
            state.copyWith(
              loading: false,
              currentPage: event.page,
              results: result.data,
            )
          );
        }
        else{
          emit(
              state.copyWith(
                loading: false,
                currentPage: event.page,
                error: 'Error Occurred : ${result.statusCode}'
              )
          );
        }
    });
  }
}
