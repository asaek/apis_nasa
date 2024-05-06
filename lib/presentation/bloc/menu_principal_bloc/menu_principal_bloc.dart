import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../use_cases/use_case.dart';

part 'menu_principal_event.dart';
part 'menu_principal_state.dart';

class MenuPrincipalBloc extends Bloc<MenuPrincipalEvent, MenuPrincipalState> {
  final GetImageDayUseCase getImageDayUseCase;
  MenuPrincipalBloc({required this.getImageDayUseCase})
      : super(MenuPrincipalInitial()) {
    // on<MenuPrincipalEvent>(_onFechImagesMenuPrincipal);
    on<EventoCargandoImagenes>(_onFechImagesMenuPrincipal);
  }
  void _onFechImagesMenuPrincipal(
      MenuPrincipalEvent event, Emitter<MenuPrincipalState> emit) async {
    emit(MenuPrincipalLoading());
    final List<ImageDayEntitie> imagesNew =
        await getImageDayUseCase.callGetOneImage(cantidadImages: 5);

    emit(MenuPrincipalLoaded(images: imagesNew));
  }

  void loadMenuImagesPrincipal() async {
    add(EventoCargandoImagenes());
  }
}
