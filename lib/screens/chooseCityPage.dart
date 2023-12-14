import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/cities.dart';
import 'package:weather_app/screens/weatherDetailPage.dart';
import 'package:weather_app/components/plaka.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? secilenIl;
  List<String> sehirler = Cities().cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Şehir Seçiniz",
          style: GoogleFonts.quicksand(fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: sehirler.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              secilenIl: sehirler[index],
                              fullAdress: sehirler[index],
                            ),
                          ),
                        );
                        print(secilenIl);
                      },
                      child: Plaka(
                        sehir: "${sehirler[index]}",
                        plaka: index + 1,
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
