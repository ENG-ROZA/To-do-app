// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  static const String routeName = "edit";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  var edit_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: [
              AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 27),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                toolbarHeight: 130,
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 27),
                  child: Text("To Do"),
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 110),
                  height: 617,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(children: [
                      const Text("Edit Task",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Title",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Task description",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 50),
                        child: const Text(
                          "Select time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDatepicker(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 40, bottom: 60),
                          child: Text(
                            edit_date.toString().substring(0, 10),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }

  void showDatepicker(BuildContext context) async {
    DateTime? chossDate = await showDatePicker(
        context: context,
        initialDate: edit_date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chossDate != null) {
      edit_date = chossDate;
      setState(() {});
    }
  }
}
