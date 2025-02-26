import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetlocationScreen extends StatefulWidget {
  const GetlocationScreen({super.key});

  @override
  State<GetlocationScreen> createState() => _GetlocationScreenState();
}

class _GetlocationScreenState extends State<GetlocationScreen> {
  String? latitude;
  String? longitude;
  String? address;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      // check permission maps
      LocationPermission permission = await Geolocator.checkPermission();
      // jika denied maka request permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            isLoading = false;
            address = 'permission denied!';
          });
          return;
        }
      }

      //jika di denied forever maka buka setting
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
          address = 'permission denied forever!, please enable from setting';
        });
        return;
      }
      //mendapatkan lokasi latitude longitude
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high
        )
      );
      //konversi ke alamat
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
      );
      Placemark placemark = placemarks[0];
      setState(() {
        isLoading = false;
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        address = "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        address = 'Error $e';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator and Geocode'),
      ),
      body: Center(
        child: isLoading 
        ? CircularProgressIndicator() 
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("latitude $latitude, longitude $longitude"),
            SizedBox(height: 20,),
            Text(address ?? 'No data')
          ],
        ),
      ),
    );
  }
}