import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/navigator_arguments/upsert_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DreamPage extends StatelessWidget {
  const DreamPage({Key? key, required this.dream}) : super(key: key);
  final Dream dream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteNames.upsertDream,
            arguments: UpsertScreenArgument(true, dream),
          );
        },
        backgroundColor: Colors.indigoAccent,
        child: const Icon(
          Icons.border_color,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              color: Colors.indigo.shade900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white60,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dream.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            )),
                        Text(
                          DateFormat('EEE, MMM d, ' 'yyyy')
                              .format(dream.inputDate),
                          style: TextStyle(
                            color: Colors.indigo.shade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          dream.category,
                          style: TextStyle(
                            color: Colors.indigo.shade300,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        Text(
                          dream.rate.toString(),
                          style: TextStyle(
                            color: Colors.indigo.shade300,
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 20.0,
                  top: 10.0,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                ),
                child: Text(
                  dream.content,
                  style: const TextStyle(
                      color: AppColors.dreams,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 1.5,
                      fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
