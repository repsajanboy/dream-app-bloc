import 'package:dream_app_bloc/presentation/bottom_tab/bottom_tab.dart';
import 'package:dream_app_bloc/presentation/post/post.dart';
import 'package:dream_app_bloc/presentation/profile/profile.dart';
import 'package:dream_app_bloc/presentation/search/search.dart';
import 'package:dream_app_bloc/presentation/statistic/statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatefulWidget {
  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomtabBloc()..add(InitialBottomTab()),
      child: BlocBuilder<BottomtabBloc, BottomtabState>(
        builder: (context, state) {
          if (state is CreateBottomTab) {
            return _buildTab(context, state);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildTab(BuildContext context, CreateBottomTab state) {
    final items = state.items.map((type) => _getItem(type));
    return Scaffold(
      body: IndexedStack(
        index: state.currentIndex,
        children: items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: state.currentIndex,
          onTap: (int index) {
            BlocProvider.of<BottomtabBloc>(context)
                .add(BottomTabChanged(index));
          },
          items: items
              .map((e) => BottomNavigationBarItem(
                  icon: e.icon, label: e.title, activeIcon: e.activeIcon))
              .toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: const Color(0xff023563),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/createlisting");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  BottomTabItem _getItem(BottomTabItemType type) {
    switch (type) {
      case BottomTabItemType.home:
        return BottomTabItem(
            page: PostsPage(),
            icon: const Icon(Icons.home, color: Colors.grey),
            activeIcon: const Icon(Icons.home, color: Colors.blue),
            title: 'Posts');
      case BottomTabItemType.search:
        return BottomTabItem(
            page: SearchPage(),
            icon: const Icon(Icons.search, color: Colors.grey),
            activeIcon: const Icon(Icons.search, color: Colors.blueGrey),
            title: 'Search');
      case BottomTabItemType.statistic:
        return BottomTabItem(
            page: StatisticPage(),
            icon: const Icon(Icons.linear_scale, color: Colors.grey),
            activeIcon: const Icon(Icons.linear_scale, color: Colors.blue),
            title: 'Statistic');
      case BottomTabItemType.profile:
        return BottomTabItem(
            page: ProfilePage(),
            icon: const Icon(Icons.verified_user, color: Colors.grey),
            activeIcon: const Icon(Icons.verified_user, color: Colors.blue),
            title: 'Profile');
      default:
        return null;
    }
  }
}
