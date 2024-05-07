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

  EpicImageBloc({required this.getEpicImageUseCase})
      : super(EpicImageInicial()) {
    // on<EpicImageEvent>((event, emit) {});
    on<GetEpicImageEvent>(_getEpicImage);
  }

  void _getEpicImage(
      GetEpicImageEvent event, Emitter<EpicImageState> emit) async {
    final List<EpicImageEntity> epicImage =
        await getEpicImageUseCase.callGetEpicImage(day: event.day);

    print(epicImage);

    epicImageGuardadas = List<EpicImageEntity>.from(epicImage);

    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      index = (index + 1) % epicImageGuardadas.length;
      print(index);
      emit(EpicImageLoaded(epicImage: epicImageGuardadas[index]));
    }

    // _startImageAnimation(emit: emit, lneht: epicImageGuardadas.length);
  }

  // void _startImageAnimation(
  //     {required int lneht, required Emitter<EpicImageState> emit}) async {
  //   Timer.periodic(const Duration(seconds: 2), (timer) {
  //     index = (index + 1) % lneht;
  //     emit(EpicImageLoaded(epicImage: epicImageGuardadas[index]));
  //   });

  //   // while (true) {
  //   //   await Future.delayed(const Duration(seconds: 2));
  //   //   index = (index + 1) % lneht;
  //   //   emit(EpicImageLoaded(epicImage: epicImageGuardadas[index]));
  //   // }
  // }

  void reseteoListasIndex() {
    index = 0;
    epicImageGuardadas = [];
  }

  //? llamadas a eventos
  void getEpicImage({required DateTime dia}) {
    add(GetEpicImageEvent(day: dia));
  }
}
