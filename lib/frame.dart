import 'package:flutter/material.dart';
import 'package:home_info_panel/camera_viewer.dart';
import 'package:home_info_panel/currency_viewer.dart';
import 'package:home_info_panel/map_viewer.dart';
import 'package:home_info_panel/todolist_viewer.dart';
import 'package:home_info_panel/weather_viewer.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  var _selectedIndex = 0;

  final _fullListWidgets = [
    CameraViewer(),
    WeatherViewer(),
    // CurrencyViewer(),
    MapViewer(),
    TodolistViewer()
  ];

  @override
  Widget build(BuildContext context) {
    var _selectedWidget = _fullListWidgets.removeAt(_selectedIndex);
    return SafeArea(
      child: Scaffold(
        appBar:
            // PreferredSize(
            //   preferredSize: Size.fromHeight(100),
            //   child:
            AppBar(
          title: CurrencyViewer(),

          centerTitle: true,
          backgroundColor: Colors.black,
          //titleTextStyle: TextStyle(color: Colors.white),
        ),
        // ),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: _selectedWidget,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _fullListWidgets,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Камера'),
            BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Погода'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Карта'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Дела')
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _fullListWidgets.insert(_selectedIndex, _selectedWidget);
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
