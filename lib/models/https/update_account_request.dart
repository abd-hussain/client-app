import 'dart:io';

class UpdateAccountRequest {
  String firstName;
  String lastName;
  String? email;
  String? referalCode;
  int gender;
  int countryId;
  String? dateOfBirth;
  File? profileImage;

  UpdateAccountRequest({
    required this.firstName,
    required this.lastName,
    this.email,
    this.referalCode,
    required this.gender,
    required this.countryId,
    this.dateOfBirth,
    this.profileImage,
  });
}
