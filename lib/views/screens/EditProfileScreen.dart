import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmer/controller/user/user_cubit.dart'; // عدّل المسار حسب مشروعك
import 'package:gymmer/models/UserData.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controller/auth/auth_cubit.dart';
import '../../models/constsOfDart.dart';
import '../widgets/MainButton.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          bloc: userCubit,
          buildWhen: (previous, current) =>
              current is UserSuccess ||
              current is UserError ||
              current is UserLoading ||
              current is UserInitial,

          builder: (context, state) {
            if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserLoading || state is UserInitial) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: myOrange,
                  secondRingColor: Colors.yellowAccent,
                  thirdRingColor: Colors.greenAccent,
                  size: 60,
                ),
              );
            } else if (state is UserSuccess) {
              final user = state.user;
              if (_nameController.text.isEmpty) {
                _nameController.text = user.name;
                _phoneController.text = user.phone;
                _genderController.text = user.gender;
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                "assets/images/${user.image}",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Personal Information',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Please complete \nYour profile',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16),

                        Text(
                          'Full Name',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75,
                              width: double.infinity,
                              child: TextFormField(
                                controller: _nameController,
                                focusNode: _nameFocusNode,
                                onEditingComplete: () => FocusScope.of(
                                  context,
                                ).requestFocus(_phoneFocusNode),
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

                                  hintText: "name",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color: Colors.grey,
                                  ),

                                  labelStyle: TextStyle(
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
                            const SizedBox(height: 16),
                          ],
                        ),
                        Text(
                          'Mobile Number',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75,
                              width: double.infinity,
                              child: TextFormField(
                                controller: _phoneController,
                                focusNode: _phoneFocusNode,
                                onEditingComplete: () => FocusScope.of(
                                  context,
                                ).requestFocus(_genderFocusNode),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                textAlign: TextAlign.left,
                                clipBehavior: Clip.antiAlias,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value!.isEmpty ? "Enter your phone" : null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),

                                  fillColor: Colors.white,
                                  filled: true,

                                  hintText: "phone",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color: Colors.grey,
                                  ),

                                  labelStyle: TextStyle(
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
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      bloc: authCubit,
                      listenWhen: (previous, current) =>
                          current is AuthInitial || current is AuthError,
                      listener: (context, state) {
                        if (state is AuthError) {
                          print(state.message);
                        } else if (state is AuthInitial) {}
                      },
                      buildWhen: (previous, current) =>
                          current is AuthLoading ||
                          current is AuthError ||
                          current is AuthInitial,

                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return MainButton(
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
                            final updated = UserData(
                              uid: user.uid,
                              email: user.email,
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                              image: user.image,
                              gender: user.gender,
                            );

                            await context.read<UserCubit>().updateCurrentUser(
                              updated,
                            );
                            if (!mounted) return;
                            Navigator.pop(context);
                          },

                          text: 'SAVE',
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
