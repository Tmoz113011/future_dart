import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/widgets.dart';

import 'ScheduleCard.dart';

class ListSchedule extends StatelessWidget {
  final List<Schedule> schedules;
  ListSchedule({this.schedules});

  ListView _listAlarms(context) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, i) => ScheduleCard(schedule: schedules[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _listAlarms(context);
  }
}
