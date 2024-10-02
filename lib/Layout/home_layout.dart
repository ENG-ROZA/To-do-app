import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/Login/Login.dart';
import 'package:to_do/Screens/SettingsScreen.dart';
import 'package:to_do/Screens/Tasks/add_task.dart';
import 'package:to_do/Screens/Tasks/TaskScreen.dart';
import 'package:to_do/providers/my_provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  static const String routName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> tabs = [
    TaskScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: const Color(0xFFdfecdb),
      appBar: AppBar(
       actions: [
          IconButton(
              onPressed: () {
                pro.logOut();
                Navigator.pushNamedAndRemoveUntil(context, Login.routeName ,(route) => false);
              },
              icon:  const Icon(Icons.logout)),
        ],
        title:  Text(
          "To Do ${pro.userModel?.Name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        
        notchMargin: 6.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          selectedItemColor: const Color(0xFF5D9CEC),
          unselectedItemColor: const Color(0xFFC8C9CB),
          items: const[
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Icon awesome-list.png"),size: 21,), label: ''),
            BottomNavigationBarItem(
             icon: ImageIcon(AssetImage("assets/images/Icon feather-settings.png"),size: 21,),
              label: '',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5D9CEC),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.white, width: 4)),
          child: const Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            showFloatingBottomSheet();
          }),
      body: SafeArea(child: tabs[currentIndex]),
    );
  }

  showFloatingBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      )),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddTask(),
      ),
    );
  }
}
