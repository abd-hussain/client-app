enum DayNameEnum {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday
}

class WorkingHourUTCModel {
  List<int> list;
  DayNameEnum dayName;

  WorkingHourUTCModel({required this.list, required this.dayName});
}
