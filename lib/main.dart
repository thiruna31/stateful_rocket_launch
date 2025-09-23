import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 30, 151, 250)),
      home: const RocketController(),
    );
  }
}

class RocketController extends StatefulWidget {
  const RocketController({super.key});

  @override
  State<RocketController> createState() => _RocketControllerState();
}

class _RocketControllerState extends State<RocketController> {
  int _counter = 0;

  Color _getCounterColor() {
    if (_counter == 0) return const Color.fromARGB(255, 246, 58, 45);
    if (_counter > 50) return const Color.fromARGB(255, 58, 247, 64);
    return const Color.fromARGB(255, 249, 152, 7);
  }

  void _ignite() {
    setState(() {
      if (_counter < 100) {
        _counter++;
      }
    });
  }

  void _abort() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rocket Launch Controller")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _counter == 100 ? "🚀 LIFTOFF!" : "$_counter",
              style: TextStyle(fontSize: 52, color: _getCounterColor()),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: const Color.fromARGB(255, 58, 161, 246),
            inactiveColor: const Color.fromARGB(255, 247, 49, 35),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 11,
            children: [
              ElevatedButton(
                onPressed: _ignite,
                child: const Text("Ignite +1"),
              ),
              ElevatedButton(
                onPressed: _abort,
                child: const Text("Abort -1"),
              ),
              ElevatedButton(
                onPressed: _reset,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
