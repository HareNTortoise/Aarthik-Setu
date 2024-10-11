import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/repository/govt_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../bloc/lenders/lenders_bloc.dart';
import '../../../bloc/loan_deatils/loan_details_bloc.dart';
import '../../../bloc/scheme_suggestions/scheme_suggestions_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/months.dart';
import '../../../global_components/lender_tile.dart';
import '../home/components/scheme_info_popup.dart';

class SelectLenders extends StatefulWidget {
  final String loanType;

  const SelectLenders({super.key, required this.loanType});

  @override
  SelectLendersState createState() => SelectLendersState();
}

class SelectLendersState extends State<SelectLenders> {
  double? minInterestRate, maxInterestRate;
  int? minLoanAmount, maxLoanAmount, minTenure, maxTenure;

  @override
  void initState() {
    super.initState();
    final lendersBloc = BlocProvider.of<LendersBloc>(context);
    lendersBloc.add(FetchLenders(limit: 20, offset: 0));

    final loanDetailsBloc = BlocProvider.of<LoanDetailsBloc>(context);
    loanDetailsBloc.add(FetchLoanDetails());

    final schemeSuggestionsBloc = BlocProvider.of<SchemeSuggestionsBloc>(context);
    schemeSuggestionsBloc.add(FetchSchemeSuggestions());
  }

  bool _toggleGovtSchemes = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.go('/submitted-form');
          },
          label: Row(
            children: const [
              Text('Submit Form', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              Icon(Icons.check),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Select Lenders',
                    style: GoogleFonts.poppins(fontSize: 85),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              SearchBar(
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 25)),
                                leading: const Icon(Icons.search),
                              ),
                              const SizedBox(width: 40),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: FilledButton(
                                  onPressed: () {
                                    // Handle filter button press
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.purpleAccent[50]),
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Filters',
                                        style: GoogleFonts.poppins(fontSize: 24),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(Icons.filter_list),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 60),
                          BlocBuilder<LendersBloc, LendersState>(
                            builder: (context, state) {
                              if (state is LendersLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is LendersError) {
                                return Center(child: Text('Error: ${state.message}'));
                              } else if (state is LendersEmpty) {
                                return const Center(child: Text('No lenders available.'));
                              } else if (state is LendersLoaded) {
                                return Container(
                                  height: MediaQuery.of(context).size.height - 100,
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView.builder(
                                    itemCount: state.lenders.length,
                                    itemBuilder: (context, index) {
                                      final lender = state.lenders[index];
                                      return LenderTile(lender: lender);
                                    },
                                  ),
                                );
                              }
                              return Container(); // Default empty state
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 800,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    height: 50,
                                    child: FilledButton.tonal(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.all(
                                          !_toggleGovtSchemes ? AppColors.primaryColorOne.withOpacity(0.7) : AppColors.primaryColorTwo.withOpacity(0.7),
                                        ),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _toggleGovtSchemes = false;
                                        });
                                      },
                                      child: const Text('Monthly Estimate', style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    height: 50,
                                    child: FilledButton.tonal(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all(
                                            !_toggleGovtSchemes ? AppColors.primaryColorTwo.withOpacity(0.7) : AppColors.primaryColorOne.withOpacity(0.7),
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _toggleGovtSchemes = true;
                                          });
                                        },
                                        child: const Text('Suggestions', style: TextStyle(fontSize: 20))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (!_toggleGovtSchemes)
                                BlocBuilder<LoanDetailsBloc, LoanDetailsState>(
                                  builder: (context, state) {
                                    if (state is LoanDetailsLoaded) {
                                      return SingleChildScrollView(
                                        child: SizedBox(
                                          height: 700,
                                          child: ListView(
                                            children: [
                                              for (int i = 0; i < state.loanDetails.minAmortizationSchedule.length; i++)
                                                Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                                                  padding: const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        MonthMap.months[i + 1].toString(),
                                                        style: GoogleFonts.poppins(fontSize: 40),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Principal Payment : ₹${state.loanDetails.minAmortizationSchedule[i].principalPayment.truncate().toString()}',
                                                              style: GoogleFonts.poppins(fontSize: 20),
                                                            ),
                                                            Text(
                                                                'Interest Payment : ₹${state.loanDetails.minAmortizationSchedule[i].interestPayment.truncate().toString()}',
                                                                style: GoogleFonts.poppins(fontSize: 20)),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Total Payment : ₹${state.loanDetails.minAmortizationSchedule[i].totalPayment.truncate().toString()}',
                                                                style: GoogleFonts.poppins(fontSize: 20)),
                                                            Text(
                                                                'Remaining Balance : ₹${state.loanDetails.minAmortizationSchedule[i].remainingBalance.truncate().toString()}',
                                                                style: GoogleFonts.poppins(fontSize: 20)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              if (_toggleGovtSchemes)
                                BlocBuilder<SchemeSuggestionsBloc, SchemeSuggestionsState>(
                                  builder: (context, state) {
                                    if (state is SchemeSuggestionsLoading) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (state is SchemeSuggestionsLoaded) {
                                      return SizedBox(
                                        height: 700,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.schemeSuggestions.schemes.length,
                                          itemBuilder: (context, index) {
                                            final GovernmentScheme scheme = state.schemeSuggestions.schemes[index];
                                            return Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                                              child: FilledButton.tonal(
                                                style: ButtonStyle(
                                                  backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.4)),
                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                ),
                                                onPressed: () {
                                                  showDialog(context: context, builder: (context) => SchemeInfoPopup(governmentScheme: scheme));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        scheme.relatedScheme,
                                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text("Description: ${scheme.description}"),
                                                      const SizedBox(height: 8),
                                                      Text("Nature of Assistance: ${scheme.natureOfAssistance}"),
                                                      const SizedBox(height: 8),
                                                      Text("Who Can Apply: ${scheme.whoCanApply}"),
                                                      const SizedBox(height: 8),
                                                      Text("How to Apply: ${scheme.howToApply}"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else if (state is SchemeSuggestionsError) {
                                      // Show an error message if something goes wrong
                                      return Center(child: Text('Error: ${state.error}'));
                                    } else {
                                      // Show an empty container for the initial or unknown state
                                      return const Center(child: Text('No suggestions available.'));
                                    }
                                  },
                                )

                            ],
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
