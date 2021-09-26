part of 'choose_sign_cubit.dart';

class ChooseSignState extends Equatable {
  final String sign;
  const ChooseSignState({
    this.sign = 'Aries',
  });

  ChooseSignState copyWith({
    String? sign,
  }) {
    return ChooseSignState(
      sign: sign ?? this.sign,
    );
  }

  @override
  List<Object> get props => [sign];
}

class ChooseSignInitial extends ChooseSignState {}
