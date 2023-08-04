import 'package:flutter/material.dart';
import 'package:section17_future_builder_and_stream_builder/screen/home_screen_futurebuilder.dart';
import 'package:section17_future_builder_and_stream_builder/screen/home_screen_streambuilder.dart';

void main() {
  runApp(
      MaterialApp(
        home: HomeScreenStreamBuilder(),
      ),
  );
}