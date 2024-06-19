import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;

  WorldTime({ this.location,  this.flag,  this.url});

  Future<void> getTime() async {
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
    time = now.toString();
  }
}

WorldTime instance = WorldTime(location: 'Pailin', flag:'Cambodia.png', url:'Asia/Bangkok');