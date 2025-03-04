import 'package:flutter/material.dart';

class TrafficLightScreen extends StatefulWidget {
  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _lightIndex = 0;

  void _changeLight() {
    setState(() {
      _lightIndex = (_lightIndex + 1) % 3;
    });
  }

  double _getOpacity(int index) {
    return _lightIndex == index ? 1.0 : 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Light"),
        backgroundColor: const Color.fromRGBO(155, 197, 231, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 235, 174, 195),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 200, 211, 244),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildLight(Colors.red, _getOpacity(0)),
                  SizedBox(height: 10),
                  _buildLight(Colors.yellow, _getOpacity(1)),
                  SizedBox(height: 10),
                  _buildLight(Colors.green, _getOpacity(2)),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _changeLight,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                backgroundColor: const Color.fromARGB(255, 196, 164, 237),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("เปลี่ยนไฟ"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLight(Color color, double opacity) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: opacity,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 5,
            )
          ],
        ),
      ),
    );
  }
}
