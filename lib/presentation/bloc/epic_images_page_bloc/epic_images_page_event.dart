part of 'epic_images_page_bloc.dart';

sealed class EpicImagesPageEvent extends Equatable {
  const EpicImagesPageEvent();

  @override
  List<Object> get props => [];
}

final class EpicInitialImageEvent extends EpicImagesPageEvent {}

final class EpicImagesNextEvent extends EpicImagesPageEvent {}
