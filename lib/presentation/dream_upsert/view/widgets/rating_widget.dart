import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../upsert_dream.dart';

class RatingWidget extends StatelessWidget {
  final bool isEditing;
  const RatingWidget({Key? key, required this.isEditing}) : super(key: key);

  static const _emojis = ['😞', '😜', '🤓', '😁', '😂', '😃'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0),
        const Text('How would you rate your dream?'),
        Expanded(
          child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _emojis[state.rate],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_emojis[0], softWrap: true),
                        Expanded(
                          child: Slider(
                            value: state.rate.toDouble(),
                            //label: _emojis[_value.toInt()],
                            min: 1.0,
                            max: 6.0,
                            divisions: 5,
                            onChanged: (double value) {
                              context
                                  .read<UpsertDreamBloc>()
                                  .add(UpsertRateChanged(rate: value.toInt()));
                            },
                            activeColor: Colors.purple,
                            inactiveColor: Colors.black45,
                          ),
                        ),
                        Text(
                          _emojis[5],
                          softWrap: true,
                        )
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
