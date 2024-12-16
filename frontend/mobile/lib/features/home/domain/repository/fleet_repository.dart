import 'package:dartz/dartz.dart';
import 'package:frontend/features/home/domain/entities/fleet_entities.dart';
import 'package:frontend/core/error/failures.dart';

abstract class FleetStatsRepository {
  Future<Either<Failure, FleetStatsEntity>> fetchFleetStats();
}
