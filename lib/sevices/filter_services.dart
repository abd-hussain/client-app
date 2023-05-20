import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class FilterService with Service {
  Future<CountriesModel> countries() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.countries,
      queryParam: {"limit": 50},
    );
    return CountriesModel.fromJson(response);
  }

  Future<CategoriesModel> categories() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.categories,
    );
    return CategoriesModel.fromJson(response);
  }
}
