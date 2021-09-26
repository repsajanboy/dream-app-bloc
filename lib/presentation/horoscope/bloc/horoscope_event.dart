part of 'horoscope_bloc.dart';

abstract class HoroscopeEvent extends Equatable {
  const HoroscopeEvent();
}

class HoroscopeFetched extends HoroscopeEvent {
  final String sign;
  const HoroscopeFetched({required this.sign});

  @override
  List<Object> get props => [];
}
