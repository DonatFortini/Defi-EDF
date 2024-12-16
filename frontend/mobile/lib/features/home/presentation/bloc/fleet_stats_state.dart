part of 'fleet_bloc.dart';

abstract class FleetStatsState extends Equatable {
  const FleetStatsState();

  @override
  List<Object> get props => [];
}

class FleetStatsInitial extends FleetStatsState {}

class FleetStatsLoading extends FleetStatsState {}

class FleetStatsLoaded extends FleetStatsState {
  final FleetStatsEntity fleetStats;

  const FleetStatsLoaded({required this.fleetStats});

  @override
  List<Object> get props => [fleetStats];
}

class FleetStatsError extends FleetStatsState {
  final String message;

  const FleetStatsError({required this.message});

  @override
  List<Object> get props => [message];
}
