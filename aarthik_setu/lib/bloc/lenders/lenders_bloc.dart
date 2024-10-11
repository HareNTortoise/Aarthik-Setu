import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../repository/lenders.dart';
import '../../models/lenders.dart';

part 'lenders_event.dart';
part 'lenders_state.dart';

class LendersBloc extends Bloc<LendersEvent, LendersState> {
  final LendersRepository lendersRepository;

  LendersBloc({required this.lendersRepository}) : super(LendersInitial()) {
    on<FetchLenders>(_onFetchLenders);
  }

  Future<void> _onFetchLenders(FetchLenders event, Emitter<LendersState> emit) async {
    emit(LendersLoading());
    try {
      final lenders = await lendersRepository.getLenders(event.limit, event.offset);
      if (lenders.isNotEmpty) {
        emit(LendersLoaded(lenders: lenders));
      } else {
        emit(LendersEmpty());
      }
    } catch (error) {
      emit(LendersError(message: 'Failed to fetch lenders'));
    }
  }
}
