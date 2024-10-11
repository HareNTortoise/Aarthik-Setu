import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/loan_deatils/loan_details_bloc.dart';
import '../models/lenders.dart';

class LenderTile extends StatelessWidget {
  const LenderTile({super.key, required this.lender});

  final Lender lender;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: FilledButton.tonal(
        onPressed: () {
          context.read<LoanDetailsBloc>().add(FetchLoanDetails(lender: lender));
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(lender.imageUrl),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 720,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lender.lenderName, style: GoogleFonts.jost(fontSize: 42)),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz_outlined),
                            ),
                          ],
                        ),
                        Text('Interest Rate: ${lender.interestRate}', style: GoogleFonts.jost(fontSize: 24)),
                        Text('Loan Term: ${lender.loanTerm}', style: GoogleFonts.jost(fontSize: 24)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20)
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lender.collateralRequired ? 'Collateral Needed' : 'Collateral free',
                          style: GoogleFonts.jost(fontSize: 18)),
                      SizedBox(height: 10),
                      Text('Loan Type: ${lender.loanType}', style: GoogleFonts.jost(fontSize: 18)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Applicants: ${lender.applicantCount}', style: GoogleFonts.jost(fontSize: 18)),
                      SizedBox(height: 10),
                      Text('Fair Match Score: ${lender.fairMatchScore}/100', style: GoogleFonts.jost(fontSize: 18)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lender Type: ${lender.lenderType}', style: GoogleFonts.jost(fontSize: 18)),
                      SizedBox(height: 10),
                      Text('Loan Type: ${lender.loanType}', style: GoogleFonts.jost(fontSize: 18)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
