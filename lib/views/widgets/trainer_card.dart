import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmer/models/Trainer.dart';

import '../../controller/trainerDetails/trainer_details_cubit.dart';
import '../screens/TrainerDetailsScreen.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({super.key, required this.trainer});

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => TrainerDetailsCubit(),
                  child: TrainerDetailsScreen(trainer: trainer),
                ),
              ),
            );
          },
          child: Container(
            height: 125,
            width: 80,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),

            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/${trainer.image}',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  trainer.name,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
