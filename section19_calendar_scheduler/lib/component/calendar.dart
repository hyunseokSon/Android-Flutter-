import 'package:flutter/material.dart';
import 'package:section19_calendar_scheduler/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  // 선택이 기본으로 되어있지 않음.
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    super.key, });

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      // 테두리 깎기
      borderRadius: BorderRadius.circular(6.0),
      color: Colors.grey[200],
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      // 한글 설정
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      // 1800년 부터 보여줌
      lastDay: DateTime(3000),
      // 3000년 까지 보여줌.
      headerStyle: HeaderStyle(
        // 몇 주간 보여주는 창 안 보이게 설정
        formatButtonVisible: false,
        // 가운데 정렬
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      // 캘린더 style 변경
      calendarStyle: CalendarStyle(
          // 현재 날짜 Highlight 여부
          isTodayHighlighted: false,
          // 각각 날짜들의 Container의 decoration을 의미함.
          defaultDecoration: defaultBoxDeco,
          // 주말의 Decoration을 의미함.
          weekendDecoration: defaultBoxDeco,
          // 선택된 날짜의 Decoration
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            // 테두리 설정
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            ),
          ),
          // 기본 외부 Decoration 변경. 안해주면 오류 발생!
          outsideDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          // 평일 날짜의 Text Style 지정
          defaultTextStyle: defaultTextStyle,
          // 주말 날짜의 Text Style 지정
          weekendTextStyle: defaultTextStyle,
          // 선택된 날짜의 Text Style 지정
          selectedTextStyle: defaultTextStyle.copyWith(
            color: PRIMARY_COLOR,
          )),

      // 날짜 선택시 해당 날짜 focus하기.
      onDaySelected: onDaySelected,

      // 선택된 날짜를 화면에 보이도록 TableCalendar에 값을 전달해주기
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
