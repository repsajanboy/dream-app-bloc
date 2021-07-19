import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_app_bloc/presentation/bottom_tab/bloc/bottomtab_item_type.dart';
import 'package:meta/meta.dart';

part 'bottomtab_event.dart';
part 'bottomtab_state.dart';

class BottomtabBloc extends Bloc<BottomtabEvent, BottomtabState> {
  int currentIndex = 0;
  BottomtabBloc() : super(BottomtabInitial());

  @override
  Stream<BottomtabState> mapEventToState(
    BottomtabEvent event,
  ) async* {
    if (event is InitialBottomTab) {
      yield CreateBottomTab(currentIndex: currentIndex, items: _getItems());
    } else if(event is BottomTabChanged) {
      currentIndex = event.index;
      yield CreateBottomTab(currentIndex: currentIndex, items: _getItems());
    }
  }

  List<BottomTabItemType> _getItems() {
    return [
      BottomTabItemType.home,
      BottomTabItemType.search,
      BottomTabItemType.statistic,
      BottomTabItemType.profile,
    ];
  }
}
