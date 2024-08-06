import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashlightControl(),
    );
  }
}

class FlashlightControl extends StatefulWidget {
  const FlashlightControl({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FlashlightControlState();
  }
}

class _FlashlightControlState extends State<FlashlightControl> {
  static const platform = MethodChannel('com.example/flashlight');
  bool _isFlashOn = false;

  Future<void> _toggleFlashlight(bool value) async {
    try {
      if (value) {
        await platform.invokeMethod('on');
      } else {
        await platform.invokeMethod('off');
      }
      setState(() {
        _isFlashOn = value;
      });
    } on PlatformException catch (e) {
      print("Erroe: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lamp"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SwitchListTile(
              title: const Text("lamp on/off"),
              value: _isFlashOn,
              onChanged: (value) {
                _toggleFlashlight(value);
              },
            ),
          ]),
        ));
  }
}
