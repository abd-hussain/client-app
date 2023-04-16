import 'package:client_app/models/https/loyality_point_request.dart';
import 'package:client_app/models/rules_of_loyality.dart';
import 'package:client_app/sevices/loyality_service.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoyalityBloc extends Bloc<LoyalityService> {
  ValueNotifier<int?> pointNotifier = ValueNotifier<int?>(null);
  List<LoyalityRules> listOrRules = [];

  void fillLoyality(BuildContext context) {
    listOrRules = [
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.editProfile,
        content: AppLocalizations.of(context)!.loyalityfillprofiledetails,
        numberOfPoint: 3,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.inviteFriend,
        content: AppLocalizations.of(context)!.loyalityinviteFriend,
        numberOfPoint: 2,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.reportSuggestion,
        content: AppLocalizations.of(context)!.loyalityaddsuggestion,
        numberOfPoint: 1,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.reportIssue,
        content: AppLocalizations.of(context)!.loyalityaddissue,
        numberOfPoint: 1,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.appReview,
        content: AppLocalizations.of(context)!.loyalityaddgoodreviewfortheapp,
        numberOfPoint: 5,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.likeFacebook,
        content: AppLocalizations.of(context)!.loyalitylikefacebook,
        numberOfPoint: 1,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.likeLinkedIn,
        content: AppLocalizations.of(context)!.loyalitylikelinkedin,
        numberOfPoint: 1,
      ),
      LoyalityRules(
        pageToOpen: PageToOpenFromLoyality.reviewMentor,
        content: AppLocalizations.of(context)!.loyalityreviewmentor,
        numberOfPoint: 2,
      ),
    ];
  }

  Future<void> getProfilePoint() async {
    await service.getProfilePoints().then((value) {
      if (value.data != null) {
        pointNotifier.value = value.data!.points!;
      }
    });
  }

  Future<void> requestAddPoint({required String title, required int point}) async {
    final LoyalityPointRequest body = LoyalityPointRequest(title: title, point: point);
    await service.requestToAddPoint(body: body);
  }

  // Future<void> updatePoints({points = 0}) async {
  //   await service.updatePoints(points: points).then((value) {
  //     pointNotifier.value = value;
  //   });
  // }

  @override
  onDispose() {
    pointNotifier.dispose();
  }
}
