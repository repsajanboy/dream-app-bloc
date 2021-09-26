import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/data/horoscope/horoscope.dart';
import 'package:dream_app_bloc/repositories/horoscope_repository.dart';
import 'package:equatable/equatable.dart';

part 'horoscope_event.dart';
part 'horoscope_state.dart';

class HoroscopeBloc extends Bloc<HoroscopeEvent, HoroscopeState> {
  final HoroscopeRepository horoscopeRepository;
  HoroscopeBloc({required this.horoscopeRepository})
      : super(HoroscopeInitial());

  @override
  Stream<HoroscopeState> mapEventToState(
    HoroscopeEvent event,
  ) async* {
    if(event is HoroscopeFetched){
      try{
        yield HoroscopeFetchedLoading();
        final horoscope = await horoscopeRepository.getHoroscope(event.sign);
        yield HoroscopeFetchedSuccess(horoscope: horoscope);
      } on Exception {
        yield HoroscopeFetchedError();
      }
    }
  }
}
