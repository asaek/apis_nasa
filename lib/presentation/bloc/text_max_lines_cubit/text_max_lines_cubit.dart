import 'package:bloc/bloc.dart';

class TextMaxLinesCubit extends Cubit<bool> {
  TextMaxLinesCubit() : super(false);

  void excedeMax() {
    emit(true);
  }

  void noExcedeMax() {
    emit(false);
  }
}
