import 'package:dream_app_bloc/repositories/horoscope_repository.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../horoscope.dart';

class HoroscopePage extends StatelessWidget {
  HoroscopePage({Key? key}) : super(key: key);

  final signs = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces'
  ];
  @override
  Widget build(BuildContext context) {
    String _selectedSign = "";
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HoroscopeBloc(
                horoscopeRepository: context.read<HoroscopeRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => ChooseSignCubit(),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Daily',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dreams,
                      ),
                    ),
                    Text(
                      'Horoscope',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dreams,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const Text(
                      'Choose you sign: ',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: BlocBuilder<ChooseSignCubit, ChooseSignState>(
                        builder: (context, state) {
                          return DropdownButton(
                            isExpanded: true,
                            iconSize: 32.0,
                            hint: const Text('Please select a sign...'),
                            value: state.sign,
                            items: signs.map(
                              (String signs) {
                                return DropdownMenuItem(
                                  value: signs,
                                  child: Text(
                                    signs,
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (newSign) {
                              context
                                  .read<ChooseSignCubit>()
                                  .changeSelectedSign(newSign.toString());
                              _selectedSign = newSign.toString();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<HoroscopeBloc, HoroscopeState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context
                              .read<HoroscopeBloc>()
                              .add(HoroscopeFetched(sign: _selectedSign));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Colors.indigoAccent),
                        child: const Text(
                          'Get Predictions',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<HoroscopeBloc, HoroscopeState>(
                    builder: (context, state) {
                      if (state is HoroscopeFetchedSuccess) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.horoscope.description,
                              style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Color: ${state.horoscope.color}'),
                                Text(
                                  'Lucky number: ${state.horoscope.luckyNumber}',
                                ),
                                Text('Mood: ${state.horoscope.mood}'),
                              ],
                            ),
                          ],
                        );
                      } else if (state is HoroscopeFetchedLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.indigoAccent,
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Select your sign'),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
