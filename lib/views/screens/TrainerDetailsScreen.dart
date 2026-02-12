import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/trainerDetails/trainer_details_cubit.dart';
import '../../models/Trainer.dart';
import '../../models/constsOfDart.dart';
import '../widgets/CertificationCard.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key, required this.trainer});

  final Trainer trainer;

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: myOrange,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: myOrange,
                            dividerColor: Colors.transparent,

                            overlayColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),

                            indicatorPadding: EdgeInsets.only(
                              top: 44,
                              right: 36,
                              left: 36,
                            ),
                            indicatorWeight: 1,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: myOrange,
                              shape: BoxShape.rectangle,
                              border: Border.all(color: myOrange, width: 1),
                            ),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            labelPadding: EdgeInsets.zero,
                            padding: EdgeInsets.zero,

                            tabs: <Tab>[
                              Tab(text: 'Info'),
                              Tab(text: 'Videos'),
                            ],
                            controller: tabController,
                          ),
                          const SizedBox(height: 12),

                          SizedBox(
                            height: 1000,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                InfoScreen(), // تبويب Info
                                VideosScreen(), // تبويب Videos
                              ],
                            ),
                          ),
                        ],
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
    tabController = TabController(length: 2, vsync: this);

    BlocProvider.of<TrainerDetailsCubit>(
      context,
    ).getTrainerDetails(widget.trainer.id);
  }
}

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool hasUrl(String? url) => url != null && url.trim().isNotEmpty;

  Future<void> launchURL(String url) async {
    final fixedUrl = url.startsWith('http') ? url : 'https://$url';
    final uri = Uri.parse(fixedUrl);

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      debugPrint('Could not launch: $fixedUrl');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trainerDetailsCubit = BlocProvider.of<TrainerDetailsCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            BlocBuilder<TrainerDetailsCubit, TrainerDetailsState>(
              bloc: trainerDetailsCubit,
              buildWhen: (previous, current) =>
                  current is TrainerLinksSuccess ||
                  current is TrainerLinksError ||
                  current is TrainerLinksLoading,
              builder: (context, state) {
                if (state is TrainerLinksLoading) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: myOrange,
                      secondRingColor: Colors.yellowAccent,
                      thirdRingColor: Colors.greenAccent,
                      size: 60,
                    ),
                  );
                }

                if (state is TrainerLinksError) {
                  debugPrint("TrainerLinksError: ${state.message}");
                  return const SizedBox.shrink(); // أو Text error
                }

                if (state is TrainerLinksSuccess) {
                  final links = state.links;
                  if (links.isEmpty) return const SizedBox.shrink();

                  final link = links.first;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Brand(Brands.facebook, size: 44),
                          onTap: () {
                            if (hasUrl(link.facebook)) {
                              launchURL(link.facebook!);
                            }
                          },
                        ),
                        InkWell(
                          child: Brand(Brands.twitter, size: 44),
                          onTap: () {
                            if (hasUrl(link.twitter)) {
                              launchURL(link.twitter!);
                            }
                          },
                        ),
                        InkWell(
                          child: Brand(Brands.instagram, size: 44),
                          onTap: () {
                            if (hasUrl(link.instagram)) {
                              launchURL(link.instagram!);
                            }
                          },
                        ),
                        InkWell(
                          child: Brand(Brands.youtube, size: 44),
                          onTap: () {
                            if (hasUrl(link.youtube)) {
                              launchURL(link.youtube!);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 12),
            const Divider(height: 0.5, color: Color(0xffE5E5E5), thickness: 1),
            const SizedBox(height: 12),

            CertificationCard(
              title: "Certifications",
              subtitle: "Advance Trainer Certification ISSA",
            ),
            CertificationCard(
              title: "Certifications",
              subtitle: "Advance Trainer Certification ISSA",
            ),
            CertificationCard(
              title: "Certifications",
              subtitle: "Advance Trainer Certification ISSA",
            ),
            CertificationCard(
              title: "Certifications",
              subtitle: "Advance Trainer Certification ISSA",
            ),
            CertificationCard(
              title: "Certifications",
              subtitle: "Advance Trainer Certification ISSA",
            ),
          ],
        ),
      ),
    );
  }
}

class VideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
