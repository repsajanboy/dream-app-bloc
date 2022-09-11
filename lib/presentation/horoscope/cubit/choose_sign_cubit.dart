import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_sign_state.dart';

class ChooseSignCubit extends Cubit<ChooseSignState> {
  ChooseSignCubit() : super(ChooseSignInitial());

  void changeSelectedSign(String sign) {
    emit(state.copyWith(sign: sign));
  }
}
