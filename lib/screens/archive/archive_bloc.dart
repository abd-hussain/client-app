import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/mixins.dart';

class ArchiveBloc extends Bloc<FilterService> {
  List<String> listOfArchive = [];

  @override
  onDispose() {}
}
