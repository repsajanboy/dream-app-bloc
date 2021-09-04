import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream/view/widget/dream_list.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DreamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DreamBloc(dreamRepository: context.read<DreamRepository>())..add(DreamsFetched()),
        child: const DreamList(),
      ),
    );
  }
}
