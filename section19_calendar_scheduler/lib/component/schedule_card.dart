import 'package:flutter/material.dart';

import '../const/colors.dart';

class ScheduleCard extends StatelessWidget {
  // 24h 기준 정각만 보여준다.
  // 만약 분까지 보여주고 싶다면 int 형이 아닌 DateTime 형으로 선언하면 된다.
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard(
      {required this.startTime,
      required this.endTime,
      required this.content,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              _Time(
                startTime: startTime,
                endTime: endTime,
              ),
              SizedBox(width: 16.0,),
              _Content(
                  content: content,
              ),
              _Category(
                  color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({required this.startTime, required this.endTime, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0,
    );

    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        // 왼쪽을 어떻게 채울지 알려주는 padLeft
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),

        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({
    required this.color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}
