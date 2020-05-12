import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;
  String time;
  String flag;
  String  url;
  bool isDayTime;

  WorldTime({this.location, this.time, this.flag, this.url});

  Future<void> getTime() async{

    try {
      String endpoint = 'http://worldtimeapi.org/api/timezone/$url';
      Response response = await get(endpoint);
      Map data = jsonDecode(response.body);
      
      //get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1,3)),minutes: int.parse(offset.substring(4,6))));

      //set time property
      isDayTime = now.hour > 6 && now.hour<20 ? true : false ;
      time = DateFormat.jm().format(now);

    }catch (e) {
      print('caught error: $e');
      time = 'could not get data';
    }
  }
}

