import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// ignore: unused_import
import 'package:gymmer/views/screens/HomeScreen.dart';
import 'package:gymmer/views/screens/RegisterScreen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controller/auth/auth_cubit.dart';
import '../../models/constsOfDart.dart';
import '../widgets/MainButton.dart';
import 'ForgetPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String Gordita = "Gordita";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/logo.svg', height: 60),

                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Align(
                      alignment: Alignment.topLeft,

                      child: Text(
                        "Welcome Back ,\nLogin to your account",
                        style: TextStyle(
                          fontFamily: Gordita,
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            onEditingComplete: () => FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            textAlign: TextAlign.left,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your email";
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return "Enter valid email";
                              }

                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),

                              fillColor: Colors.white,
                              filled: true,

                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: myOrange.withOpacity(0.10),
                                  ),

                                  child: Icon(
                                    Clarity.email_line,
                                    size: 24,
                                    color: myOrange,
                                  ),
                                ),
                              ),
                              hintText: "email",
                              hintStyle: TextStyle(
                                fontFamily: Gordita,
                                fontSize: 16,
                                letterSpacing: 1,
                                color: Colors.grey,
                              ),

                              labelStyle: TextStyle(
                                fontFamily: Gordita,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            enabled: true,
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your password";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,

                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: myOrange.withOpacity(0.10),
                                  ),

                                  child: Icon(
                                    OctIcons.lock,

                                    size: 24,
                                    color: myOrange,
                                  ),
                                ),
                              ),
                              hintText: "password",
                              hintStyle: TextStyle(
                                fontFamily: Gordita,
                                fontSize: 16,
                                letterSpacing: 1,
                                color: Colors.grey,
                              ),

                              labelStyle: TextStyle(
                                fontFamily: Gordita,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: myOrange,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            enabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontFamily: Gordita,
                            fontSize: 12,
                            color: myOrange,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is AuthError || current is AuthSuccess,
                    listener: (context, state) {
                      (context, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthSuccess) {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        }
                      };
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthSuccess ||
                        current is AuthError ||
                        current is AuthInitial,

                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: myOrange,
                            secondRingColor: Colors.yellowAccent,
                            thirdRingColor: Colors.greenAccent,
                            size: 40,
                          ),
                        );
                      }
                      return MainButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await authCubit.Login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                        text: 'Login',
                      );
                    },
                  ),
                  SizedBox(height: 80),

                  Row(
                    children: [
                      Spacer(),
                      Container(height: 0.5, width: 120, color: Colors.grey),
                      Spacer(),

                      Text(
                        "Or",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: Gordita,
                          letterSpacing: 1,
                        ),
                      ),

                      Spacer(),

                      Container(height: 0.5, width: 120, color: Colors.grey),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Spacer(),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Bootstrap.facebook,
                          color: Colors.blue,
                          size: 40,
                        ),

                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 40),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Bootstrap.apple,
                          color: Colors.black,
                          size: 40,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 40),

                      IconButton(
                        onPressed: () {},

                        icon: Icon(
                          Bootstrap.google,
                          color: Colors.red,
                          size: 40,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: Gordita,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: Gordita,
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
