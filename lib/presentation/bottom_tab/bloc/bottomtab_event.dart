part of 'bottomtab_bloc.dart';

@immutable
abstract class BottomtabEvent {}

class InitialBottomTab extends BottomtabEvent{
  final int index;

  InitialBottomTab(this.index);
}

class BottomTabChanged extends BottomtabEvent {
  final int index;

  BottomTabChanged(this.index);
}
