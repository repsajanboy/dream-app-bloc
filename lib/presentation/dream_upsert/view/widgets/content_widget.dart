import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../upsert_dream.dart';

class ContentFormWidget extends StatelessWidget {
  final bool isEditing;
  final String? content;
  const ContentFormWidget({Key? key, required this.isEditing, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text('Date'),
            const SizedBox(
              height: 8.0,
            ),
            BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: isEditing ? state.inputDate : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2222),
                    ).then((date) {
                      context
                          .read<UpsertDreamBloc>()
                          .add(UpsertInputDateChanged(inputDate: date));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child:
                        Text(DateFormat.yMMMMEEEEd().format(state.inputDate)),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Story'),
            const SizedBox(
              height: 8.0,
            ),
            BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: isEditing ? state.content != "" ? state.content : content! : '',
                  decoration: const InputDecoration(
                    hintText: 'Describe your dream here in details...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                  onChanged: (value) {
                    context
                        .read<UpsertDreamBloc>()
                        .add(UpsertContentChanged(content: value));
                  },
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
