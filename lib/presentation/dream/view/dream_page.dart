import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/utils/upsert_screen_arguments.dart';
import 'package:flutter/material.dart';

class DreamPage extends StatelessWidget {
  const DreamPage({Key? key, required this.dream}) : super(key: key);
  final Dream dream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dream.id),
            Text(dream.title),
            Text(dream.content),
            Text(dream.inputDate.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.upsertDream,
                  arguments: UpsertScreenArgument(true, dream),
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
