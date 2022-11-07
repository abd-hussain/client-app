import 'package:client_app/utils/mixins.dart';

class UpdateAccountRequest implements Model {
  String? firstName;
  String? lastName;
  String? email;
  String? referalCode;
  int? gender;
  int? countryId;
  String? dateOfBirth;
  String? profileImage;

  UpdateAccountRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.referalCode,
      this.gender,
      this.countryId,
      this.dateOfBirth,
      this.profileImage});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['referal_code'] = referalCode;
    data['gender'] = gender;
    data['country_id'] = countryId;
    data['date_of_birth'] = dateOfBirth;
    data['profile_img'] = profileImage;

    return data;
  }
}
