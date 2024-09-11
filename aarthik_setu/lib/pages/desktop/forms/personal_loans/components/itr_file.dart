import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../../constants/colors.dart';

class ItrFile extends StatelessWidget {
  const ItrFile({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Upload ITR (PDF format)",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "FY ${currentYear - 2}-${currentYear - 1}*",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, size: 30),
                          const SizedBox(width: 10),
                          Text("Upload File", style: GoogleFonts.poppins(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "FY ${currentYear - 3}-${currentYear - 2}",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, size: 30),
                          const SizedBox(width: 10),
                          Text("Upload File", style: GoogleFonts.poppins(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "FY ${currentYear - 4}-${currentYear - 3}",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, size: 30),
                          const SizedBox(width: 10),
                          Text("Upload File", style: GoogleFonts.poppins(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 65),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                "How to download ITR in PDF format",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 40),
              SizedBox(
                width: 200,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ResponsiveScaledBox(
                        width: AppConstants.desktopScaleWidth,
                        child: Dialog(
                          child: Container(
                            width: 800,
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "How to download ITR in PDF format",
                                  style: GoogleFonts.poppins(fontSize: 30),
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.grey, thickness: 0.5),
                                const SizedBox(height: 20),
                                Text(
                                  """ 1. Visit click on the 'Login' button on the top right corner, and login with your login details.\n\n2. Click on the 'e-File' from top Navigation Bar.\n\n3. Click on 'Income Tax Returns' from the e-File drop-down menu.\n\n4. Click on 'View Filed Returns' from the Income Tax Return drop-down menu.\n\n5. If you have filed ITR type - 1/2, click on 'Download Form', the ITR PDF file for that 'A.Y.' will get downloaded.\n\n6. Upload the downloaded files on the Platform. """,
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(LineIcons.infoCircle, size: 30),
                      SizedBox(width: 10),
                      Text("Instructions", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 200,
                height: 50,
                child: FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: HexColor("#568737")),
                    )),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20, color: HexColor("#568737")),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(HexColor("#568737")),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Proceed",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
