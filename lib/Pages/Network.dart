import 'dart:convert';
import 'package:http/http.dart';

class Network {
  final String url;
  Network({this.url});
  Future fetchdata() async {
    Response _responce = await get(Uri.encodeFull(url));
    if (_responce.statusCode == 200) {
      return (json.decode(_responce.body));
    } else
      print("error");
  }
}

class Post {
  Map<String, dynamic> location;
  Map<String, dynamic> current;
  Map<String, dynamic> forecast;
  Map<String, dynamic> day;
  Post({this.location, this.current, this.forecast, this.day});

  factory Post.fromJson(Map<String, dynamic> json1) {
    return Post(
      location: json1['location'],
      current: json1['current'],
      forecast: json1['forecast'],
      day: json1['day'],
    );
  }
}
