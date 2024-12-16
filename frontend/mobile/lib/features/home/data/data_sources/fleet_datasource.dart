import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/features/home/data/models/fleet_model.dart';
import 'package:frontend/config/config.dart';

abstract class FleetStatsRemoteDataSource {
  Future<FleetStatsModel> getFleetStats();
}

class FleetStatsRemoteDataSourceImpl implements FleetStatsRemoteDataSource {
  final http.Client client;

  FleetStatsRemoteDataSourceImpl({required this.client});

  @override
  Future<FleetStatsModel> getFleetStats() async {
    final response = await client.get(
      Uri.parse(EnvironmentConfig.dashboardUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return FleetStatsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
