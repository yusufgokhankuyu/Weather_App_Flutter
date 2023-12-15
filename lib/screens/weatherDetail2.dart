import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/suggestions.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utilities/colors.dart';

class WeatherDetail extends StatefulWidget {
  String? secilenIl;
  String? fullAdress;
  WeatherDetail({super.key, required this.secilenIl, required this.fullAdress});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  List<Weather> weatherList = [];
  Suggestions suggestions = Suggestions(sicaklik: 5);
  @override
  void initState() {
    print(widget.secilenIl);
    getWeatherData(widget.secilenIl!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return weatherList.isEmpty
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weatherList[0].day,
                    style: GoogleFonts.quicksand(
                      fontSize: 16.0,
                      color: buildTextColor(weatherList[0].status),
                    ),
                  ),
                  Text(
                    weatherList[0].date,
                    style: GoogleFonts.quicksand(
                      fontSize: 16.0,
                      color: buildTextColor(weatherList[0].status),
                    ),
                  ),
                ],
              ),
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: buildTextColor(weatherList[0].status),
                        ),
                        Text(
                          widget.secilenIl!.toUpperCase(),
                          style: GoogleFonts.quicksand(
                            fontSize: 16.0,
                            color: buildTextColor(weatherList[0].status),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: buildBackGroundColorGradient(weatherList[0].status),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(widget.fullAdress.toString()),
                    Image.network(weatherList[0].icon,
                        width: MediaQuery.of(context).size.width / 4),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${double.parse(weatherList[0].degree).round().toString()}°C",
                      style: GoogleFonts.quicksand(
                        fontSize: 70.0,
                        fontWeight: FontWeight.w300,
                        color: buildTextColor(weatherList[0].status),
                      ),
                    ),
                    Text(
                      weatherList[0].description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300,
                        color: buildTextColor(weatherList[0].status),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Öneriler",
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            suggestions.oneri(),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.quicksand(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Aktivite",
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            suggestions.aktiviteSeviyeleri(),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.quicksand(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: weatherList.length - 1,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                buildWeatherListText(
                                    weatherList[index + 1].day),
                                style: GoogleFonts.quicksand(
                                  fontSize: 20.0,
                                ),
                              ),
                              Image.network(
                                weatherList[index + 1].icon,
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${double.parse(weatherList[index + 1].min).round()}°",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "${double.parse(weatherList[index + 1].max).round()}°",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.transparent,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  List<Color> buildBackGroundColorGradient(String weather) {
    if (weather.toLowerCase() == "snow") {
      return [niceWhite, niceDarkBlue];
    } else if (weather.toLowerCase() == "rain") {
      return [niceVeryDarkBlue, niceDarkBlue];
    } else {
      return [niceBlue, niceDarkBlue];
    }
  }

  Color buildTextColor(String weather) {
    if (weather.toLowerCase() == "snow") {
      return niceTextDarkBlue;
    } else if (weather.toLowerCase() == "rain") {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  void getWeatherData(String cityData) {
    ApiService.getWeatherDataByCity(cityData).then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          widget.secilenIl = resultBody['city'];
          Iterable result = resultBody['result'];
          weatherList =
              result.map((watherData) => Weather(watherData)).toList();
          suggestions =
              Suggestions(sicaklik: double.parse(weatherList[0].degree));
        });
      }
    });
  }

  String buildWeatherListText(String day) {
    switch (day.toLowerCase()) {
      case "pazartesi":
        return "Pazartesi";
      case "salı":
        return "Salı           ";
      case "çarşamba":
        return "Çarşamba";
      case "perşembe":
        return "Perşembe";
      case "cuma":
        return "Cuma        ";
      case "cumartesi":
        return "Cumartesi   ";
      case "pazar":
        return "Pazar          ";
      default:
        return "?";
    }
  }
}
