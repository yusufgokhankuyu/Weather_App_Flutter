import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Plaka extends StatelessWidget {
  final String sehir;
  final int plaka;
  const Plaka({super.key, required this.sehir, required this.plaka});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  width: 30,
                  color: Colors.blue,
                  height: 100,
                  child: const Text(
                    "TR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),

            //plaka yazan row
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Text(
                    plaka < 10 ? "0$plaka" : plaka.toString(),
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Text(
                    sehir.toUpperCase(),
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Text(
                    plaka < 10 ? "0$plaka" : plaka.toString(),
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
