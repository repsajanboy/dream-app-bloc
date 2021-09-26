part of 'horoscope_bloc.dart';

abstract class HoroscopeState extends Equatable {
  const HoroscopeState();

  @override
  List<Object> get props => [];
}

class HoroscopeInitial extends HoroscopeState {}

class HoroscopeFetchedSuccess extends HoroscopeState {
  final Horoscope horoscope;

  const HoroscopeFetchedSuccess({required this.horoscope});
  @override
  List<Object> get props => [horoscope];
}

class HoroscopeFetchedLoading extends HoroscopeState{}

class HoroscopeFetchedError extends HoroscopeState {}
