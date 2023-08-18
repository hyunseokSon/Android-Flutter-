import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:section19_calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:section19_calendar_scheduler/component/schedule_card.dart';
import 'package:section19_calendar_scheduler/component/today_banner.dart';
import 'package:section19_calendar_scheduler/const/colors.dart';
import 'package:section19_calendar_scheduler/model/schedule_with_color.dart';
import '../component/calendar.dart';
import '../database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // null이 되는 경우를 만들지 않고 현재 날짜로 기준을 정함.
  // UTC 기준으로 현재 날짜, 시간을 구하기 (utc)
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
              // scheduleCount: 3,
            ),
            SizedBox(height: 8.0),
            _ScheduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  // Floating Action Button 불러오는 것
  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDate: selectedDay,
              );
            });
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      // 다른 '월'을 건드렸을 때도 달력이 이동하도록 설정!
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;
  const _ScheduleList({
    required this.selectedDate,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
          stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
          builder: (context, snapshot) {
            /** where필터를 이미 drift_database 에서 해주었으므로 할 필요 없다.! **/
            // print('---------- original Data ----------');
            // // 값 확인
            // print(snapshot.data);
            //
            // // 날짜 기준으로 필터링
            // List<Schedule> schedules = [];
            //
            // if (snapshot.hasData) {
            //   schedules = snapshot.data!
            //   // UTC 시간으로 변경
            //       .where((element) => element.date.toUtc() == selectedDate).toList();
            //
            //   print('---------- filtered Data ----------');
            //   print(schedules);
            // }

            // data가 없는 경우
            print(snapshot.data);
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // 리스트에 아무런 값도 없을 때
            if(snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  '스케줄이 없습니다.'
                ),
              );
            }


            return ListView.separated(
                // itemCount: schedules.length,
              itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
                itemBuilder: (context, index) {
                  //final scheduleWithColor = schedules[index];
                  final scheduleWithColor = snapshot.data![index];

                  return Dismissible(
                    // key를 통해 어떤 widget을 지워줄지 인식한다.
                    key: ObjectKey(scheduleWithColor.schedule.id),
                    // 오른쪽에서 왼쪽으로 방향 설정
                    direction: DismissDirection.endToStart,
                    // 스와이프가 일어났을 때 콜백 메서드를 의미한다.
                    onDismissed: (DismissDirection direction) {
                      // DB에 값을 지워주는 코드를 작성한다.
                      GetIt.I<LocalDatabase>().removeSchedule(scheduleWithColor.schedule.id);
                    },
                    child: GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return ScheduleBottomSheet(
                                selectedDate: selectedDate,
                                scheduleId: scheduleWithColor.schedule.id,
                              );
                            });
                      },

                      child: ScheduleCard(
                        startTime: scheduleWithColor.schedule.startTime,
                        endTime: scheduleWithColor.schedule.endTime,
                        content: scheduleWithColor.schedule.content,
                        color: Color(
                          int.parse('FF${scheduleWithColor.categoryColor.hexCode}',
                          radix: 16),
                        ),
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }
}
