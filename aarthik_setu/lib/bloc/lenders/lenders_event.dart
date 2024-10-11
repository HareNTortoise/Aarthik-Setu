part of 'lenders_bloc.dart';

@immutable
abstract class LendersEvent {}

class FetchLenders extends LendersEvent {
  final int limit;
  final int offset;

  FetchLenders({required this.limit, required this.offset});
}
