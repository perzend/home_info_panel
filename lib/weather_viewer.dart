import 'package:flutter/material.dart';

class WeatherViewer extends StatelessWidget {
  const WeatherViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      // width: 200,
      color: Colors.blue,
      child: Text('Погода'),
    );
  }
}
