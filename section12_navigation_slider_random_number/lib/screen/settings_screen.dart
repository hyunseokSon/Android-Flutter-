import 'package:flutter/material.dart';
import 'package:section12_navigation_slider_random_number/component/number_row.dart';
import 'package:section12_navigation_slider_random_number/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({required this.maxNumber, super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    // State가 재생성되는 순간!
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // 가로로 전채 넓히기
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),

              /// slider, Elevated Button
              _Footer(
                  maxNumber: maxNumber,
                  onSliderChanged: onSliderChanged,
                  onButtonPressed: onButtonPressed),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    // Slider를 움직이게 하기 위해서 새로 build를 할 수 있어야 함!
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    // 뒤로 가기 + HomeScreen에 데이터 전달하기
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double>? onSliderChanged;
  final double maxNumber;
  final VoidCallback onButtonPressed;

  const _Footer(
      {required this.maxNumber,
      required this.onSliderChanged,
      required this.onButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    // 위젯 두개를 리턴해야 하므로 Column에 묶어준다.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              primary: RED_COLOR,
            ),
            child: Text('저장!'))
      ],
    );
  }
}
