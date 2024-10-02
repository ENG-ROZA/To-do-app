import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Screens/Tasks/task_item.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';

class TaskScreen extends StatefulWidget {
  static const String routeName = "TaskScreen";
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.teal[200],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          locale: 'en_ISO',
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Some thing Went wrong');
            }
            var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            print(tasks);
            if (tasks.isEmpty) {
              return const Center(child: Text('No Tasks'));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
          stream: FirebaseFunctions.getTasks(selectedDate),
        ),
      ],
    );
  }
}
