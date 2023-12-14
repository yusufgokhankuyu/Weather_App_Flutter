import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/weatherDetailPage.dart';
import 'package:weather_app/screens/chooseCityPage.dart';

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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.cloudy_snowing,
                  color: Colors.grey,
                  size: 35,
                ),
                Text(
                  "Havanı Öğren",
                  style: GoogleFonts.quicksand(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.cloud, color: Colors.blue, size: 35),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    getLocation();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade50,
                          Colors.blue.shade100,
                          Colors.blue.shade200,
                          Colors.blue.shade600
                        ], // Gradient renkleri
                        begin: Alignment.topRight, // Başlangıç noktası
                        end: Alignment.bottomLeft, // Bitiş noktası
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 35,
                        ),
                        Text(
                          "Konuma göre hava durumu",
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "(Bulunduğunuz konumun hava durumunu öğrenmek için tıklayınız.)",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomePage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade50,
                          Colors.blue.shade100,
                          Colors.blue.shade200,
                          Colors.blue.shade600
                        ], // Gradient renkleri
                        begin: Alignment.topLeft, // Başlangıç noktası
                        end: Alignment.bottomRight, // Bitiş noktası
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_sharp,
                          size: 35,
                        ),
                        Text("Farklı il seç",
                            style: GoogleFonts.quicksand(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(
                          "(Türkiye'de diğer illerin hava durumunu öğrenmek için tıklayınız.)",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
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
