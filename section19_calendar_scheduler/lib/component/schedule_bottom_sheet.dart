// Column이 어떤 패키지에서 쓰일지 모르는 상황
// Value만 쓰니까 다음과 같이 쓴다.
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:section19_calendar_scheduler/component/bottomsheet_text_field.dart';
import 'package:section19_calendar_scheduler/const/colors.dart';
import 'package:section19_calendar_scheduler/database/drift_database.dart';
import 'package:section19_calendar_scheduler/model/category_color.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  // schedule에 대한 정보를 담고 있는 ID.. Update 확인을 위한 변수
  final int? scheduleId;

  const ScheduleBottomSheet(
      {required this.selectedDate, this.scheduleId, super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  // DB에 색상 관리
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    // 상하좌우가 시스템으로 인해 가려진 부분을 가져올 수 있다.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return FutureBuilder<Schedule>(
        future: null,
        builder: (context, snapshot) {
          return FutureBuilder<Schedule>(
              future: widget.scheduleId == null
                  ? null
                  : GetIt.I<LocalDatabase>()
                      .getScheduleById(widget.scheduleId!),
              builder: (context, snapshot) {
                print(snapshot.data);

                if (snapshot.hasError) {
                  return Center(
                    child: Text('스케줄을 불러올 수 없습니다.'),
                  );
                }

                // FutureBuilder가 처음 실행되었고,
                // 로딩중일 때
                if (snapshot.connectionState != ConnectionState.none &&
                    !snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Future가 실행이 되고
                // 값이 있는데 단 한번도 startTime이 세팅되지 않았을 때
                if (snapshot.hasData && startTime == null) {
                  startTime = snapshot.data!.startTime;
                  endTime = snapshot.data!.endTime;
                  content = snapshot.data!.content;
                  selectedColorId = snapshot.data!.colorId;
                }

                return SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      height:
                          MediaQuery.of(context).size.height / 2 + bottomInset,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottomInset),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                          child: Form(
                            key: formKey,
                            // autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 시작 시간, 마감 시간
                                _Time(
                                  onStartSaved: (String? val) {
                                    startTime = int.parse(val!);
                                  },
                                  onEndSaved: (String? val) {
                                    endTime = int.parse(val!);
                                  },
                                  startInitialValue:
                                      startTime?.toString() ?? '',
                                  endInitialValue: endTime?.toString() ?? '',
                                ),
                                SizedBox(height: 16.0),
                                _Content(
                                  onSaved: (String? val) {
                                    content = val;
                                  },
                                  initialValue: content ?? '',
                                ),
                                SizedBox(height: 16.0),
                                FutureBuilder<List<CategoryColor>>(
                                    future: GetIt.I<LocalDatabase>()
                                        .getCategoryColors(),
                                    builder: (context, snapshot) {
                                      // 맨 처음에는 첫 번째 색깔로 저장
                                      if (snapshot.hasData &&
                                          selectedColorId == null &&
                                          snapshot.data!.isNotEmpty) {
                                        selectedColorId = snapshot.data![0].id;
                                      }

                                      return _ColorPicker(
                                        colors: snapshot.hasData
                                            ? snapshot.data!
                                            : [],
                                        selectedColorId: selectedColorId,
                                        colorIdSetter: (int id) {
                                          setState(() {
                                            selectedColorId = id;
                                          });
                                        },
                                      );
                                    }),
                                SizedBox(height: 8.0),
                                _SaveButton(
                                  onPressed: onSavePressed,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  void onSavePressed() async {
    // formKey는 생성을 했는데
    // Form 위젯과 결합을 안했을 때
    // == (Form 위젯에 key값으로 넣어주지 않았을 때)
    if (formKey.currentState == null) {
      return;
    }

    // 모든 TextFormField를 검사했을 때
    if (formKey.currentState!.validate()) {
      print('에러가 없습니다.');

      // 값 저장
      formKey.currentState!.save();

      // 일정을 새로 생성(DB에 scheduleId가 존재하지 않을 때)
      if (widget.scheduleId == null) {
        print('-----------');
        print('startTime : $startTime');
        print('endTime : $endTime');
        print('content : $content');

        final key = await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );

        print('SAVE 완료 $key');
      }
      // 이미 존재하는 일정이다 (ScheduleId 값이 존재한다.)
      else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );
      }

      Navigator.of(context).pop();
    }
    // 하나라도 에러가 있다면...
    else {
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;

  const _Time(
      {required this.onStartSaved,
      required this.onEndSaved,
      required this.startInitialValue,
      required this.endInitialValue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          isTime: true,
          onSaved: onStartSaved,
          initialValue: startInitialValue,
        )),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: onEndSaved,
          initialValue: endInitialValue,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  const _Content(
      {required this.onSaved, required this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
        initialValue: initialValue,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  //final List<Color> colors;
  final List<CategoryColor> colors;

  // 선택된 색상
  final int? selectedColorId;

  // 선택된 색상 지정
  final ColorIdSetter colorIdSetter;

  const _ColorPicker(
      {required this.colors,
      required this.selectedColorId,
      required this.colorIdSetter,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList(),
    );
  }

  // Widget renderColor(Color color) {
  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          int.parse(
            'FF${color.hexCode}',
            radix: 16,
          ),
        ),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4.0,
              )
            : null,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
