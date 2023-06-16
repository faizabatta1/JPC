import 'package:flutter/material.dart';

class SoundSettings extends StatefulWidget {
  const SoundSettings({Key? key}) : super(key: key);

  @override
  State<SoundSettings> createState() => _SoundSettingsState();
}

class _SoundSettingsState extends State<SoundSettings> {
  bool _isVibrationEnabled = true;
  bool _isSoundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Sound Settings',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Sound',
                style: TextStyle(fontSize: 16.0),
              ),
              Switch(
                value: _isSoundEnabled,
                onChanged: (value) {
                  setState(() {
                    _isSoundEnabled = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Volume',
                style: TextStyle(fontSize: 16.0),
              ),
              Slider(
                value: 0.5,
                min: 0.0,
                max: 1.0,
                onChanged: (value) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
