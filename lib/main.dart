import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/screens/game_page.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import './screens/settings.dart';

void main() {
  const app = MyApp();
  initSettings().then((_) {
    runApp(app);
  });
}

Future initSettings() async {
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  static List<Widget> pages = <Widget>[];

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      GamePage(),
      SettingsPage(notifySettingsChange: () => {setState(() {})}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Plus_Jakarta_Sans"
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
            onTap: (index) => {
              setState(() {
                _currentIndex = index;
              })
            },
          selectedItemColor: (Settings.getValue<bool>('darkMode', defaultValue: false))! ? Colors.white : const Color(0xff181818),
          unselectedItemColor: (Settings.getValue<bool>('darkMode', defaultValue: false))! ? Colors.grey[700] : Colors.grey,
          backgroundColor: (Settings.getValue<bool>('darkMode', defaultValue: false))! ? const Color(0xff181818) : Colors.white,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Plus_Jakarta_Sans',
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Plus_Jakarta_Sans',
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.games_rounded),
              label: "Game",
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
