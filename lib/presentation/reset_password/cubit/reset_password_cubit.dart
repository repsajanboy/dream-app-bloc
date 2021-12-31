import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthorizationRepository authorizationRepository;
  ResetPasswordCubit({required this.authorizationRepository}) : super(ResetPasswordInitial());

  Future<void> getVerificationCode(String email) async {
    try{
      final verificationCode = await authorizationRepository.resetPassword(email);
      emit(state.copyWith( verificationCode: verificationCode["verificationCode"].toString()));
    } catch (err) {
      print(err.toString());
    }
  }
}
