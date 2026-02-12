import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmer/models/Exercise.dart';

// ignore: unused_import
import 'package:gymmer/views/screens/HomeScreen.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key, required this.cardWidth, required this.exercise});

  final double cardWidth;
  final Exercise exercise;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: widget.cardWidth,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            print("Tapped");
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/${widget.exercise.image}",
                height: 180,
                width: widget.cardWidth,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${widget.exercise.days} Days',
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.exercise.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
