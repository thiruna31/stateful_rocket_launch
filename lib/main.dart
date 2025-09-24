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
        if (_counter == 100) {
          _showLiftoffDialog();
        }
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

  void _showLiftoffDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🚀 LIFTOFF!"),
        content: const Text("Congratulations, your rocket has launched!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rocket Launch Controller")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _counter == 100 ? "🚀 LIFTOFF!" : "$_counter",
                style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold, color: _getCounterColor()),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _ignite,
                  icon: const Icon(Icons.local_fire_department),
                  label: const Text("Ignite +1"),
                ),
                ElevatedButton.icon(
                  onPressed: _abort,
                  icon: const Icon(Icons.cancel),
                  label: const Text("Abort -1"),
                ),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
