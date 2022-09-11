import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TitleSaveWidget extends StatelessWidget {
  final bool isEditing;
  const TitleSaveWidget({Key? key, required this.isEditing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          'Make your dream more memorable!',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Column(
            children: [
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
                        cursorColor: AppColors.dreams,
                        initialValue: isEditing ? state.title : '',
                        style: context.typo.upsertFormStyle(),
                        decoration: InputDecoration(
                          hintText: 'Add title to your here..',
                          hintStyle: context.typo.upsertHintStyle(),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          context
                              .read<UpsertDreamBloc>()
                              .add(UpsertTitleChanged(title: value));
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigoAccent,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        isEditing
                            ? context
                                .read<UpsertDreamBloc>()
                                .add(UpsertEditSaved())
                            : context
                                .read<UpsertDreamBloc>()
                                .add(UpsertSaved());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Save'),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
