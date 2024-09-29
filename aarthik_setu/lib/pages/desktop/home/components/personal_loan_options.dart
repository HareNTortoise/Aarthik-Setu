import 'package:aarthik_setu/global_components/large_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

class PersonalLoanOptions extends StatelessWidget {
  const PersonalLoanOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LargeTileButton(
          title: 'Personal Loans',
          icon: const Icon(LineIcons.moneyBill, size: 150),
          description: 'Get a personal loan with low interest rates and flexible repayment options.',
          onPressed: () => context.go('/personal-loan-journey/personal'),
        ),
        LargeTileButton(
          title: 'Home Loans',
          icon: const  Icon(LineIcons.home, size: 150),
          description: 'Get a home loan with low interest rates and flexible repayment options.',
          onPressed: () => context.go('/personal-loan-journey/home'),
        ),
        LargeTileButton(
          title: 'Auto Loans',
          icon: const Icon(LineIcons.car, size: 150),
          description: 'Get an auto loan with low interest rates and flexible repayment options.',
          onPressed: () => context.go('/personal-loan-journey/auto'),
        )
      ],
    );
  }
}
