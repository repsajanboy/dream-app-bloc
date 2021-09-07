import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/profile/profile.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
            )..add(const ProfileFetched()),
          )
        ],
        child: SafeArea(
            child: Column(
              children: [
                _header(),
                _dreamsCount(),
              ],
            ),
          ),
      ),
    );
  }

  Widget _header() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is ProfileFetchedSuccess){
          return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1.5, color: Colors.lightBlue.shade600),
                  right:
                      BorderSide(width: 1.5, color: Colors.lightBlue.shade900),
                ),
                color: Colors.white,
              ),
              child: Text(
                  '${state.user.firstName[0]}${state.user.lastName[0]}'),
            ),
            Text(state.user.firstName),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.setting);
              },
              child: const Text('Settings'),
            )
          ],
        );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _dreamsCount() {
    return BlocConsumer<DreamBloc, DreamState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Text(state.dreams.length.toString());
      },
    );
  }


}
