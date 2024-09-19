import 'package:aarthik_setu/pages/desktop/home/components/pending_applications.dart';
import 'package:aarthik_setu/pages/desktop/home/components/personal_loan_options.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_constants.dart';
import 'components/business_loan_options.dart';
import 'components/government_schemes.dart';

class DashboardDesktop extends StatefulWidget {
  const DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  int _dashboardIndex = 2;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Dashboard', style: GoogleFonts.poppins(fontSize: 85)),
                  const Spacer(),
                  SizedBox(
                    width: 220,
                    height: 55,
                    child: FilledButton.tonal(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                      child: Text('Log Out', style: GoogleFonts.poppins(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[400],
                      child: const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 850,
                    height: 100,
                    color: Colors.white,
                    child: AnimatedToggleSwitch<int>.size(
                      textDirection: TextDirection.rtl,
                      current: _dashboardIndex,
                      values: const [0, 1, 2],
                      indicatorSize: const Size.fromWidth(330),
                      iconBuilder: (i) {
                        switch (i) {
                          case 2:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText('Personal Loans',
                                  style: GoogleFonts.poppins(fontSize: 22),
                                  minFontSize: 16,
                                  maxFontSize: 24,
                                  maxLines: 1),
                            );
                          case 1:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText('Business Loans',
                                  style: GoogleFonts.poppins(fontSize: 22),
                                  minFontSize: 16,
                                  maxFontSize: 24,
                                  maxLines: 1),
                            );
                          case 0:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText('Government Schemes',
                                  style: GoogleFonts.poppins(fontSize: 22),
                                  minFontSize: 16,
                                  maxFontSize: 24,
                                  maxLines: 1),
                            );
                          default:
                            return const Icon(Icons.person);
                        }
                      },
                      borderWidth: 4.0,
                      iconAnimationType: AnimationType.onHover,
                      style: ToggleStyle(
                        borderColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                      ),
                      styleBuilder: (i) => ToggleStyle(indicatorColor: Colors.grey[300]),
                      selectedIconScale: 1,
                      onChanged: (i) async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        setState(() {
                          _dashboardIndex = i;
                        });
                      },
                      loadingIconBuilder: (i, _) => const LoadingIndicator(indicatorType: Indicator.orbit),
                    ),
                  ),
                  const SizedBox(width: 50),
                  if (_dashboardIndex != 0)
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: FilledButton.tonal(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.greenAccent[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35)))),
                        ),
                        child: AutoSizeText(
                          'Profile',
                          style: GoogleFonts.poppins(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  const SizedBox(width: 50),
                  if (_dashboardIndex != 0)
                    SizedBox(
                      height: 100,
                      width: 350,
                      child: FilledButton.tonal(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => PendingApplications());
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.blue[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35)))),
                        ),
                        child: AutoSizeText(
                          'Pending Applications : 3',
                          style: GoogleFonts.poppins(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 100),
              if (_dashboardIndex == 2) const PersonalLoanOptions(),
              if (_dashboardIndex == 1) const BusinessLoanOptions(),
              if (_dashboardIndex == 0) const GovernmentSchemesFinder(),
            ],
          ),
        ),
      ),
    );
  }
}