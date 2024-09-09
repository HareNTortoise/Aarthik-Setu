import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../constants/app_constants.dart';

class DashboardDesktop extends StatefulWidget {
  const DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {

  int _dashboardIndex = 0;

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
                    width: 200,
                    height: 50,
                    child: FilledButton.tonal(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.lightBlueAccent),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
                      child:  Text('Log Out', style: GoogleFonts.poppins(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {  },
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[400],
                      child: const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 800,
                  height: 100,
                  child: AnimatedToggleSwitch<int>.size(
                    textDirection: TextDirection.rtl,
                    current: _dashboardIndex,
                    values: const [0, 1, 2],
                    indicatorSize: const Size.fromWidth(300),
                    iconBuilder:  (i) {
                      switch (i) {
                        case 2:
                          return  Text('Personal Loans', style: GoogleFonts.poppins(fontSize: 20));
                        case 1:
                          return Text('Business Loans', style: GoogleFonts.poppins(fontSize: 20));
                        case 0:
                          return Text('Government Schemes', style: GoogleFonts.poppins(fontSize: 20));
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
                    loading: false,
                    styleBuilder: (i) => ToggleStyle(indicatorColor: Colors.grey[300]),
                    selectedIconScale: 1,
                    onChanged: (i) => setState(() {
                      _dashboardIndex = i;
                    }),
                    loadingIconBuilder: (i,_) => const LoadingIndicator(indicatorType: Indicator.orbit),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
