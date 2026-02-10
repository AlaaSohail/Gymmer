import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmer/views/screens/LoginScreen.dart';
import 'package:gymmer/views/widgets/BottomNavBar.dart';

import 'controller/auth/auth_cubit.dart';
import 'controller/user/user_cubit.dart';
import 'controller/home/home_cubit.dart';
import 'controller/trainer/trainer_cubit.dart';
import 'controller/blog/blog_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit()..authStatus(),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            current is AuthSuccess || current is AuthInitial,
        builder: (context, state) {
          if (state is AuthSuccess) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => UserCubit()..loadCurrentUser()),
                BlocProvider(create: (_) => HomeCubit()..getHomeContect()),
                BlocProvider(create: (_) => TrainerCubit()..getTrainers()),
                BlocProvider(create: (_) => BlogCubit()),
              ],
              child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: BottomNavBar(),
              ),
            );
          }

          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
