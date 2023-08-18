import 'package:section23_dusty_dust/model/stat_model.dart';
import 'package:section23_dusty_dust/model/status_model.dart';

class StatAndStatusModel {
  // 미세먼지 or 초미세먼지
  final ItemCode itemCode;
  final StatusModel status;
  final StatModel stat;

  StatAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.stat,
  });
}
