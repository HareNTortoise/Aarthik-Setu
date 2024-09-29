import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../global_components/large_tile_button.dart';

class BusinessLoanOptions extends StatelessWidget {
  const BusinessLoanOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LargeTileButton(
          title: 'MSME Loans',
          icon: const Icon(LineIcons.industry, size: 150),
          description: 'Get MSME loans up to ₹5 Crores with low interest rates and flexible repayment options.',
          onPressed: () => context.go('/business-loan-journey/msme'),
        ),
        LargeTileButton(
          title: 'Term Loans',
          icon: const Icon(LineIcons.handshake, size: 150),
          description: 'Get term loans up to ₹50 Lakhs with competitive rates and flexible repayment terms.',
          onPressed: () => context.go('/business-loan-journey/term'),
        ),
        LargeTileButton(
          title: 'Mudra Loans',
          icon: const Icon(LineIcons.piggyBank, size: 150),
          description: 'Get Mudra loans up to ₹10 Lakhs for micro-enterprises with flexible repayment.',
          onPressed: () => context.go('/business-loan-journey/mudra'),
        )
      ],
    );
  }
}
