import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Models/TaskModel.dart';
import 'package:to_do/Screens/Tasks/task_details.dart';
import 'package:to_do/Screens/edit_tasks.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';


// ignore: must_be_immutable
class TaskItem extends StatefulWidget {

  TaskModel taskModel;

  TaskItem({required this.taskModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                EditScreen.routeName,
              );
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)),
          ),
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(widget.taskModel.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 120,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 70,
                color: widget.taskModel.isDone ? Color(0xFF61E757) : Color(0xFF5D9CEC),
                width: 5,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.taskModel.title,
                   maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            widget.taskModel.isDone ? Color(0xFF61E757) : Color(0xFF5D9CEC),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, TaskDetails.routeName);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF5D9CEC),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          'Show task details',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  widget.taskModel.isDone = !widget.taskModel.isDone;
                  FirebaseFunctions.editTask(widget.taskModel);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: widget.taskModel.isDone ? Color(0xFF61E757) : Color(0xFF5D9CEC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 60,
                    height: 45,
                    child: const Icon(
                      Icons.done_rounded,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
