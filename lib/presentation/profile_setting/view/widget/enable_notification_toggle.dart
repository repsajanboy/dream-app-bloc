// ignore_for_file: noop_primitive_operations

import 'package:dream_app_bloc/presentation/profile_setting/profile_setting.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/notifications.dart';
import 'package:dream_app_bloc/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableNotificationToggle extends StatelessWidget {
  EnableNotificationToggle({Key? key}) : super(key: key);
  final _sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      margin: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.black26.withOpacity(0.1),
                  size: state.isDailyEnabled ? 120.0 : 90.0,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
                          builder: (context, state) {
                            return Text(
                              state.isDailyEnabled ? 'Enabled' : 'Disabled',
                              style: const TextStyle(
                                color: AppColors.dreams,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const Text(
                          'Daily Reminder',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
                      builder: (context, state) {
                        return Switch(
                          value: state.isDailyEnabled,
                          onChanged: (bool value) {
                            context.read<ProfileSettingBloc>().add(
                                IsDailyEnabledChange(isDailyEnabled: value),);
                            if (value) {
                              createDailyReminderNotification(state.timeOfDay);
                            } else {
                              cancelScheduledNotifications();
                            }
                          },
                          activeColor: Colors.indigoAccent,
                          activeTrackColor: Colors.indigo,
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.isDailyEnabled,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            const Text(
                              'Set time: ',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                showTimePicker(
                                  context: context,
                                  initialTime: state.timeOfDay,
                                ).then((time) {
                                  _sharedPref.saveStr("timeOfDay",
                                      time!.format(context).toString(),);
                                  context.read<ProfileSettingBloc>().add(
                                      ProfileTimeOfDayChanged(timeOfDay: time),);
                                  createDailyReminderNotification(time);
                                });
                              },
                              child: Text(
                                state.timeOfDay.format(context),
                                style: const TextStyle(
                                  color: AppColors.dreams,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
