import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/suggestions.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utilities/colors.dart';

class HomeScreen extends StatefulWidget {
  String? secilenIl;
  String? fullAdress;
  HomeScreen({Key? key, required this.secilenIl, required this.fullAdress})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //String city = "";
  List<Weather> weatherList = [];
  Suggestions suggestions = Suggestions(sicaklik: 5);

  // TextEditingController sehirController = TextEditingController();

  // void kontrolEt(String girdi) {
  //   if (sehirler.contains(girdi)) {
  //   } else {
  //     print('$girdi sehirler listesinde bulunmuyor.');
  //   }
  // }

  @override
  void initState() {
    //  if (sehirController.text == "") {

    //  } else {
    //    getWeatherData(sehirController.text);
    //  }
    print(widget.secilenIl);
    getWeatherData(widget.secilenIl!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (weatherList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: buildBackGroundColorGradient(weatherList[0].status),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBarWidget(),
          body: Column(
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
                style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w300,
                  color: buildTextColor(weatherList[0].status),
                ),
              ),
              Text(
                weatherList[0].description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                  color: buildTextColor(weatherList[0].status),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Öneriler",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: Text(
                    suggestions.oneri(),
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Text(
              //   "Aktivite",
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 150,
              //     child: Text(
              //       suggestions.aktiviteSeviyeleri(),
              //       textAlign: TextAlign.start,
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.separated(
                  itemCount: weatherList.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buildWeatherListText(weatherList[index + 1].day),
                            style: const TextStyle(
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
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "${double.parse(weatherList[index + 1].max).round()}°",
                                style: const TextStyle(
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
              ),
            ],
          ),
        ),
      );
    }
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

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherList[0].day,
            style: TextStyle(
              fontSize: 16.0,
              color: buildTextColor(weatherList[0].status),
            ),
          ),
          Text(
            weatherList[0].date,
            style: TextStyle(
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
                  style: TextStyle(
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
    );
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
