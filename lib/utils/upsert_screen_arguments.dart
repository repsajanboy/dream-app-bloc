import 'package:dream_app_bloc/data/dream/dream.dart';

class UpsertScreenArgument {
  final bool isEditing;
  final Dream? dream;

  UpsertScreenArgument(this.isEditing, this.dream);
}