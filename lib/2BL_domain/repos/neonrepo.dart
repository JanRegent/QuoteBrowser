import 'package:flutter/foundation.dart';
import 'package:flutter_neon/flutter_neon.dart';

class NeonRepo {
  late FlutterNeon neonClient;

  Future init() async {
    neonClient = FlutterNeon(
        connectionUrl:
            "postgresql://jan.regent:TUSOC4bsFYP6@ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech/neondb?sslmode=require",
        pooling: true);

    await neonClient.open();
    final results = await neonClient
        .select(table: "playing_with_neon", columns: ["name", "value"]);
    debugPrint(results.first.toString());
  }
}
