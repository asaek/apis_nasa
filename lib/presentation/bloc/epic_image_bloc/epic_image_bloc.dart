import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../use_cases/use_case.dart';

part 'epic_image_event.dart';
part 'epic_image_state.dart';

class EpicImageBloc extends Bloc<EpicImageEvent, EpicImageState> {
  final GetEpicImageUseCase getEpicImageUseCase;
  late List<EpicImageEntity> epicImageGuardadas;
  int index = 0;
  bool isRUnning = true;

  EpicImageBloc({required this.getEpicImageUseCase})
      : super(EpicImageInicial()) {
    // on<EpicImageEvent>((event, emit) {});
    on<GetEpicImageEvent>(_getEpicImage);
  }

  void _getEpicImage(
      GetEpicImageEvent event, Emitter<EpicImageState> emit) async {
    final List<EpicImageEntity> epicImage =
        await getEpicImageUseCase.callGetEpicImage(day: event.day);

    epicImageGuardadas = List<EpicImageEntity>.from(epicImage);

    while (isRUnning) {
      await Future.delayed(const Duration(seconds: 2));
      index = (index + 1) % epicImageGuardadas.length;
      // print(index);
      emit(EpicImageLoaded(epicImage: epicImageGuardadas[index]));
    }

    // Timer.periodic(const Duration(seconds: 2), (timer) {
    //   index = (index + 1) % epicImageGuardadas.length;
    //   emit(EpicImageLoaded(epicImage: epicImageGuardadas[index]));
    // });
  }

  void reseteoListasIndex() {
    index = 0;
    epicImageGuardadas = [];
    isRUnning = true;
  }

  void stopSlider() {
    isRUnning = false;
  }

  //? llamadas a eventos
  void getEpicImage({required DateTime dia}) {
    add(GetEpicImageEvent(day: dia));
  }
}
