part of 'epic_image_slider_bloc.dart';

// sealed class EpicImageSliderEvent extends Equatable {
//   const EpicImageSliderEvent();

//   @override
//   List<Object> get props => [];
// }

sealed class EpicImageSliderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadImages extends EpicImageSliderEvent {}

class NextImage extends EpicImageSliderEvent {}

class PreviousImage extends EpicImageSliderEvent {}
