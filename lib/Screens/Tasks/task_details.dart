import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetails extends StatelessWidget {
  static const String routeName = "TaskDetails";
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5D9CEC),
        title: Text("Task Details",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
      ),
      body: Column(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 110),
            height: 617,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Text("Task Details",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w900
                ),),
          ),
        ),
      
      ]),
    );
  }
}
