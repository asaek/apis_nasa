part of 'menu_principal_bloc.dart';

sealed class MenuPrincipalState extends Equatable {
  const MenuPrincipalState();

  @override
  List<Object> get props => [];
}

final class MenuPrincipalInitial extends MenuPrincipalState {}

final class MenuPrincipalLoading extends MenuPrincipalState {}

final class MenuPrincipalLoaded extends MenuPrincipalState {
  final List<ImageDayEntitie> images;
  const MenuPrincipalLoaded({required this.images});

  @override
  List<Object> get props => [images];
}
