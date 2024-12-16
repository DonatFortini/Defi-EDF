import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/core/error/failures.dart';
import 'package:frontend/features/home/domain/entities/fleet_entities.dart';
import 'package:frontend/features/home/domain/usescases/fleet_usecases.dart';

part 'fleet_stats_event.dart';
part 'fleet_stats_state.dart';

class FleetStatsBloc extends Bloc<FleetStatsEvent, FleetStatsState> {
  final GetFleetStatsUseCase getFleetStatsUseCase;

  FleetStatsBloc({required this.getFleetStatsUseCase})
      : super(FleetStatsInitial()) {
    on<FetchFleetStats>(_onFetchFleetStats);
  }

  void _onFetchFleetStats(
      FetchFleetStats event, Emitter<FleetStatsState> emit) async {
    emit(FleetStatsLoading());

    final result = await getFleetStatsUseCase(NoParams());

    result.fold(
        (failure) =>
            emit(FleetStatsError(message: _mapFailureToMessage(failure))),
        (stats) => emit(FleetStatsLoaded(fleetStats: stats)));
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error occurred';
    } else if (failure is NetworkFailure) {
      return 'Network error occurred';
    }
    return 'Unexpected error';
  }
}
