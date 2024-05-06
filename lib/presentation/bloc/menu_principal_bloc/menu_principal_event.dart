part of 'menu_principal_bloc.dart';

sealed class MenuPrincipalEvent extends Equatable {
  const MenuPrincipalEvent();

  @override
  List<Object> get props => [];
}

final class EventoCargandoImagenes extends MenuPrincipalEvent {}
