import 'package:hive_flutter/hive_flutter.dart';
part 'counter_model.g.dart';

enum CheckValue { even, odd }

@HiveType(typeId: 1)
class Counte {
  @HiveField(0)
  final int counts;
  @HiveField(1)
  CheckValue check;
  Counte(this.counts, this.check);
}
