import 'package:dpi_recruitment_sudhar_app/Pages/ContactPage.dart';
import 'package:dpi_recruitment_sudhar_app/Pages/Network.dart';
import 'package:dpi_recruitment_sudhar_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Future data;
  TextEditingController _controller;
  AnimationController _weather;
  Animation<Color> _weatherAnimation;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    data = Network(
        url:
        "http://api.weatherapi.com/v1/forecast.json?key=4f1fe2419f874540a06140139202910&q=Mumbai&days=7")
        .fetchdata();
    _weather = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _weatherAnimation =
    ColorTween(begin: Colors.yellowAccent, end: Colors.tealAccent)
        .animate(_weather)
      ..addListener(() {
        setState(() {
          if (_weather.isCompleted) {
            _weather.repeat(reverse: true);
          }
        });
      });
    _weather.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weather.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        shadowColor: Colors.transparent,
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/background.png",
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                        child: Container(
                          child: Text(
                            'WEATHER FORECAST',
                            style: TextStyle(
                                fontFamily: 'SpecialElite',
                                color: _weatherAnimation.value,
                                fontSize: GFS().fs(40, context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: TextField(
                            autofocus: false,
                            controller: _controller,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5.0),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Search the city you want',
                                hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: GFS().fs(19, context))),
                            onSubmitted: (text) {
                              setState(() {
                                _controller.text = text;
                                data = Network(
                                    url:
                                    "http://api.weatherapi.com/v1/forecast.json?key=4f1fe2419f874540a06140139202910&q=" +
                                        _controller.text +
                                        "&days=7")
                                    .fetchdata();
                              });
                            },
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: data,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height * 0.4,
                                  child: ListWheelScrollView(
                                      diameterRatio: 1.0,
                                      itemExtent:
                                      MediaQuery.of(context).size.height *
                                          0.35,
                                      children: [
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.2,
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "http:" +
                                                            Post.fromJson(
                                                                snapshot
                                                                    .data)
                                                                .current[
                                                            'condition']
                                                            ['icon']
                                                                .toString()),
                                                  )),
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .current['condition']
                                                ['text']
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    _weatherAnimation.value,
                                                    fontSize:
                                                    GFS().fs(30, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .current['temp_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Temperature",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in degree celcius",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .current['humidity']
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    _weatherAnimation.value,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .current['feelslike_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Feels like",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in degree celcius",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .forecast['forecastday'][0]
                                                ['day']['maxtemp_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Max Temp",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in degree celcius",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .forecast['forecastday'][0]
                                                ['day']['mintemp_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Min Temp",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in degree celcius",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .forecast['forecastday'][0]
                                                ['day']['avgtemp_c']
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    _weatherAnimation.value,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Average Temp",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in degree celcius",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .forecast['forecastday'][0]
                                                ['day']['maxwind_kph']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Max wind-speed",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in Km/hr",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .forecast['forecastday'][0]
                                                ['day']
                                                ['daily_chance_of_rain']
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    _weatherAnimation.value,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Chance for Rain",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white.withOpacity(0.3),
                                          width: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.35,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Post.fromJson(snapshot.data)
                                                    .current['precip_mm']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.tealAccent,
                                                    fontSize:
                                                    GFS().fs(50, context),
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Precipitation",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(30, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "in mm",
                                                  style: TextStyle(
                                                      color: _weatherAnimation
                                                          .value,
                                                      fontSize:
                                                      GFS().fs(14, context),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]));
                            } else
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height * 0.4,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ));
                          }),
                      Container(
                        child: Text(
                          " You can scroll up and down",
                          style: TextStyle(
                              color: Color(0xFFF6EC52),
                              fontSize: GFS().fs(20, context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FutureBuilder(
                          future: data,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.07),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.15,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            _weatherAnimation.value
                                                .withOpacity(0.5),
                                            _weatherAnimation.value
                                                .withOpacity(0.5)
                                          ]),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black54,
                                                spreadRadius: 1.0,
                                                blurRadius: 4.0,
                                                offset: Offset(10.0, 10.0))
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Post.fromJson(snapshot.data)
                                                .location['name']
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: GFS().fs(20, context),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            Post.fromJson(snapshot.data)
                                                .location['region']
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: GFS().fs(20, context),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              Post.fromJson(snapshot.data)
                                                  .location['country']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  GFS().fs(20, context),
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              Post.fromJson(snapshot.data)
                                                  .location['localtime']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  GFS().fs(20, context),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )));
                            } else
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.07),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.15,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            _weatherAnimation.value
                                                .withOpacity(0.5),
                                            _weatherAnimation.value
                                                .withOpacity(0.5)
                                          ]),
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black54,
                                                spreadRadius: 1.0,
                                                blurRadius: 4.0,
                                                offset: Offset(10.0, 10.0))
                                          ]),
                                      child: Center(
                                        child: Text(
                                          "No data",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: GFS().fs(20, context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )));
                          })
                    ])))
      ]),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact())),
                tileColor: Colors.black12,
                leading: Icon(Icons.info),
                title: Text(
                  "Contact",
                  style: TextStyle(fontSize: GFS().fs(20, context)),
                ),
              ),
              ListTile(
                onTap: () => Navigator.pop(context),
                tileColor: Colors.black12,
                leading: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: GFS().fs(20, context)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
