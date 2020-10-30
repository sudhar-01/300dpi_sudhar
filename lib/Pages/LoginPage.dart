import 'package:dpi_recruitment_sudhar_app/Pages/HomePage.dart';
import 'package:dpi_recruitment_sudhar_app/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  TextEditingController _controller;
  AnimationController _animationController;
  Animation _animation;
  Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.7, curve: Curves.easeIn)))
      ..addListener(() {
        setState(() {});
      });
    _animation2 = Tween<Offset>(
      begin: const Offset(0.0, -10.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 1.0, curve: Curves.elasticOut)))
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Opacity(
                  opacity: _animation.value,
                  child: Image.asset(
                    'assets/background.png',
                    fit: BoxFit.cover,
                  ))),
          Material(
            color: Colors.transparent,
            child: Opacity(
              opacity: _animation.value,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.15),
                      child: SlideTransition(
                        position: _animation2,
                        child: Container(
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontFamily: 'SpecialElite',
                                color: Colors.yellowAccent,
                                fontSize: GFS().fs(60, context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.15),
                      child: Container(
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
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: GFS().fs(19, context))),
                            onSubmitted: (text) {
                              if (text.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
