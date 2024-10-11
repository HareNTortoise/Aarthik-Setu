part of 'loan_details_bloc.dart';

@immutable
abstract class LoanDetailsState {}

class LoanDetailsInitial extends LoanDetailsState {}

class LoanDetailsLoading extends LoanDetailsState {}

class LoanDetailsLoaded extends LoanDetailsState {
  final LoanDetails loanDetails;

  LoanDetailsLoaded({required this.loanDetails});
}

class LoanDetailsError extends LoanDetailsState {
  final String message;

  LoanDetailsError({required this.message});
}
