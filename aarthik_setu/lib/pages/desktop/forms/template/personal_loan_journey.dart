import 'package:aarthik_setu/global_components/large_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../constants/colors.dart';

class PersonalLoanJourney extends StatelessWidget {
  const PersonalLoanJourney({super.key});

  @override
  Widget build(BuildContext context) {
    final params = GoRouterState.of(context).pathParameters;
    final loanType = params['loanType'];
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
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.6)),
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
                          'Choose your Personal Profile',
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Selected Profile : Aadarsh Verma',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Select your personal profile from the list of available profiles. If you do not have a profile, you can create a new one.',
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
                    'Providing your ITR when applying for a loan is crucial because it assures lenders of your financial stability, repayment capacity, and overall trustworthiness, which ultimately improves your chances of getting the loan approved. You also have to option to manually declare your income if you do not have an ITR.',
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
                      icon: const Icon(LineAwesome.money_bill_alt, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/itr'),
                      description:
                          'Provide you income tax return form for up to the last 3 years or declare your income.',
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
            SizedBox(
              height: 800,
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
                        title: 'Bank Details',
                        icon: const Icon(LineAwesome.university_solid, size: 150),
                        onPressed: () => context.go('/personal-loan-journey/$loanType/bank-details'),
                        description: 'Declare your bank details and provide bank statements for the last 6 months.'),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Bank details and statements offer lenders a transparent and reliable way to assess your financial habits, repayment capacity, and overall credit risk, which are key factors in approving a loan.',
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
            SizedBox(
              height: 800,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Personal details are essential in a loan application as they help verify your identity, assess your eligibility, and determine your creditworthiness. Information like age, address, and employment status provide insight into your stability and repayment capability. Accurate personal details also ensure compliance with legal and regulatory requirements.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Basic Details',
                      icon: const Icon(LineAwesome.user, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/basic-details'),
                      description: 'Provide your personal information like name, age, and address.',
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
            SizedBox(
              height: 800,
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
                      title: 'Employment Details',
                      icon: const Icon(LineAwesome.briefcase_solid, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/employment-details'),
                      description: 'Provide your employment details like company name, designation, and salary.',
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Employment details are crucial in a loan application as they help lenders assess your repayment capacity, job stability, and overall financial health. Information like company name, designation, and salary provide insight into your income stability and repayment capability.',
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
            SizedBox(
              height: 800,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Credit information is essential in a loan application as it helps lenders assess your creditworthiness, repayment capacity, and overall financial health. Information like credit score, credit history, and existing loans provide insight into your credit risk and repayment capability. Accurate credit information also ensures compliance with legal and regulatory requirements.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Credit Information',
                      icon: const Icon(LineAwesome.credit_card, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/credit-info'),
                      description:
                          'Provide your credit information like credit score, credit history, and existing loans.',
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
            SizedBox(
              height: 800,
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
                      title: 'Contact Information',
                      icon: const Icon(LineIcons.phone, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/contact-details'),
                      description: 'Provide your contact information like phone number, email, and address.',
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Contact information is essential in a loan application as it helps lenders verify your identity, communicate with you, and assess your repayment capability. Information like phone number, email, and address provide insight into your accessibility and communication.',
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
            SizedBox(
              height: 800,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: false,
                isLast: false,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'The loan form is the final step in the loan application process. It is where you provide all the required information, documents, and details to the lender for approval. Make sure to fill out the form accurately and completely to improve your chances of getting the loan approved.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 26),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LargeTileButton(
                      title: 'Loan Form',
                      icon: const Icon(LineAwesome.money_bill_alt, size: 150),
                      onPressed: () => context.go('/personal-loan-journey/$loanType/loan-form'),
                      description: 'Fill out the loan form with all the required information.',
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
            SizedBox(
              height: 800,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.4,
                isFirst: false,
                isLast: true,
                startChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: 150,
                  child: FilledButton.tonal(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.6)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Review you Form',
                      style: GoogleFonts.poppins(fontSize: 26),
                    ),
                  ),
                ),
                endChild: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Reviewing and submitting your loan application is the final step in the loan application process. Make sure to review all the information you have provided, ensure its accuracy, and submit your application to the lender for approval.',
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
          ],
        ),
      ),
    );
  }
}
