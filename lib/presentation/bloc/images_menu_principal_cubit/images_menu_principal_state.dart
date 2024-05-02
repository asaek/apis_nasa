part of 'images_menu_principal_cubit.dart';

sealed class ImagesMenuPrincipalState extends Equatable {
  const ImagesMenuPrincipalState();

  @override
  List<Object> get props => [];
}

final class ImagesMenuPrincipalInitial extends ImagesMenuPrincipalState {}

final class ImagesMenuPrincipalLoading extends ImagesMenuPrincipalState {}

final class ImagesMenuPrincipalLoaded extends ImagesMenuPrincipalState {
  final List<ImageDayEntitie> images;

  const ImagesMenuPrincipalLoaded({required this.images});

  @override
  List<Object> get props => [images];
}
