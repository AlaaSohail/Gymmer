import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controller/auth/auth_cubit.dart';
import '../../controller/user/user_cubit.dart';
import '../../models/constsOfDart.dart';
import '../widgets/MainButton.dart';
import '../widgets/profile_cards.dart';
import 'EditProfileScreen.dart';
import 'LoginScreen.dart';
import 'PrivacyScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserCubit>().loadCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        actionsPadding: EdgeInsets.all(16),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<UserCubit>(),
                    child: const EditProfileScreen(),
                  ),
                ),
              );
            },
            child: Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: myOrange,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          bloc: userCubit,
          buildWhen: (previous, current) =>
              current is UserSuccess ||
              current is UserError ||
              current is UserLoading,

          builder: (context, state) {
            if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserLoading) {
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

              return SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<UserCubit>().loadCurrentUser();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              "assets/images/${user.image}",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  user.phone,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ProfileCards(
                        PrivacyScreen(
                          'About Gymmer',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi elementum, erat eu volutpat semper, magna nisl rutrum mi, eu convallis mauris mi vel tortor. Nulla vehicula orci a semper tincidunt. Nam consectetur interdum orci, ut venenatis diam lobortis ut. Aliquam mollis nunc enim, in fermentum tortor pulvinar vel. Cras at nisl risus. Mauris vehicula ultricies justo tempus lacinia. Donec laoreet magna ut sapien convallis fermentum. Curabitur lacinia augue a urna aliquet accumsan at a purus. Phasellus varius, arcu quis vestibulum dignissim, elit nisl ullamcorper lectus, at placerat risus enim id lectus.   Proin vel malesuada tellus. Maecenas molestie, ipsum non dapibus viverra, mauris est convallis arcu, et eleifend quam eros nec nisl. Quisque pulvinar enim metus, nec dapibus tellus tempor non. Nulla sed placerat est, vitae volutpat turpis.  ',
                          'What is Lorem Ipsum?',
                        ),
                        title: "About Gymmer",
                        icon: Bootstrap.info_circle_fill,
                      ),
                      ProfileCards(
                        PrivacyScreen(
                          'Privacy Policy',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi elementum, erat eu volutpat semper, magna nisl rutrum mi, eu convallis mauris mi vel tortor. Nulla vehicula orci a semper tincidunt. Nam consectetur interdum orci, ut venenatis diam lobortis ut. Aliquam mollis nunc enim, in fermentum tortor pulvinar vel. Cras at nisl risus. Mauris vehicula ultricies justo tempus lacinia. Donec laoreet magna ut sapien convallis fermentum. Curabitur lacinia augue a urna aliquet accumsan at a purus. Phasellus varius, arcu quis vestibulum dignissim, elit nisl ullamcorper lectus, at placerat risus enim id lectus.   Proin vel malesuada tellus. Maecenas molestie, ipsum non dapibus viverra, mauris est convallis arcu, et eleifend quam eros nec nisl. Quisque pulvinar enim metus, nec dapibus tellus tempor non. Nulla sed placerat est, vitae volutpat turpis.  ',
                          'What is Lorem Ipsum?',
                        ),
                        title: "Privacy",
                        icon: CupertinoIcons.lock_shield_fill,
                      ),
                      ProfileCards(
                        PrivacyScreen(
                          'Terms & Conditions',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi elementum, erat eu volutpat semper, magna nisl rutrum mi, eu convallis mauris mi vel tortor. Nulla vehicula orci a semper tincidunt. Nam consectetur interdum orci, ut venenatis diam lobortis ut. Aliquam mollis nunc enim, in fermentum tortor pulvinar vel. Cras at nisl risus. Mauris vehicula ultricies justo tempus lacinia. Donec laoreet magna ut sapien convallis fermentum. Curabitur lacinia augue a urna aliquet accumsan at a purus. Phasellus varius, arcu quis vestibulum dignissim, elit nisl ullamcorper lectus, at placerat risus enim id lectus.   Proin vel malesuada tellus. Maecenas molestie, ipsum non dapibus viverra, mauris est convallis arcu, et eleifend quam eros nec nisl. Quisque pulvinar enim metus, nec dapibus tellus tempor non. Nulla sed placerat est, vitae volutpat turpis.  ',
                          'What is Lorem Ipsum?',
                        ),
                        title: "Terms & Conditions",
                        icon: Icons.privacy_tip_rounded,
                      ),
                      ProfileCards(
                        PrivacyScreen(
                          'FeedBack',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi elementum, erat eu volutpat semper, magna nisl rutrum mi, eu convallis mauris mi vel tortor. Nulla vehicula orci a semper tincidunt. Nam consectetur interdum orci, ut venenatis diam lobortis ut. Aliquam mollis nunc enim, in fermentum tortor pulvinar vel. Cras at nisl risus. Mauris vehicula ultricies justo tempus lacinia. Donec laoreet magna ut sapien convallis fermentum. Curabitur lacinia augue a urna aliquet accumsan at a purus. Phasellus varius, arcu quis vestibulum dignissim, elit nisl ullamcorper lectus, at placerat risus enim id lectus.   Proin vel malesuada tellus. Maecenas molestie, ipsum non dapibus viverra, mauris est convallis arcu, et eleifend quam eros nec nisl. Quisque pulvinar enim metus, nec dapibus tellus tempor non. Nulla sed placerat est, vitae volutpat turpis.  ',
                          'What is Lorem Ipsum?',
                        ),
                        title: "FeedBack",
                        icon: Icons.feedback_rounded,
                      ),
                      ProfileCards(
                        PrivacyScreen(
                          'Rate Us',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi elementum, erat eu volutpat semper, magna nisl rutrum mi, eu convallis mauris mi vel tortor. Nulla vehicula orci a semper tincidunt. Nam consectetur interdum orci, ut venenatis diam lobortis ut. Aliquam mollis nunc enim, in fermentum tortor pulvinar vel. Cras at nisl risus. Mauris vehicula ultricies justo tempus lacinia. Donec laoreet magna ut sapien convallis fermentum. Curabitur lacinia augue a urna aliquet accumsan at a purus. Phasellus varius, arcu quis vestibulum dignissim, elit nisl ullamcorper lectus, at placerat risus enim id lectus.   Proin vel malesuada tellus. Maecenas molestie, ipsum non dapibus viverra, mauris est convallis arcu, et eleifend quam eros nec nisl. Quisque pulvinar enim metus, nec dapibus tellus tempor non. Nulla sed placerat est, vitae volutpat turpis.  ',
                          'What is Lorem Ipsum?',
                        ),
                        title: "Rate Us",
                        icon: Bootstrap.stars,
                      ),

                      const SizedBox(height: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        bloc: authCubit,
                        listenWhen: (previous, current) =>
                            current is AuthInitial || current is AuthError,
                        listener: (context, state) {
                          if (state is AuthError) {
                            print(state.message);
                          } else if (state is AuthInitial) {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          }
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
                            onPressed: () => authCubit.logout(),
                            text: 'Logout',
                          );
                        },
                      ),
                    ],
                  ),
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
