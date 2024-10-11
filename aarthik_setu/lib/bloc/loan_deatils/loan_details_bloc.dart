import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/lenders.dart';
import '../../models/loan_details.dart';
import '../../repository/loan_details.dart';

part 'loan_details_event.dart';

part 'loan_details_state.dart';

class LoanDetailsBloc extends Bloc<LoanDetailsEvent, LoanDetailsState> {
  final LoanDetailsRepository loanDetailsRepository;

  LoanDetailsBloc({required this.loanDetailsRepository}) : super(LoanDetailsInitial()) {
    on<FetchLoanDetails>(_onFetchLoanDetails);
  }

  void _onFetchLoanDetails(FetchLoanDetails event, Emitter<LoanDetailsState> emit) async {
    emit(LoanDetailsLoading());
    try {
      final loanDetails = await loanDetailsRepository.getLoanDetails(event.lender); // Fetching loan details from the repository
      emit(LoanDetailsLoaded(loanDetails: loanDetails));
    } catch (e) {
      emit(LoanDetailsError(message: 'Failed to load loan details: ${e.toString()}'));
    }
  }
}