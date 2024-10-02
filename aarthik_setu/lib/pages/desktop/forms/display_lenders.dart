import 'package:flutter/material.dart';
import '../../../constants/dummy_data_lender.dart';

class DisplayLenders extends StatefulWidget {
  final String loanType; // This parameter will be either 'personal' or 'business'

  const DisplayLenders({super.key, required this.loanType});

  @override
  _DisplayLendersState createState() => _DisplayLendersState();
}

class _DisplayLendersState extends State<DisplayLenders> {
  double? minInterestRate, maxInterestRate;
  int? minLoanAmount, maxLoanAmount, minTenure, maxTenure;

  @override
  Widget build(BuildContext context) {
    final DummyDataLenders dummyDataLenders = DummyDataLenders();

    List<Lender> lendersToDisplay = widget.loanType.toLowerCase() == 'personal'
        ? dummyDataLenders.personalLenders
        : dummyDataLenders.businessLenders;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loanType == 'personal' ? 'Personal Lenders' : 'Business Lenders'),
      ),
      body: Column(
        children: [
          _buildFilterOptions(),
          Expanded(
            child: ListView.builder(
              itemCount: lendersToDisplay.length,
              itemBuilder: (context, index) {
                final lender = lendersToDisplay[index];

                // Filter the loan schemes of the lender based on filter conditions
                List<LoanScheme> filteredSchemes = lender.loanSchemes.where((scheme) {
                  bool interestRateCondition = (minInterestRate == null ||
                      double.tryParse(scheme.interestRate.replaceAll('%', '')) != null &&
                          double.tryParse(scheme.interestRate.replaceAll('%', ''))! >= minInterestRate!) &&
                      (maxInterestRate == null ||
                          double.tryParse(scheme.interestRate.replaceAll('%', '')) != null &&
                              double.tryParse(scheme.interestRate.replaceAll('%', ''))! <= maxInterestRate!);

                  bool loanAmountCondition = (minLoanAmount == null ||
                      int.tryParse(scheme.loanAmount) != null &&
                          int.tryParse(scheme.loanAmount)! >= minLoanAmount!) &&
                      (maxLoanAmount == null ||
                          int.tryParse(scheme.loanAmount) != null &&
                              int.tryParse(scheme.loanAmount)! <= maxLoanAmount!);

                  bool tenureCondition = (minTenure == null ||
                      int.tryParse(scheme.tenure.replaceAll(RegExp(r'[^0-9]'), '')) != null &&
                          int.tryParse(scheme.tenure.replaceAll(RegExp(r'[^0-9]'), ''))! >= minTenure!) &&
                      (maxTenure == null ||
                          int.tryParse(scheme.tenure.replaceAll(RegExp(r'[^0-9]'), '')) != null &&
                              int.tryParse(scheme.tenure.replaceAll(RegExp(r'[^0-9]'), ''))! <= maxTenure!);

                  return interestRateCondition && loanAmountCondition && tenureCondition;
                }).toList();

                return filteredSchemes.isEmpty
                    ? Container() // If no schemes match, hide the lender
                    : Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(lender.name),
                    subtitle: Text('Type: ${lender.type}'),
                    children: filteredSchemes.map((scheme) {
                      return ListTile(
                        title: Text(scheme.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Interest Rate: ${scheme.interestRate}'),
                            Text('Loan Amount: ${scheme.loanAmount}'),
                            Text('Tenure: ${scheme.startingTenure} to ${scheme.tenure}'),
                            Text('Starting Loan Amount: ${scheme.startingLoanAmount}'),
                          ],
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on ${scheme.name} by ${lender.name}'),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Min Interest Rate (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      minInterestRate = value.isNotEmpty ? double.tryParse(value) : null;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Max Interest Rate (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      maxInterestRate = value.isNotEmpty ? double.tryParse(value) : null;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Min Loan Amount'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      minLoanAmount = value.isNotEmpty ? int.tryParse(value) : null;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Max Loan Amount'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      maxLoanAmount = value.isNotEmpty ? int.tryParse(value) : null;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Min Tenure (in years)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      minTenure = value.isNotEmpty ? int.tryParse(value) : null;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Max Tenure (in years)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      maxTenure = value.isNotEmpty ? int.tryParse(value) : null;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
