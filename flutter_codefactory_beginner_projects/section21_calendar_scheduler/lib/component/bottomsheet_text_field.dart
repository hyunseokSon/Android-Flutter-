import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;

  // true - 시간, false - 내용
  final bool isTime;
  // TextFormField에서 필요한 메서드
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.initialValue,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,

      // Form
      // null이 return되면 에러가 없다.
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }

        // 시간에 대한 에러 메세지
        if(isTime) {
          int time = int.parse(val!);

          if(time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          }

          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }

        } else {
          // 길이에 대한 제한
          // maxLength 속성에 지정해주면 안써도 되는 코드!
          if(val.length > 300) {
            return '300자 이하의 글자를 작성해주세요.';
          }
        }

        return null;
      },

      // 값을 받아올 수 있는 속성
      // onChanged: (String? val) {
      //   print(val);
      // },
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      initialValue: initialValue,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        // 밑줄을 안 생기게 none으로 설정한다.
        border: InputBorder.none,
        // 배경색을 채우기 위해서는 filled: true 속성을 지정해줘야 한다.
        filled: true,
        fillColor: Colors.grey[300],
        // 접미사 추가(뒤에 붙는 글자 추가)
        suffixText: isTime ? '시' : null,
      ),
    );
  }
}
