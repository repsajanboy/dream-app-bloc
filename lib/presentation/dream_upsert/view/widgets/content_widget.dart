import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';

import '../../upsert_dream.dart';

class ContentFormWidget extends StatelessWidget {
  final bool isEditing;
  final String? content;
  const ContentFormWidget({Key? key, required this.isEditing, this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              DateFormat.yMMMMEEEEd().format(state.inputDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: isEditing
                                      ? state.inputDate
                                      : DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2222),
                                ).then((date) {
                                  context.read<UpsertDreamBloc>().add(
                                      UpsertInputDateChanged(inputDate: date));
                                });
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Story:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade900,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade800.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: isEditing
                          ? state.content != ""
                              ? state.content
                              : content!
                          : '',
                      cursorColor: Colors.white,
                      style: context.typo.upsertFormStyle(),
                      decoration: InputDecoration(
                        hintText: 'Describe your dream here in details...',
                        hintStyle: context.typo.authHintStyle(),
                        border: InputBorder.none,
                      ),
                      maxLines: 15,
                      onChanged: (value) {
                        context
                            .read<UpsertDreamBloc>()
                            .add(UpsertContentChanged(content: value));
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
