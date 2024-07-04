import 'package:flutter/material.dart';
import 'package:mini_project_five/pages/map_page.dart';
import 'package:mini_project_five/pages/loading.dart';
import 'package:mini_project_five/pages/information.dart';
import 'package:mini_project_five/pages/busdata.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BusSchedule().loadData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Map_Page(),
          '/information': (context) => Information_Page(),
        }
    );
  }
}