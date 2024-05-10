import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'boton_search_keyword_state.dart';

class BotonSearchKeywordCubit extends Cubit<BotonSearchKeywordState> {
  BotonSearchKeywordCubit() : super(const BotonSearchKeywordState(keyword: ''));

  //* Comunicacion con los bloc
  //* Recibir la keyword
  void changeKeyword({required String keyword}) {
    print(keyword);
    emit(state.copyWith(keyword: keyword));
    print(state.keyword);
  }
}
