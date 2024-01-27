import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathersapp/model/constants.dart';
class DetailPage extends StatelessWidget {
  final List<dynamic> consolidatedWeatherList;
  final int selectedId;
  final String location;

  const DetailPage({
    required this.consolidatedWeatherList,
    required this.selectedId,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    var selectedWeather = consolidatedWeatherList[selectedId];
    var date = DateTime.parse(selectedWeather['dt_txt']);
    var formattedDate = DateFormat('EEEE, d MMMM').format(date);
    var temperature = selectedWeather['main']['temp'];
    var weatherStateName = selectedWeather['weather'][0]['main'];
    var humidity = selectedWeather['main']['humidity'];
    var windSpeed = selectedWeather['wind']['speed'];
    Constants myConstants = Constants();
    return Scaffold(
      appBar: AppBar(
        title: Text('Details - $location'),
        backgroundColor: myConstants.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.thermostat, color: Colors.orange),
                    Text(
                      'Temperature: ${kelvinToCelsius(temperature).round()}°C',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.cloud, color: Colors.grey),
                    Text(
                      'Weather: $weatherStateName',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.opacity, color: myConstants.primaryColor.withOpacity(0.5),),
                    Text(
                      'Humidity: $humidity%',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.speed, color: Colors.green),
                    Text(
                      'Wind Speed: $windSpeed km/h',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double kelvinToCelsius(double temperatureInKelvin) {
    return temperatureInKelvin - 273.15;
  }
}