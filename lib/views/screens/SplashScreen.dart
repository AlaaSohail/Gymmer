import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/auth/auth_cubit.dart';
import '../../controller/auth_controller.dart';
import '../../controller/database_controller.dart';
import '../../services/auth.dart';
import '../widgets/BottomNavBar.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.active) {
          final user = asyncSnapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: LoginScreen(),
            );
          }
          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(auth: auth),
            child: Provider<Database>(
              create: (_) => FirestoreDatabase(user.uid),
              child: BottomNavBar(),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Color(0xFFF9F9F9),
            body: Center(
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/logo.svg'),
                  SizedBox(height: 100),

                  Image.asset('assets/images/loading.gif'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
