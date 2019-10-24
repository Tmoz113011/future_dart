class Schedule {
  static final tableName = "schedules";
  static final dbName = "schedule.db";
  final String id;
  final String duration;
  final int isOn;
  final int isDelete;
  static final String onCreateQuery = "CREATE TABLE schedules(id TEXT PRIMARY KEY, duration TEXT, isOn INTEGER, isDelete INTEGER)";

  Schedule({this.id, this.duration, this.isOn, this.isDelete});

  static Schedule defaultSchedule() {
    return new Schedule(id: DateTime.now().toString(), duration: Duration().toString(), isOn: 1, isDelete: 0);
  }

  set isOn(int value) {
    isOn = value;
  }

  set duration(String val) {
    duration = val;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'duration':  duration,
      'isOn':  isOn,
      'isDelete': isDelete
    };
  }

  @override
  String toString() {
    return "Schedule($id, $duration, $isOn, $isDelete})";
  }
}
