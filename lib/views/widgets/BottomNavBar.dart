import 'package:flutter/material.dart';
import 'package:gymmer/models/constsOfDart.dart';
import 'package:gymmer/views/screens/BlogsScreen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../screens/HomeScreen.dart';
import '../screens/ProfileScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _bottomNavBarController = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        screenTransitionAnimation: ScreenTransitionAnimation(
          curve: Curves.easeInOutCubic,

          duration: Duration(milliseconds: 300),
        ),
        controller: _bottomNavBarController,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,

        tabs: [
          PersistentTabConfig(
            screen: HomeScreen(),
            item: ItemConfig(
              icon: Icon(HeroIcons.home),
              title: "Home",
              activeForegroundColor: myOrange,
            ),
          ),

          PersistentTabConfig(
            screen: BlogsScreen(),
            item: ItemConfig(
              icon: Icon(FontAwesome.blog_solid),
              title: "Blogs",
              activeForegroundColor: myOrange,
            ),
          ),
          PersistentTabConfig(
            screen: HomeScreen(),
            item: ItemConfig(
              icon: Icon(Icons.favorite_outline_rounded),
              title: "Favorites",
              activeForegroundColor: myOrange,
            ),
          ),
          PersistentTabConfig(
            screen: ProfileScreen(),
            item: ItemConfig(
              icon: Icon(Iconsax.user_outline),
              title: "Profile",
              activeForegroundColor: myOrange,
            ),
          ),
        ],

        navBarBuilder: (navBarConfig) => Style12BottomNavBar(
          itemAnimationProperties: ItemAnimation(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
