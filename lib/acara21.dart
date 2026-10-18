// lib/acara21.dart
import 'package:flutter/material.dart';

class Acara21 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 21: Gradient'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // ============ BAGIAN 1: LinearGradient (flex 1) ============
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'LinearGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // ============ BAGIAN 2: RadialGradient (flex 2) ============
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    Colors.yellow,
                    Colors.orange,
                    Colors.red,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'RadialGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // ============ BAGIAN 3: SweepGradient (flex 1) ============
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment.center,
                  startAngle: 0.0,
                  endAngle: 3.14 * 2,
                  colors: [
                    Colors.green,
                    Colors.teal,
                    Colors.blue,
                    Colors.purple,
                    Colors.green,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'SweepGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
