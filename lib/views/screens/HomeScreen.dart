import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmer/controller/home/home_cubit.dart';
import 'package:gymmer/controller/trainer/trainer_cubit.dart';
import 'package:gymmer/views/screens/AllTrainerScreen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/home_card.dart';
import '../widgets/trainer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _searchController;
  final Color myOrange = const Color(0xFFEE3237);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final trainerCubit = BlocProvider.of<TrainerCubit>(context);

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is HomeSuccess ||
            current is HomeError ||
            current is HomeLoading,
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: myOrange,
                secondRingColor: Colors.yellowAccent,
                thirdRingColor: Colors.greenAccent,
                size: 60,
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeSuccess) {
            final exercisess = state.exercise;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/logo.svg', height: 80),

                    SizedBox(height: 24),

                    SizedBox(
                      height: 75,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _searchController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        textAlign: TextAlign.left,

                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),

                          fillColor: Color(0xffF6F6F6),
                          filled: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: myOrange.withOpacity(0.10),
                              ),

                              child: Icon(
                                Clarity.search_line,
                                size: 28,
                                color: myOrange,
                              ),
                            ),
                          ),

                          hintText: "Search Trainer",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            letterSpacing: 1,
                            color: Colors.grey,
                          ),

                          labelStyle: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            backgroundColor: Color(0xffF6F6F6),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: myOrange),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: myOrange),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: myOrange),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        enabled: true,
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/card1.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Text(
                        "Get Strong Today\n                  Run An Extra Mile.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          height: 2,
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Our Trainer",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<TrainerCubit>(),
                                  child: const AllTrainerScreen(),
                                ),
                              ),
                            );
                          },

                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    BlocBuilder<TrainerCubit, TrainerState>(
                      bloc: trainerCubit,
                      buildWhen: (previous, current) =>
                          current is TrainerSuccess ||
                          current is TrainerError ||
                          current is TrainerLoading ||
                          current is TrainerInitial,
                      builder: (BuildContext context, TrainerState state) {
                        if (state is TrainerLoading ||
                            state is TrainerInitial) {
                          return Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: myOrange,
                              secondRingColor: Colors.yellowAccent,
                              thirdRingColor: Colors.greenAccent,
                              size: 60,
                            ),
                          );
                        } else if (state is TrainerError) {
                          return Center(child: Text("No data"));
                        } else if (state is TrainerSuccess) {
                          final trainers = state.trainers;

                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: trainers.length,
                              itemBuilder: (_, index) =>
                                  TrainerCard(trainer: trainers[index]),
                            ),
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),

                    SizedBox(height: 12),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/me.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Text(
                        "Trail Our \n Service for 7 DAYS",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          height: 2,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Check Our Trainer Classes",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: exercisess.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeCard(
                            cardWidth: 240,
                            exercise: exercisess[index],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/card2.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Text(
                        "Get Our\nMemberships",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Exercises",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: exercisess.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeCard(
                            cardWidth: 110,
                            exercise: exercisess[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
