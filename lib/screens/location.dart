import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/welcome_page.dart';

class LocationPage extends StatefulWidget {
  LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var locationMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hava Durumu Nasıl"),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Hoşgeldiniz",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        Color.fromARGB(255, 152, 203, 153),
                        Color.fromARGB(255, 95, 141, 179),
                        Colors.red
                      ], // Gradient renkleri
                      begin: Alignment.topLeft, // Başlangıç noktası
                      end: Alignment.bottomRight, // Bitiş noktası
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Text(
                    "Konuma göre hava durumu",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    child: ElevatedButton(
                      onPressed: () {
                        // "Başka il seç" butonuna tıklandığında yapılacak işlemler
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                        );
                      },
                      child: Text("Farklı il seç",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Kullanıcı izni reddetti.
        return;
      }
    }

    // Kullanıcı izni verdi, konum bilgisini alabiliriz.
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
// Geocoding API anahtarını belirle
    GeocodingPlatform.instance.locationFromAddress('dummy',
        localeIdentifier:
            Constants().apiKey); // Buraya API anahtarınızı ekleyin

    // Koordinatları adres bilgilerine dönüştür
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Alınan adres bilgilerini kullan
    if (placemarks != null && placemarks.isNotEmpty) {
      var placemark = placemarks[0];
      setState(() {
        //${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality},
        locationMessage = "${placemark.administrativeArea}";

        print("Location message:::::::::::" + locationMessage);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              secilenIl: locationMessage,
              fullAdress:
                  "No:${placemark.subThoroughfare}, ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}",
            ),
          ),
        );
      });
    } else {
      locationMessage = "No";
    }
  }
}
