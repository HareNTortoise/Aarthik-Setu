part of 'loan_details_bloc.dart';

@immutable
abstract class LoanDetailsEvent {}

class FetchLoanDetails extends LoanDetailsEvent {
  final Lender? lender;

  FetchLoanDetails({this.lender});
}
