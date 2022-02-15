import 'package:flutter/material.dart';
import 'package:home_info_panel/camera_viewer.dart';
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

  List<Widget> _widgetsOption = [
    CameraViewer(),
    WeatherViewer(),
    MapViewer(),
    TodolistViewer()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Container(
            // height: 480,
            // width: 640,
            color: Colors.red,
            child: _widgetsOption.elementAt(_selectedIndex),
          ),
          Column(
            children: [],
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
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
