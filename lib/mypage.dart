import 'dart:js_interop';

import 'package:final_640710052/weather_item.dart';
import 'package:final_640710052/weather_repository.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  WeatherItem? _weatherItem;
  bool? _isLoading;
  String? _errorMessage;
  WeatherRepository weatherRepository = WeatherRepository();
  bool c = true;
  String? feel;
  String? wind;
  String city = 'bangkok';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  getWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var weather = await weatherRepository.getWeather(city);

      setState(() {
        _weatherItem = weather;
        c = true;
        setString();
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void setString() {
    if (c) {
      feel = 'Feels like ${_weatherItem!.feelsLikeC}';
      wind = '${_weatherItem!.windKph} km/h';
    } else {
      feel = 'Feels like ${_weatherItem!.feelsLikeF}';
      wind = '${_weatherItem!.windMph} mph';
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    buildError() => Center(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getWeather(), child: Text('Retry'))
            ])));

    Widget buildPage() => Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          city = 'bangkok';
                        });
                        getWeather();
                      },
                      child: Text(
                        'Bangkok',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          city = 'nakhon pathom';
                        });
                        getWeather();
                      },
                      child: Text(
                        'Nakhon Pathom',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          city = 'paris';
                        });
                        getWeather();
                      },
                      child: Text(
                        'Paris',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  _weatherItem!.city,
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  _weatherItem!.country,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  _weatherItem!.lastUpdated,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Image.network(_weatherItem!.condition.icon),
                Text(
                  _weatherItem!.condition.text,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  (c == true)
                      ? _weatherItem!.tempC.toString()
                      : _weatherItem!.tempF.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  feel!,
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            c = true;
                            setString();
                          });
                        },
                        child: Text(
                          '°C',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            c = false;
                            setString();
                          });
                        },
                        child: Text(
                          '°F',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.water_drop, size: 30),
                      Text(
                        "HUMIDITY",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${_weatherItem!.humidity.toString()} %",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.air, size: 30),
                      Text(
                        "WIND",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        wind!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.sunny, size: 30),
                      Text(
                        "UV",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        _weatherItem!.uv.toString(),
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));

    checkStatus() {
      if (_weatherItem?.isNull == false) return buildPage();
      if (_errorMessage != null) return buildError();
      if (_isLoading == true) return buildLoadingOverlay();
    }

    return Scaffold(
      body: checkStatus(),
    );
  }
}
