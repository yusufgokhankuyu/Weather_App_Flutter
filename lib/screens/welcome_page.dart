import 'package:flutter/material.dart';
import 'package:weather_app/models/cities.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/plaka.dart';

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
        title: const Text("Şehir Seçiniz"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DropdownButton(
          //     value: secilenIl ?? sehirler[0],
          //     onChanged: (yeniIl) {
          //       setState(() {
          //         secilenIl = yeniIl.toString();
          //       });
          //     },
          //     items: [
          //       for (var sehir in sehirler)
          //         DropdownMenuItem(
          //           child: Text(sehir),
          //           value: sehir,
          //         )
          //     ]),

          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => HomeScreen(secilenIl: sehirler[0]),
          //         ),
          //       );
          //       print(secilenIl);
          //     },
          //     child: const Text("Hava Durumunu Öğren")),
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
