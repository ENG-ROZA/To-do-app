import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Models/TaskModel.dart';
import 'package:to_do/Shared/Network/Firebase/firebase_functions.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text('Add New Task',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(
              height: 13,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value.toString().length < 4) {
                  return 'Please enter at least 4 Characters';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Task title',
                labelStyle: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                label: const Text('Task description'),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Select date',
              style: GoogleFonts.poppins(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                chooseDateTime();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(selectedDate.toString().substring(0, 10)),
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        TaskModel task = TaskModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            title: titleController.text,
                            description: descriptionController.text,
                            data: DateUtils.dateOnly(selectedDate)
                                .millisecondsSinceEpoch);
                        FirebaseFunctions.addTask(task)
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    child: Text(
                      'Add task',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  void chooseDateTime() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
