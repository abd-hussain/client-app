enum PageToOpenFromLoyality {
  editProfile,
  inviteFriend,
  reportSuggestion,
  reportIssue,
  appReview,
  likeLinkedIn,
  reviewMentor,
}

class LoyalityRules {
  final String content;
  final int numberOfPoint;
  final PageToOpenFromLoyality pageToOpen;

  const LoyalityRules({
    required this.content,
    required this.numberOfPoint,
    required this.pageToOpen,
  });
}
