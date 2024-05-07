part of 'epic_image_slider_bloc.dart';

// sealed class EpicImageSliderState extends Equatable {
//   const EpicImageSliderState();

//   @override
//   List<Object> get props => [];
// }

// final class EpicImageSliderInitial extends EpicImageSliderState {}

sealed class EpicImageSliderState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageLoading extends EpicImageSliderState {}

class ImagesReady extends EpicImageSliderState {
  final List<String> imageURLs;
  final int currentIndex;

  ImagesReady({required this.imageURLs, required this.currentIndex});

  @override
  List<Object> get props => [imageURLs, currentIndex];
}

class ImageError extends EpicImageSliderState {
  final String message;

  ImageError(this.message);

  @override
  List<Object> get props => [message];
}
