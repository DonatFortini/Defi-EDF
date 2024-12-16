import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/failures.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/home/domain/entities/fleet_entities.dart';
import 'package:frontend/features/home/domain/repository/fleet_repository.dart';

class GetFleetStatsUseCase implements UseCase<FleetStatsEntity, NoParams> {
  final FleetStatsRepository repository;

  GetFleetStatsUseCase(this.repository);

  @override
  Future<Either<Failure, FleetStatsEntity>> call(NoParams params) async {
    return await repository.fetchFleetStats();
  }
}

class NoParams {}
