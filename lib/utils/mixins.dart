import 'package:client_app/locator.dart';
import 'package:client_app/utils/repository/http_repository.dart';

abstract class Bloc<T extends Object> {
  final service = locator<T>();
}

mixin Service {
  final repository = locator<HttpRepository>();
}

abstract class Model<T> {
  Map<String, dynamic> toJson();
  Model();
}
