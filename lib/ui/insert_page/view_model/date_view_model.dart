import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
import 'package:food_limmit_controller/domain/model/date/date.dart';
import 'package:food_limmit_controller/domain/model/insert_item/insert_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_view_model.g.dart';

@Riverpod(keepAlive: true)
class DateViewModel extends _$DateViewModel {
  @override
  Date build() {
    return Date(year: '', month: '', day: '');
  }

  void setYearDate(String year) {
    state = state.copyWith(year: year);
  }

  void setMonthDate(String month) {
    state = state.copyWith(month: month);
  }

  void setDayDate(String day) {
    state = state.copyWith(day: day);
  }

  DateTime fromStringToDate() {
    final now = DateTime.now();
    //西暦の前２つを切り取るex.2025なら2000
    final frontNowYear = (now.year ~/ 100) * 100;
    if (state.day == '下旬') {
      return DateTime(
        frontNowYear + int.parse(state.year),
        int.parse(state.month),
        16,
      );
    } else {
      return DateTime(
        frontNowYear + int.parse(state.year),
        int.parse(state.month),
        1,
      );
    }
  }
}
