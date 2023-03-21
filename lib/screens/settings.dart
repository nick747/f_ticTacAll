import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatefulWidget {
  final Function() notifySettingsChange;
  const SettingsPage({
    Key? key,
    required this.notifySettingsChange,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  // var darkMode = (Settings.getValue<bool>('darkMode', defaultValue: false))!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: (Settings.getValue<bool>('darkMode', defaultValue: false))!
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              color: (Settings.getValue<bool>('darkMode', defaultValue: false))! ? Colors.white : Colors.black,
              fontFamily: 'Overpass',
            ),
          ),
          backgroundColor:
              (Settings.getValue<bool>('darkMode', defaultValue: false))!
                  ? const Color(0xff363636)
                  : Colors.white,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SwitchSettingsTile(
                title: "Dark Mode",
                leading: const Icon(Icons.dark_mode),
                defaultValue: false,
                settingKey: 'darkMode',
                onChange: (value) {
                  setState(() {});
                  widget.notifySettingsChange();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
