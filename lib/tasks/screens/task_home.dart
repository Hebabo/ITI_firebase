import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseiti/tasks/screens/add_tassk.dart';
import 'package:firebaseiti/tasks/widgets/data_slector.dart';
import 'package:firebaseiti/tasks/widgets/task_card.dart';
import 'package:firebaseiti/utils/app_colors.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({super.key});

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewTask()),
              );
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const DateSelector(),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Expanded(
                        child: TaskCard(
                          color: Color.fromRGBO(246, 222, 194, 1),
                          headerText: 'My humor upsets me XD',
                          descriptionText: 'My humor not that great:(',
                          scheduledDate: '69th August, 4020',
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.lightMainColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('10:00AM', style: TextStyle(fontSize: 17)),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
