part of 'lenders_bloc.dart';

@immutable
abstract class LendersState {}

class LendersInitial extends LendersState {}

class LendersLoading extends LendersState {}

class LendersLoaded extends LendersState {
  final List<Lender> lenders;

  LendersLoaded({required this.lenders});
}

class LendersEmpty extends LendersState {}

class LendersError extends LendersState {
  final String message;

  LendersError({required this.message});
}
