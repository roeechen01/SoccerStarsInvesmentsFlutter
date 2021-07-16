class ValueLog {
  int value;
  DateTime time;

  ValueLog({this.time, this.value}) {
    if (time == null) time = DateTime.now();
    if (value == null) value = 0;
  }
}
