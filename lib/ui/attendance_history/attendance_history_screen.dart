import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Riwayat",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: dataCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          AlertDialog deleteDialog = AlertDialog(
                            title: const Text("Delete Data",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            content: const SizedBox(
                              height: 20,
                              child: Column(
                                children: [
                                  Text("Are you sure want to delete this data?",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black))
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    dataCollection.doc(data[index].id).delete();
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueAccent),
                                ),
                              ),
                              TextButton(
                                child: const Text("No",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (context) => deleteDialog);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Center(
                                      child: Text(
                                    data[index]['name'][0].toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info_outlined,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            data[index]['status'],
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.place,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                            child: Text(
                                              maxLines: 2,
                                              data[index]['address'],
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3,),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            data[index]['datetime'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text("Ups, there is no data!",
                        style: TextStyle(fontSize: 20)));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ));
          }
        },
      ),
    );
  }
}
