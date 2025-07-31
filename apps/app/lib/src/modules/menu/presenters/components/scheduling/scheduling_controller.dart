import 'package:paipfood_package/paipfood_package.dart';

class SchedulingController {
  final EstablishmentModel establishment;
  final List<OpeningHoursModel> openingHours;
  SchedulingController({required this.establishment, required this.openingHours});

  late final groupOpeningHours = openingHours.groupListsBy((e) => e.weekDayId.id);

  bool get enableTabBar => establishment.enableScheduleTomorrow;

  int get getToDay {
    return DateTime.now().weekday;
  }

  int get getTomorow {
    int today = DateTime.now().weekday;
    today = (today == 7) ? 1 : today + 1;
    return today;
  }

  OpeningHoursModel? _getOpeninHoursByWekDay(int weekDay) {
    return groupOpeningHours[weekDay]?.first;
  }

  List<HoursEnum> getHoursEnableByWeekday(int weekDay) {
    if (weekDay == getToDay) return _todayHoursEnable;
    if (weekDay == getTomorow) return _tomorowHoursEnable;
    return [];
  }

  List<HoursEnum> get _todayHoursEnable {
    final nowHour = DateTime.now().hour + 1;
    var openingHour = _getOpeninHoursByWekDay(getToDay)?.openingEnumValue.value;
    var closeHour = _getOpeninHoursByWekDay(getToDay)?.closingEnumValue.value;
    if (openingHour == null || closeHour == null) return [];

    if (nowHour > openingHour && nowHour < closeHour) {
      return HoursEnum.values.where((hour) => hour.value > nowHour && hour.value < closeHour).toList();
    }

    return [];
  }

  List<HoursEnum> get _tomorowHoursEnable {
    double? openingHour = _getOpeninHoursByWekDay(getTomorow)?.openingEnumValue.value;
    double? closeHour = _getOpeninHoursByWekDay(getTomorow)?.closingEnumValue.value;
    if (openingHour == null || closeHour == null) return [];
    openingHour += 0.5;
    return HoursEnum.values.where((open) => open.value > openingHour! && open.value < closeHour).toList();
  }
}
