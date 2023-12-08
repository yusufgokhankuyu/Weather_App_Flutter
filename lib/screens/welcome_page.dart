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
          Expanded(
            child: ListView.builder(
                itemCount: sehirler.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(secilenIl: sehirler[index]),
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
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => HomeScreen(),
          //         ),
          //       );
          //       print(secilenIl);
          //     },
          //     child: const Text("Hava Durumunu Öğren"))
        ],
      ),
    );
  }
}
