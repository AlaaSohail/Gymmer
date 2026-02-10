import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import '../../controller/auth/auth_cubit.dart';
import '../../models/constsOfDart.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/MainButton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  String Gordita = "Gordita";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome Partner !\nSign Up to start your\njourney with us",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            onEditingComplete: () => FocusScope.of(
                              context,
                            ).requestFocus(_emailFocusNode),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            clipBehavior: Clip.antiAlias,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value!.isEmpty ? "Enter your name" : null,
                            decoration: InputDecoration(
                              isDense: true,
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
                                    color: Color(0xffF67952).withOpacity(0.10),
                                  ),

                                  child: Icon(
                                    CupertinoIcons.person,
                                    size: 24,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              hintText: "name",
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
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            enabled: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _emailController,
                            obscureText: false,
                            textAlign: TextAlign.left,

                            focusNode: _emailFocusNode,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode),

                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your email";
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return "Enter correct email";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
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
                                    color: Color(0xffF67952).withOpacity(0.10),
                                  ),

                                  child: Icon(
                                    Clarity.email_line,
                                    size: 24,
                                    color: Colors.redAccent,
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
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            enabled: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            textAlign: TextAlign.left,
                            focusNode: _passwordFocusNode,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,

                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              // ignore: unnecessary_null_comparison
                              if (value!.isEmpty || value == null) {
                                return "Enter your password";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
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
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent,
                                ),
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

                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: MSHCheckbox(
                                size: 25,
                                value: isChecked,

                                colorConfig:
                                MSHColorConfig.fromCheckedUncheckedDisabled(
                                  uncheckedColor: Colors.grey,
                                  checkedColor: myOrange,
                                ),
                                style: MSHCheckboxStyle.stroke,
                                onChanged: (selected) {
                                  setState(() {
                                    isChecked = selected;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "I accept all the terms and conditions",
                                style: TextStyle(
                                  fontFamily: Gordita,
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  BlocConsumer<AuthCubit, AuthState>(
                    listenWhen: (previous, current) =>
                    current is AuthSuccess || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => BottomNavBar()),
                              (route) => false,
                        );
                      }

                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                    current is AuthLoading || current is AuthInitial,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return LoadingAnimationWidget.discreteCircle(
                          color: myOrange,
                          secondRingColor: Colors.yellowAccent,
                          thirdRingColor: Colors.greenAccent,
                          size: 40,
                        );
                      }

                      return MainButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() && isChecked) {
                            await authCubit.Signup(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _nameController.text.trim(),
                            );
                          }
                        },
                        text: "Sign Up",
                      );
                    },
                  ),

                  SizedBox(height: 30),

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

                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          Bootstrap.facebook,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      SizedBox(width: 40),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          Bootstrap.apple,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),

                      SizedBox(width: 40),

                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          Bootstrap.google,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontFamily: Gordita,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
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
