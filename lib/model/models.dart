import 'package:hive/hive.dart';

part "models.g.dart";

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  String text;

  @HiveField(1)
  bool isChecked;

  TodoModel({
    this.isChecked = false,
    required this.text,
  });
}
