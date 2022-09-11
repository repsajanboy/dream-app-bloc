import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
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
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_today_rounded,
                                color: AppColors.dreams,
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
                                        UpsertInputDateChanged(inputDate: date),
                                      );
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
          height: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Story:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
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
                      cursorColor: AppColors.dreams,
                      style: context.typo.upsertFormStyle(),
                      decoration: InputDecoration(
                        hintText: 'Describe your dream here in details...',
                        hintStyle: context.typo.upsertHintStyle(),
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
