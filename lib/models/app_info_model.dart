class AppinfoModel {
  String deviceTypeName;
  String osVersion;
  String appVersion;
  int countryId;
  String osType;

  AppinfoModel(
      {required this.countryId,
      required this.appVersion,
      required this.osVersion,
      required this.deviceTypeName,
      required this.osType});
}
