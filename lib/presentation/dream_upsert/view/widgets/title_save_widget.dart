import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import '../../upsert_dream.dart';

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
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        cursorColor: Colors.white,
                        initialValue: isEditing ? state.title : '',
                        style: context.typo.upsertFormStyle(),
                        decoration: InputDecoration(
                          hintText: 'Add title to your here..',
                          hintStyle: context.typo.authHintStyle(),
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
