import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students_attendance_app_mlkit/ui/absent/absent_screen.dart';
import 'package:students_attendance_app_mlkit/ui/attend/attend_screen.dart';
import 'package:students_attendance_app_mlkit/ui/attendance_history/attendance_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.face_retouching_natural, size: 30, color:Colors.white,),
                        SizedBox(width: 5,),
                        Text("Absensi",
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Item(
                    icon: 'assets/images/image 1.png',
                    text: 'Absen kehadiran',
                    description: 'Catat kehadiran mu biar gak lupa.',
                    navigate: AttendScreen(),
                  ),
                  Item(
                    icon: 'assets/images/image 2.png',
                    text: 'Cuti / Izin',
                    description: 'Isi jika izin atau sakit.',
                    navigate: AbsentScreen(),
                  ),
                  Item(
                    icon: 'assets/images/image 3.png',
                    text: 'Riwayat kehadiran',
                    description: 'Lihat siapa saja yang hadir.',
                    navigate: AttendanceHistoryScreen(),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Info",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  content: Text(
                    "Do you want to exit from the app?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        "No",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )) ??
        false);
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.icon,
    required this.text,
    required this.navigate, required this.description,
  });

  final String icon;
  final String text;
  final String description;
  final Widget navigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigate),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  icon,
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 0
                          ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      description,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
