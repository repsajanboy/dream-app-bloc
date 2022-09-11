import 'package:dream_app_bloc/data/dream/dream_rates.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingWidget extends StatelessWidget {
  final bool isEditing;
  const RatingWidget({Key? key, required this.isEditing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Text(
          'How would you rate your dream?',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    ratings[state.rate].emoji,
                    style: const TextStyle(
                      fontSize: 64.0,
                    ),
                  ),
                  Text(
                    ratings[state.rate].rateStr,
                    style: const TextStyle(
                      fontSize: 32.0,
                      color: AppColors.dreams,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Slider(
                            value: state.rate.toDouble(),
                            //label: _emojis[_value.toInt()],
                            min: 1.0,
                            max: 5.0,
                            divisions: 5,
                            onChanged: (double value) {
                              context
                                  .read<UpsertDreamBloc>()
                                  .add(UpsertRateChanged(rate: value.toInt()));
                            },
                            activeColor: Colors.indigoAccent,
                            inactiveColor: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
