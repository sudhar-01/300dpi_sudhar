import 'package:dpi_recruitment_sudhar_app/Pages/HomePage.dart';
import 'package:dpi_recruitment_sudhar_app/main.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation1;
  Animation<Offset> _animation2;
  Animation<Offset> _animation3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation1 = Tween<Offset>(
      begin: const Offset(0.0, -20.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.7, curve: Curves.bounceOut)))
      ..addListener(() {
        setState(() {});
      });
    _animation2 = Tween<Offset>(
      begin: const Offset(-10.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 1.0, curve: Curves.elasticOut)))
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<Offset>(
      begin: const Offset(10.0, 0.0),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4834d4),
        title: Text("Contact",style: TextStyle(
          color: Colors.white,
        ),),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF7ed6df),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ListTile(
                onTap: () => Navigator.pop(context),
                tileColor: Colors.black12,
                leading: Icon(Icons.info),
                title: Text(
                  "Contact",
                  style: TextStyle(fontSize: GFS().fs(20, context)),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF4834d4),
          gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [ Color(0xFF4834d4),Color(0xFF686de0)])

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation1,
              child: Text(
                "Hey...I'm Sudharsan",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'KaronaOne',
                    fontWeight: FontWeight.bold,
                    fontSize: GFS().fs(40, context)),
              ),
            ),
            SlideTransition(
              position: _animation2,
              child: Text(
                "Contact Info:",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SpecialElite',
                    fontWeight: FontWeight.bold,
                    fontSize: GFS().fs(25, context)),
              ),
            ),
            SlideTransition(
              position: _animation3,
              child: Text(
                "sudhar01sd@gmail.com",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SpecialElite',
                    fontWeight: FontWeight.bold,
                    fontSize: GFS().fs(25, context)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
