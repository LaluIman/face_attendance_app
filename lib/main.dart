import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:students_attendance_app_mlkit/firebase_options.dart';
import 'package:students_attendance_app_mlkit/ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          cardTheme: CardTheme(
            surfaceTintColor: Colors.white,
          ),
          dialogTheme: DialogTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}

