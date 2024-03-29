import 'package:dream_app_bloc/presentation/bottom_tab/bottom_tab.dart';
import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream_favorites/favorite_dreams.dart';
import 'package:dream_app_bloc/presentation/horoscope/horoscope.dart';
import 'package:dream_app_bloc/presentation/profile/profile.dart';
import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:dream_app_bloc/repositories/user_repository.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/navigator_arguments/upsert_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatefulWidget {
  final int currIndex;

  const BottomNavBarPage({Key? key, required this.currIndex}) : super(key: key);
  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BottomtabBloc()..add(InitialBottomTab(widget.currIndex)),
          ),
          BlocProvider(
            create: (context) => DreamBloc(
              dreamRepository: context.read<DreamRepository>(),
            )..add(const DreamsFetched()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
            )..add(const ProfileFetched()),
          ),
          BlocProvider(
            create: (context) => FavoriteDreamBloc(
              dreamRepository: context.read<DreamRepository>(),
            )..add(FavoriteDreamsFetched()),
          ),
        ],
        child: BlocBuilder<BottomtabBloc, BottomtabState>(
          builder: (context, state) {
            if (state is CreateBottomTab) {
              return _buildTab(context, state);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, CreateBottomTab state) {
    final items = state.items.map((type) => _getItem(type));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: state.currentIndex,
        children: items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: state.currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (int index) {
              BlocProvider.of<BottomtabBloc>(context)
                  .add(BottomTabChanged(index));
            },
            items: items
                .map((e) => BottomNavigationBarItem(
                    icon: e.icon, label: e.title, activeIcon: e.activeIcon,),)
                .toList(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.indigoAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteNames.upsertDream,
            arguments: UpsertScreenArgument(isEditing: false),
          );
        },
        child: const Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }

  BottomTabItem _getItem(BottomTabItemType type) {
    switch (type) {
      case BottomTabItemType.home:
        return BottomTabItem(
          page: DreamsPage(),
          icon: const Icon(
            Icons.view_day_outlined,
            color: Colors.black38,
            size: 32,
          ),
          activeIcon: const Icon(
            Icons.view_day_outlined,
            color: AppColors.dreams,
            size: 32.0,
          ),
          title: '',
        );
      case BottomTabItemType.horoscope:
        return BottomTabItem(
          page: HoroscopePage(),
          icon: const Icon(
            Icons.auto_awesome,
            color: Colors.black38,
            size: 32,
          ),
          activeIcon: const Icon(
            Icons.auto_awesome,
            color: AppColors.dreams,
            size: 32.0,
          ),
          title: '',
        );
      case BottomTabItemType.space:
        return BottomTabItem(
          page: const SizedBox(),
          icon: const SizedBox(),
          activeIcon: const SizedBox(),
          title: '',
        );
      case BottomTabItemType.favorites:
        return BottomTabItem(
          page: const FavoriteDreamsPage(),
          icon: const Icon(
            Icons.favorite_border_rounded,
            color: Colors.black38,
            size: 32,
          ),
          activeIcon: const Icon(
            Icons.favorite,
            color: AppColors.dreams,
            size: 32.0,
          ),
          title: '',
        );
      case BottomTabItemType.profile:
        return BottomTabItem(
          page: ProfilePage(),
          icon: const Icon(
            Icons.person_outlined,
            color: Colors.black38,
            size: 32,
          ),
          activeIcon: const Icon(
            Icons.person_outlined,
            color: AppColors.dreams,
            size: 32,
          ),
          title: '',
        );
      default:
        return BottomTabItem(
          page: const SizedBox(),
          icon: const SizedBox(),
          activeIcon: const SizedBox(),
          title: '',
        );
    }
  }
}
