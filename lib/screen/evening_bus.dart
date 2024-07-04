import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_five/pages/busdata.dart';
import 'package:mini_project_five/pages/location_service.dart';

class EveningStartPoint {
  static Widget buildRowWidget(BuildContext context, String busstop, int nextBusTimeDiff, int nextNextBusTimeDiff, int index, double multiplier) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width:10),
            Container(height: 45, width: 5, color: Colors.white),
            Container(
                width: MediaQuery.of(context).size.width *0.4,
                color: Colors.lightBlue[500],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: Text(busstop,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
            ),
            SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width * 0.23,
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: Text('${nextBusTimeDiff + (multiplier * index)}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
            ),
            SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width * 0.23,
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: Text('${nextNextBusTimeDiff + (multiplier * index)}',
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                )
            ),
          ],
        ),
        SizedBox(height: 5)
      ],
    );
  }

  static Widget getBusTime(int box, BuildContext context) {
    DateTime currentTime = DateTime.now();
    //bool isAfter3pm = currentTime.hour >= 15;  // Corrected to 15 (3pm)
    double busInterval = 1.5;
    LocationService _locationservice = LocationService();
    BusSchedule _busschedule = BusSchedule();
    List<DateTime> busArrivalTimes = [];
    List<String> _busstops = _locationservice.BusStop;
    print('printing busstop');
    print(_busschedule.BusStop);



    if (box == 1) {
      busArrivalTimes = _busschedule.KAPDepartureTime;
    } else {
      busArrivalTimes = _busschedule.CLEDepartureTime;
    }
    print('printing bus arrival times');
    print(busArrivalTimes);

    List<DateTime> upcomingArrivalTimes =
    busArrivalTimes.where((time) => time.isAfter(currentTime)).toList();



    if (upcomingArrivalTimes.isEmpty) {
      return Text('NO UPCOMING BUSES');
    } else {
      int nextBusTimeDiff = upcomingArrivalTimes.isNotEmpty
          ? upcomingArrivalTimes[0].difference(currentTime).inMinutes
          : 0;
      print('difference');
      print(upcomingArrivalTimes[0].difference(currentTime).inMinutes);
      int nextNextBusTimeDiff = upcomingArrivalTimes.length > 1
          ? upcomingArrivalTimes[1].difference(currentTime).inMinutes
          : 0;

      print('difference');
      print(upcomingArrivalTimes[1].difference(currentTime).inMinutes);

      return Column(
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Text('Bus Stop',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.32),
              Text('Upcoming bus(min)',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 20),
              Text('Next bus(min)',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          for (int i  = 2; i < (_busschedule.BusStop.length)-2; i ++)
            buildRowWidget(
              context,
              _busschedule.BusStop[i],
              nextBusTimeDiff,
              nextNextBusTimeDiff,
              i,
              1.5,
            ),
        ],
      );
    }
  }
}

class GetEveningBusTime extends StatelessWidget {
  final int box;

  const GetEveningBusTime(this.box);

  @override
  Widget build(BuildContext context) {
    return EveningStartPoint.getBusTime(box, context);
  }
}
