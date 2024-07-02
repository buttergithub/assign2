import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'connectivity_service.dart';
import 'battery_service.dart';
import 'signin.dart';
import 'signup.dart';
import 'calculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBi41XH0iQjIw1tfXtjVsZ6-XKt54-QqIc",
            authDomain: "fire-setup-1b71e.firebaseapp.com",
            projectId: "fire-setup-1b71e",
            storageBucket: "fire-setup-1b71e.appspot.com",
            messagingSenderId: "865095529734",
            appId: "1:865095529734:web:01679f35ee2006e019da87"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      theme: _isDarkMode ? _darkTheme : _lightTheme,
      home: HomeScreen(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

final ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const HomeScreen({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final BatteryService _batteryService = BatteryService();

  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      SignInScreen(),
      SignUpPage(),
      const CalculatorScreen(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _connectivityService.initialize(context);
      _batteryService.initialize(context);
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    _batteryService.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () => widget.toggleTheme(),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Navigation Drawer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Switch(
                    value: widget.isDarkMode,
                    onChanged: (value) => widget.toggleTheme(),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
