import 'package:flutter/material.dart';

class BusTimeFunctions {
  static Widget getBusTime(List<DateTime> busArrivalTimes) {
    DateTime currentTime = DateTime.now();
    print("Current Time: $currentTime");
    print("Bus Arrival Times: $busArrivalTimes");

    List<DateTime> upcomingArrivalTimes =
    busArrivalTimes.where((time) => time.isAfter(currentTime)).toList();

    print("Upcoming Arrival Times: $upcomingArrivalTimes");

    if (upcomingArrivalTimes.isEmpty) {
      print("No upcoming arrival times");
      return Column(
        children: [
          Container(
            width: 350, // Fixed width for consistent size
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Set to 0.0 for 90-degree corners
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus_outlined),
                    Text(
                      'Upcoming bus: null',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 350, // Fixed width for consistent size
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Set to 0.0 for 90-degree corners
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus_outlined),
                    Text(
                      'Next bus: null',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {

      int nextBusTimeDiff =
          upcomingArrivalTimes[0].difference(currentTime).inMinutes;
      print("Upcoming Bus Time Difference: $nextBusTimeDiff");

      String nextNextBusTimeDiff = upcomingArrivalTimes.length > 1
          ? upcomingArrivalTimes[1].difference(currentTime).inMinutes.toString()
          : ' - ';

      print("Next Bus Time Difference: $nextNextBusTimeDiff");

      return Column(
        children: [
          Container(
            width: 350, // Fixed width for consistent size
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Set to 0.0 for 90-degree corners
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus_outlined),
                    Text(
                      'Upcoming bus: $nextBusTimeDiff minutes',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 350, // Fixed width for consistent size
            child: Card(
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Set to 0.0 for 90-degree corners
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus_outlined),
                    Text(
                      'Next bus: $nextNextBusTimeDiff minutes',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class GetBusTime extends StatelessWidget {
  final List<DateTime> busArrivalTimes;

  const GetBusTime(this.busArrivalTimes);

  @override
  Widget build(BuildContext context) {
    return BusTimeFunctions.getBusTime(busArrivalTimes);
  }
}
