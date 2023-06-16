import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool _isDarkModeEnabled = false;
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from shared preferences
  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkModeEnabled = prefs.getBool('darkMode') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkModeEnabled);
    await prefs.setDouble('fontSize', _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الاعدادات الاساسية',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // const Text('المظهر',
          //     style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          // SwitchListTile(
          //   title: const Text('الوضع الليلي'),
          //   value: _isDarkModeEnabled,
          //   onChanged: (value) {
          //     setState(() {
          //       _isDarkModeEnabled = value;
          //     });
          //
          //     if (value) {
          //       BlocProvider.of<ThemeBloc>(context)
          //           .add(ThemeChangedEvent(appThemeName: 'DARK_THEME'));
          //     } else {
          //       BlocProvider.of<ThemeBloc>(context)
          //           .add(ThemeChangedEvent(appThemeName: 'NORMAL_THEME'));
          //     }
          //     _saveSettings();
          //   },
          // ),
          const Divider(),
          const Text('حجم الخط',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Slider(
            value: _fontSize,
            onChanged: (value) {
              setState(() {
                _fontSize = value;
              });
            },
            min: 10.0,
            max: 24.0,
            divisions: 7,
            label: '${_fontSize.toInt()}',
          ),
        ],
      ),
    );
  }
}
