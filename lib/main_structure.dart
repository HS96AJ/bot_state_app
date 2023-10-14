import 'package:bot_state_app/Pages/general_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //Variables
  //int _selectedIndex = 0;
  // final List<Widget> _pages=[
  //   const GeneralPage(),
  //   const GeneralPage()
  // ];

  //Functions
  void navigationMovement(int index)
  {
    setState(() {
      //_selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bot State",
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.white12,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   iconSize: 20,
      //   selectedFontSize: 10,
      //   unselectedFontSize: 10,
      //   unselectedItemColor: Colors.white38,
      //   onTap: navigationMovement,
      //   items: const [
      //   BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "General"),
      //   BottomNavigationBarItem(icon: Icon(Icons.account_tree_rounded),label: "Details")
      // ]),
      // body:  _pages[_selectedIndex]
      body: const GeneralPage(),
  
  );
  }
}
