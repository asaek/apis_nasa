import 'package:bloc/bloc.dart';

class MoreTextCubit extends Cubit<bool> {
  MoreTextCubit() : super(false);

  void moreText() {
    emit(!state);
  }
}
