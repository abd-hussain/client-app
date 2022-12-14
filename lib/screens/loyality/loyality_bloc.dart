import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/loyality_rules.dart';
import 'package:client_app/sevices/loyality_service.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class LoyalityBloc extends Bloc<LoyalityService> {
  ValueNotifier<AccountInfo?> pointNotifier = ValueNotifier<AccountInfo?>(null);
  ValueNotifier<List<LoyalityRulesData>?> loyalityRulles = ValueNotifier<List<LoyalityRulesData>?>(null);

  Future<void> updatePoints({points = 0}) async {
    await service.updatePoints(points: points).then((value) {
      pointNotifier.value = value;
    });
  }

  Future<void> getRulles() async {
    await service.rules().then((value) {
      loyalityRulles.value = value.data;
    });
  }

  @override
  onDispose() {
    pointNotifier.dispose();
    loyalityRulles.dispose();

    throw UnimplementedError();
  }
}
