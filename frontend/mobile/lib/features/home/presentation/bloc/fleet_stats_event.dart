part of 'fleet_bloc.dart';

abstract class FleetStatsEvent extends Equatable {
  const FleetStatsEvent();

  @override
  List<Object> get props => [];
}

class FetchFleetStats extends FleetStatsEvent {}
