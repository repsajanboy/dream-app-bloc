part of 'bottomtab_bloc.dart';

@immutable
abstract class BottomtabState {}

class BottomtabInitial extends BottomtabState {}

class CreateBottomTab extends BottomtabState{
  final int currentIndex;
  final List<BottomTabItemType> items;

  CreateBottomTab({required this.currentIndex, required this.items});
}
