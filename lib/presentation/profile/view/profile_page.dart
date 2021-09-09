import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/profile/profile.dart';
import 'package:dream_app_bloc/presentation/profile/view/widgets/dream_quote.dart';
import 'package:dream_app_bloc/presentation/profile/view/widgets/rate_contact.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _dreamsCount(),
            const RandomDreamQoute(),
            const RateAndContactWidget(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFetchedSuccess) {
          return SizedBox(
            height: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(18.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Align(
                    child: Text(
                      '${state.user.firstName[0]}${state.user.lastName[0]}',
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.user.firstName,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dreams,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.setting);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          bottomLeft: Radius.circular(18.0),
                        ),
                      ),
                      shadowColor: Colors.black,
                    ),
                    child: const Icon(Icons.settings),
                  ),
                )
              ],
            ),
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
        return Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.dreams.length.toString(),
                        style: context.typo.dreamCountStyle()),
                    Text(
                      'dreams',
                      style: context.typo.dreamCountLableStyle(),
                    )
                  ],
                ),
              ),
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('2', style: context.typo.dreamCountStyle()),
                    Text('faves', style: context.typo.dreamCountLableStyle())
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
