import 'package:dartz/dartz.dart';
import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/core/error/failures.dart';
import 'package:frontend/core/network/network_info.dart';
import 'package:frontend/features/home/data/data_sources/fleet_datasource.dart';
import 'package:frontend/features/home/domain/entities/fleet_entities.dart';
import 'package:frontend/features/home/domain/repository/fleet_repository.dart';

class FleetStatsRepositoryImpl implements FleetStatsRepository {
  final FleetStatsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FleetStatsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FleetStatsEntity>> fetchFleetStats() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStats = await remoteDataSource.getFleetStats();
        return Right(remoteStats);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
