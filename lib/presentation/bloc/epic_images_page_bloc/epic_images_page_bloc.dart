import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'epic_images_page_event.dart';
part 'epic_images_page_state.dart';

class EpicImagesPageBloc
    extends Bloc<EpicImagesPageEvent, EpicImagesPageState> {
  EpicImagesPageBloc() : super(EpicImagesInitialState()) {
    // on<EpicImagesPageEvent>((event, emit) {});
    on<EpicImagesPageEvent>(_fecthInitialImages);
  }
  void _fecthInitialImages(
      EpicImagesPageEvent event, Emitter<EpicImagesPageState> emit) {}
  void fectFirstImages() {
    add(EpicInitialImageEvent());
  }
}
