import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../upsert_dream.dart';

class TitleSaveWidget extends StatelessWidget {
  final bool isEditing;
  const TitleSaveWidget({Key? key, required this.isEditing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title:'),
        const SizedBox(
          height: 8.0,
        ),
        BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
          builder: (context, state) {
            return TextFormField(
              initialValue: isEditing ? state.title : '',
              decoration: const InputDecoration(
                hintText: 'Add title to your dream',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context
                    .read<UpsertDreamBloc>()
                    .add(UpsertTitleChanged(title: value));
              },
            );
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  isEditing
                      ? context.read<UpsertDreamBloc>().add(UpsertEditSaved())
                      : context.read<UpsertDreamBloc>().add(UpsertSaved());
                },
                child: const Text('Save'),
              );
            },
          ),
        )
      ],
    );
  }
}
