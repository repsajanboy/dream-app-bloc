import 'package:flutter/material.dart';

class RandomDreamQoute extends StatelessWidget {
  const RandomDreamQoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 40,
        bottom: 20.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.indigoAccent,
            Colors.indigo.shade400,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      height: 150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '"Sleep, sleep, beauty bright,',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Text(
            'dreaming in the joys of the night"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '-William Blake',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
