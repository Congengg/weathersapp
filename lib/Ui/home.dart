import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weathersapp/Ui/detail_page.dart';

import '../model/city.dart';
import '../model/constants.dart';
import '../widgets/weather_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();

  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading..';
  String imageUrl = '';
  int woeid = 44418;
  String location = 'Kuala Lumpur';

  var selectedCities = City.getSelectedCities();
  List<String> cities = ['Kuala Lumpur'];
  List<dynamic> consolidatedWeatherList = [];
  List<dynamic> next7Days = [];

  String openWeatherMapApiKey = '9cebaddf01771e49b9abdad0728f4031';
  String searchLocationUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String searchWeatherUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  void fetchLocation(String location) async {
    var searchResult = await http.get(Uri.parse('$searchLocationUrl?q=$location&appid=$openWeatherMapApiKey'));
    var result = json.decode(searchResult.body);
    setState(() {
      woeid = result['id'];
    });
  }

  void fetchWeatherData() async {
    var weatherResult = await http.get(Uri.parse('$searchWeatherUrl?id=$woeid&appid=$openWeatherMapApiKey'));
    var result = json.decode(weatherResult.body);
    consolidatedWeatherList = result['list'];

    next7Days = consolidatedWeatherList
        .where((weather) {
      var date = DateTime.parse(weather['dt_txt']);
      return date.isAfter(DateTime.now()) &&
          date.isBefore(DateTime.now().add(Duration(days: 7)));
    })
        .toList();

    setState(() {
      temperature = kelvinToCelsius(consolidatedWeatherList[0]['main']['temp'].toDouble()).round();
      weatherStateName = consolidatedWeatherList[0]['weather'][0]['main'];
      humidity = consolidatedWeatherList[0]['main']['humidity'].round();
      windSpeed = consolidatedWeatherList[0]['wind']['speed'].round();
      maxTemp = kelvinToCelsius(consolidatedWeatherList[0]['main']['temp_max'].toDouble()).round();

      var myDate = DateTime.fromMillisecondsSinceEpoch(consolidatedWeatherList[0]['dt'] * 1000);
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);

      imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();

    });
  }

  double kelvinToCelsius(double temperatureInKelvin) {
    return temperatureInKelvin - 273.15;
  }

  @override
  void initState() {
    fetchLocation(cities[0]);
    fetchWeatherData();

    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset('assets/profile.png', width: 40, height: 40,),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png', width: 20,),
                  const SizedBox(width: 4,),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: location,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((String location) {
                          return DropdownMenuItem(
                              value: location, child: Text(location));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            location = newValue!;
                            fetchLocation(location);
                            fetchWeatherData();
                          });
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),),
            Text(currentDate, style: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: myConstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: myConstants.primaryColor.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    )
                  ]
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 20,
                    child: imageUrl == '' ? const Text('') : Image.asset('assets/'+ imageUrl + '.png', width: 150,),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(weatherStateName, style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(temperature.toString(), style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),),),
                        Text('o', style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherItem(text: 'Wind Speed', value: windSpeed, unit: 'km/h', imageUrl: 'assets/windspeed.png',),
                  weatherItem(text: 'Humidity', value: humidity, unit: '', imageUrl: 'assets/humidity.png',),
                  weatherItem(text: 'Max Temperature', value: maxTemp, unit: 'C', imageUrl: 'assets/max-temp.png',),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Seven Days',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                    foregroundColor: myConstants.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          consolidatedWeatherList: next7Days, // Pass the next 7 days data
                          selectedId: 0, // You may want to adjust the selectedId as needed
                          location: location,
                        ),
                      ),
                    );
                  },
                  child: const Text('Today Details'),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: next7Days.length,
                  itemBuilder: (BuildContext context, int index) {
                    String today = DateTime.now().toString().substring(0, 10);
                    var selectedDay =
                    next7Days[index]['dt_txt'];
                    var futureWeatherName =
                    next7Days[index]['weather'][0]['main'];
                    var weatherUrl =
                    futureWeatherName.replaceAll(' ', '').toLowerCase();

                    var parsedDate = DateTime.parse(
                        next7Days[index]['dt_txt']);
                    var newDate = DateFormat('EEEE')
                        .format(parsedDate)
                        .substring(0, 3);

                    return GestureDetector(

                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(
                            right: 20, bottom: 10, top: 10),
                        width: 80,
                        decoration: BoxDecoration(
                            color: selectedDay == today
                                ? myConstants.primaryColor
                                : Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: selectedDay == today
                                    ? myConstants.primaryColor
                                    : Colors.black54.withOpacity(.2),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              next7Days[index]['main']['temp']
                                  .round()
                                  .toString() +
                                  "C",
                              style: TextStyle(
                                fontSize: 17,
                                color: selectedDay == today
                                    ? Colors.white
                                    : myConstants.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset(
                              'assets/' + weatherUrl + '.png',
                              width: 30,
                            ),
                            Text(
                              newDate,
                              style: TextStyle(
                                fontSize: 17,
                                color: selectedDay == today
                                    ? Colors.white
                                    : myConstants.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}