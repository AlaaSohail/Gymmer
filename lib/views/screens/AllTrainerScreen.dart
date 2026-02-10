import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmer/controller/trainer/trainer_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/constsOfDart.dart';
import '../widgets/trainer_card.dart';

class AllTrainerScreen extends StatefulWidget {
  const AllTrainerScreen({super.key});

  @override
  State<AllTrainerScreen> createState() => _AllTrainerScreenState();
}

class _AllTrainerScreenState extends State<AllTrainerScreen> {
  @override
  Widget build(BuildContext context) {
    final trainerCubit = BlocProvider.of<TrainerCubit>(context);
    return Scaffold(
      body: BlocBuilder<TrainerCubit, TrainerState>(
        bloc: trainerCubit,
        buildWhen: (previous, current) =>
            current is TrainerSuccess ||
            current is TrainerError ||
            current is TrainerLoading ||
            current is TrainerInitial,
        builder: (context, state) {
          if (state is TrainerLoading || state is TrainerInitial) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: myOrange,
                secondRingColor: Colors.yellowAccent,
                thirdRingColor: Colors.greenAccent,
                size: 60,
              ),
            );
          } else if (state is TrainerError) {
            debugPrint("TrainerError: ${state.message}");
          } else if (state is TrainerSuccess) {
            final trainers = state.trainers;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: trainers.length,
                    itemBuilder: (_, index) =>
                        TrainerCard(trainer: trainers[index]),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        title: Text(
          'Our Trainers',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TrainerCubit>(context).getTrainers();
  }
}
