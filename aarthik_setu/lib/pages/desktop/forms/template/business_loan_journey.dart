import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/large_tile_button.dart';

class BusinessLoanJourney extends StatelessWidget {
  const BusinessLoanJourney({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.4,
                isFirst: true,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: 150,
                  child: FilledButton.tonal(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.primaryColorTwo.withOpacity(0.6),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose your Business Profile',
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Selected Profile: ABC Pvt Ltd',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Select your business profile from the list. You can also create a new profile if you don’t have one.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
            const TimelineDivider(
              color: Colors.blueAccent,
              thickness: 8,
              begin: 0.4,
              end: 0.6,
            ),
            // ITR Form Step
            SizedBox(
              height: 700,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Providing your business’s Income Tax Return (ITR) is essential as it demonstrates your company’s financial health and stability.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Income Tax Return',
                      icon: const Icon(LineIcons.piggyBank, size: 150),
                      onPressed: () => context.go('/business-loan-journey/business/itr'),
                      description: 'Provide your business’s income tax return for the last 3 years.',
                    ),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
            const TimelineDivider(
              color: Colors.blueAccent,
              thickness: 8,
              begin: 0.4,
              end: 0.6,
            ),
            // GST Form Step
            SizedBox(
              height: 700,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.4,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'GST Details',
                      icon: const Icon(LineAwesome.file_invoice_solid, size: 150),
                      onPressed: () => context.go('/business-loan-journey/business/gst-details'),
                      description: 'Provide your GST registration number and return details.',
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Providing your GST return shows your business’s compliance with tax regulations, which is a key factor in loan approval.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
            const TimelineDivider(
              color: Colors.blueAccent,
              thickness: 8,
              begin: 0.4,
              end: 0.6,
            ),
            // Bank Details Step
            SizedBox(
              height: 700,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Submitting your business’s bank details helps the lender assess your financial health and cash flow.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Bank Details',
                      icon: const Icon(LineIcons.university, size: 150),
                      onPressed: () => context.go('/business-loan-journey/business/bank-details'),
                      description: 'Provide your business’s bank details and bank statements.',
                    ),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
            const TimelineDivider(
              color: Colors.blueAccent,
              thickness: 8,
              begin: 0.4,
              end: 0.6,
            ),
            // Stakeholders Step
            SizedBox(
              height: 700,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.4,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Stakeholders',
                      icon: const Icon(LineIcons.users, size: 150),
                      onPressed: () => context.go('/business-loan-journey/business/stakeholders'),
                      description: 'Provide details about key stakeholders and their shares in the business.',
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Providing details about key stakeholders helps lenders understand the structure and ownership of the business.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
            const TimelineDivider(
              color: Colors.blueAccent,
              thickness: 8,
              begin: 0.4,
              end: 0.6,
            ),
            // Loan Form Step
            SizedBox(
              height: 700,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: true,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'The loan form is the final step in your business loan application. Make sure all details are accurate.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Loan Form',
                      icon: const Icon(LineIcons.fileContract, size: 150),
                      onPressed: () => context.go('/business-loan-journey/business/loan-form'),
                      description: 'Fill in the loan application form to finalize your request.',
                    ),
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: 50,
                  color: Colors.blueAccent,
                  iconStyle: IconStyle(
                    iconData: Icons.check,
                    color: Colors.white,
                  ),
                ),
                beforeLineStyle: const LineStyle(
                  color: Colors.blueAccent,
                  thickness: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
