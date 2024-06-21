import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; // location name for the UI
  String? time; // the time in that location
  String? flag; // url to an asset flag icon
  String? url; // location url for api endpoint
  bool? isDaytime; // true or false if daytime or not

  WorldTime({ this.location,  this.flag,  this.url});

  Future<void> getTime() async {

    try {

      final Uri apiUrl = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      final Response response = await get(apiUrl);
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Extract properties from data
      final String datetime = data['utc_datetime'];
      final String offset = data['utc_offset'].substring(1, 3);

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);


    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }








  }
}

WorldTime instance = WorldTime(location: 'Pailin', flag:'Cambodia.png', url:'Asia/Bangkok');