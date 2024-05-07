part of 'epic_image_bloc.dart';

sealed class EpicImageEvent extends Equatable {
  const EpicImageEvent();

  @override
  List<Object> get props => [];
}

class GetEpicImageEvent extends EpicImageEvent {
  final DateTime day;

  const GetEpicImageEvent({required this.day});

  @override
  List<Object> get props => [day];
}
