import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'choose_sign_state.dart';

class ChooseSignCubit extends Cubit<ChooseSignState> {
  ChooseSignCubit() : super(ChooseSignInitial());

  void changeSelectedSign(String sign) {
    emit(state.copyWith(sign: sign));
  }
}
