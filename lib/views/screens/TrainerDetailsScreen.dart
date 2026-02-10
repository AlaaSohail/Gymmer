
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controller/trainerDetails/trainer_details_cubit.dart';
import '../../models/Trainer.dart';
import '../../models/constsOfDart.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key, required this.trainer});

  final Trainer trainer;

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final trainerDetailsCubit = BlocProvider.of<TrainerDetailsCubit>(context);
    trainerDetailsCubit.init(widget.trainer);
    return Scaffold(
      body: BlocBuilder<TrainerDetailsCubit, TrainerDetailsState>(
        bloc: trainerDetailsCubit,
        buildWhen: (previous, current) =>
            current is TrainerDetailsSuccess ||
            current is TrainerDetailsError ||
            current is TrainerDetailsLoading,

        builder: (context, state) {
          if (state is TrainerDetailsLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: myOrange,
                secondRingColor: Colors.yellowAccent,
                thirdRingColor: Colors.greenAccent,
                size: 60,
              ),
            );
          } else if (state is TrainerDetailsError) {
            debugPrint("TrainerDetailsError: ${state.message}");
          } else if (state is TrainerDetailsSuccess) {
            final tra = state.trainer;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            "assets/images/${tra.image}",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tra.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Specialization In ${tra.specialization}',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      appBar: AppBar(
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
    BlocProvider.of<TrainerDetailsCubit>(
      context,
    ).getTrainerDetails(widget.trainer.id);
  }
}
