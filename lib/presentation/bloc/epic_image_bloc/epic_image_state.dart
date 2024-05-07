part of 'epic_image_bloc.dart';

sealed class EpicImageState extends Equatable {
  const EpicImageState();

  @override
  List<Object> get props => [];
}

class EpicImageInicial extends EpicImageState {}

class EpicImageLoaded extends EpicImageState {
  final EpicImageEntity epicImage;

  const EpicImageLoaded({required this.epicImage});

  @override
  List<Object> get props => [epicImage];
}
