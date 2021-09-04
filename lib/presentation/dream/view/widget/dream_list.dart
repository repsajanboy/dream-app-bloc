import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dream.dart';

class DreamList extends StatelessWidget {
  const DreamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamBloc, DreamState>(
      builder: (context, state) {
        switch (state.status) {
          case DreamStatus.error:
            return const Center(child: Text('failed to fetch dreams'));
          case DreamStatus.success:
            if (state.dreams.isEmpty) {
              return const Center(child: Text('no dreams'));
            }
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.dream,
                        arguments: state.dreams[index],
                      );
                    },
                    child: ListTile(
                      leading: Text(state.dreams[index].id),
                      title: Text(state.dreams[index].title),
                      isThreeLine: true,
                      subtitle: Text(state.dreams[index].content),
                      dense: true,
                    ),
                  );
                },
                itemCount: state.dreams.length);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
