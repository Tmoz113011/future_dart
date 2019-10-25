import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/widgets.dart';

import 'ScheduleCard.dart';

class ListSchedule extends StatefulWidget {
  List<Schedule> _schedules;
  ListSchedule(this._schedules);
  @override
  State<StatefulWidget> createState() => _ListScheduleState(_schedules);
}

class _ListScheduleState extends State<ListSchedule> {
  List<Schedule> _schedules;
  _ListScheduleState(this._schedules);

  ListView _listAlarms(context) {
    return ListView.builder(
      itemCount: _schedules.length,
      itemBuilder: (context, i) => ScheduleCard(_schedules[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _listAlarms(context);
  }
}
