import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'epic_image_slider_event.dart';
part 'epic_image_slider_state.dart';

// class EpicImageSliderBloc extends Bloc<EpicImageSliderEvent, EpicImageSliderState> {
//   EpicImageSliderBloc() : super(EpicImageSliderInitial()) {
//     on<EpicImageSliderEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

// class EpicImageSliderBloc extends Bloc<EpicImageSliderEvent, EpicImageSliderState> {
//   final List<String>
//       _imageURLs; // Aquí se deben cargar las URLs de las imágenes

//   ImageBloc(this._imageURLs) : super(ImageLoading()) {
//     on<LoadImages>((event, emit) =>
//         emit(ImagesReady(imageURLs: _imageURLs, currentIndex: 0)));
//     on<NextImage>((event, emit) {
//       if (state is ImagesReady) {
//         var currentState = state as ImagesReady;
//         var nextIndex = (currentState.currentIndex + 1) % _imageURLs.length;
//         emit(ImagesReady(imageURLs: _imageURLs, currentIndex: nextIndex));
//       }
//     });
//     on<PreviousImage>((event, emit) {
//       if (state is ImagesReady) {
//         var currentState = state as ImagesReady;
//         var previousIndex =
//             (currentState.currentIndex - 1 + _imageURLs.length) %
//                 _imageURLs.length;
//         emit(ImagesReady(imageURLs: _imageURLs, currentIndex: previousIndex));
//       }
//     });
//   }
// }

class EpicImageSliderBloc
    extends Bloc<EpicImageSliderEvent, EpicImageSliderState> {
  final List<String>
      _imageURLs; // Aquí se deben cargar las URLs de las imágenes
  Timer? _timer;

  EpicImageSliderBloc(this._imageURLs) : super(ImageLoading()) {
    on<LoadImages>((event, emit) {
      emit(ImagesReady(imageURLs: _imageURLs, currentIndex: 0));
      _startAutoSlide();
    });
    on<NextImage>((event, emit) => _handleNextImage(emit));
    on<PreviousImage>((event, emit) => _handlePreviousImage(emit));
  }

  void _handleNextImage(Emitter<EpicImageSliderState> emit) {
    if (state is ImagesReady) {
      var currentState = state as ImagesReady;
      var nextIndex = (currentState.currentIndex + 1) % _imageURLs.length;
      emit(ImagesReady(imageURLs: _imageURLs, currentIndex: nextIndex));
    }
  }

  void _handlePreviousImage(Emitter<EpicImageSliderState> emit) {
    if (state is ImagesReady) {
      var currentState = state as ImagesReady;
      var previousIndex = (currentState.currentIndex - 1 + _imageURLs.length) %
          _imageURLs.length;
      emit(ImagesReady(imageURLs: _imageURLs, currentIndex: previousIndex));
    }
  }

  void _startAutoSlide() {
    _timer?.cancel(); // Cancela el timer anterior si existe
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Añade el evento NextImage cada 2 segundos
      add(NextImage());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Asegúrate de cancelar el timer al cerrar el Bloc
    return super.close();
  }
}
