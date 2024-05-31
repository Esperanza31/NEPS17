import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_five/models/ModelProvider.dart';
import 'package:mini_project_five/pages/busdata.dart';
import 'package:mini_project_five/screen/evening_bus.dart';
import 'package:mini_project_five/amplifyconfiguration.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api_dart/amplify_api_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mini_project_five/pages/loading.dart';

class AfternoonService extends StatefulWidget {
  final Function(int) updateSelectedBox;


  AfternoonService({required this.updateSelectedBox});


  @override
  _AfternoonServiceState createState() => _AfternoonServiceState();
}

class _AfternoonServiceState extends State<AfternoonService> {
  int selectedBox = 0; // Default to no selection
  int? bookedTripIndexKLT;
  int? bookedTripIndexCLT;
  bool confirmationPressed = false;
  //bool showBookingDetails = false;
  DateTime currentTime = DateTime.now();
  String? BookingID;
  String selectedBusStop = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final provider = ModelProvider();
    final amplifyApi = AmplifyAPI(options: APIPluginOptions(modelProvider: provider));
    final dataStorePlugin = AmplifyDataStore(modelProvider: provider);

    Amplify.addPlugin(dataStorePlugin);
    Amplify.addPlugin(amplifyApi);
    Amplify.configure(amplifyconfig);

    print('Amplify configured');
  }

  Future<void> create(String _MRTStation, int _TripNo, String _BusStop) async {
    try {
      final model = BOOKINGDETAILS5(
        id: Uuid().v4(),
        MRTStation: _MRTStation,
        TripNo: _TripNo,
        BusStop: _BusStop,
      );

      final request = ModelMutations.create(model);
      final response = await Amplify.API.mutate(request: request).response;

      final createdBOOKINGDETAILS5 = response.data;
      if (createdBOOKINGDETAILS5 == null) {
        safePrint('errors: ${response.errors}');
        return;
      }

      String id  = createdBOOKINGDETAILS5.id;
      setState(() {
        BookingID = id;
      });
      safePrint('Mutation result: $BookingID');// Return the ID of the created object
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }

    _MRTStation=='KAP'? countKAP(_TripNo, _BusStop): countCLT(_TripNo, _BusStop);

  }
  Future<BOOKINGDETAILS5?> readByID() async {
    final request = ModelQueries.list(
      BOOKINGDETAILS5.classType,
      where: BOOKINGDETAILS5.ID.eq(BookingID),
    );
    final response = await Amplify.API.query(request: request).response;
    final data = response.data?.items.firstOrNull;
    return data;
  }

  Future<int?> countBooking(String MRT, int TripNo) async{
    int? count;
    try {
      final request = ModelQueries.list(
        BOOKINGDETAILS5.classType,
        where: BOOKINGDETAILS5.MRTSTATION.eq(MRT).and(
            BOOKINGDETAILS5.TRIPNO.eq(TripNo)),
      );
      final response = await Amplify.API
          .query(request: request)
          .response;
      final data = response.data?.items;

      if (data != null) {
        count = data.length;
        print('$count');
      }
      else
        count = 0;
    }
    catch (e) {
      print('$e');
    }
    return count;
    //await Future.delayed(Duration(seconds:10));

  }

  Future<void> delete() async {
    final BOOKINGDETAILS5? bookingToDelete = await readByID();
    if (bookingToDelete != null) {
      final request = ModelMutations.delete(bookingToDelete);
      final response = await Amplify.API.mutate(request: request).response;
      if(bookingToDelete.MRTStation == 'KAP')
        countKAP(bookingToDelete.TripNo, bookingToDelete.BusStop);
      else
      countCLT(bookingToDelete.TripNo, bookingToDelete.BusStop);
    } else {
      print('No booking found with ID: $BookingID');
    }
  }

  Future<void> countCLT(int _TripNo, String _BusStop) async {
    int? count;
    //read if there is row
    final request1 = ModelQueries.list(
      CLT.classType,
      where: CLT.TRIPNO.eq(_TripNo).and(CLT.BUSSTOP.eq(_BusStop)),
    );
    final response1 = await Amplify.API
        .query(request: request1)
        .response;
    final data1 = response1.data?.items.firstOrNull;
    print('Row found');

    //if data1 != null delete that row
    if (data1 != null) {
      final request2 = ModelMutations.delete(data1);
      final response2 = await Amplify.API
          .mutate(request: request2)
          .response;
    }
    //count booking
    final request3 = ModelQueries.list(
      BOOKINGDETAILS5.classType,
      where: BOOKINGDETAILS5.MRTSTATION.eq('CLT').and(
          BOOKINGDETAILS5.TRIPNO.eq(_TripNo)).and(
          BOOKINGDETAILS5.BUSSTOP.eq(_BusStop)),
    );
    final response3 = await Amplify.API
        .query(request: request3)
        .response;
    final data2 = response3.data?.items;
    if (data2 != null) {
      count = data2.length;
      print('$count');
    }
    else{
    count = 0;
    }
    //create the row
    final model = CLT(
      BusStop: _BusStop,
      TripNo: _TripNo,
      Count: count,
    );
    final request4 = ModelMutations.create(model);
    final response4 = await Amplify.API.mutate(request: request4).response;

    final createdCLT = response4.data;
  }

  Future<void> countKAP(int _TripNo, String _BusStop) async {
    int? count;
    //read if there is row
    final request1 = ModelQueries.list(
      KAP.classType,
      where: KAP.TRIPNO.eq(_TripNo).and(KAP.BUSSTOP.eq(_BusStop)),
    );
    final response1 = await Amplify.API
        .query(request: request1)
        .response;
    final data1 = response1.data?.items.firstOrNull;
    print('Row found');

    //if data1 != null delete that row
    if (data1 != null) {
      final request2 = ModelMutations.delete(data1);
      final response2 = await Amplify.API
          .mutate(request: request2)
          .response;
    }
    //count booking
    final request3 = ModelQueries.list(
      BOOKINGDETAILS5.classType,
      where: BOOKINGDETAILS5.MRTSTATION.eq('KAP').and(
          BOOKINGDETAILS5.TRIPNO.eq(_TripNo)).and(
          BOOKINGDETAILS5.BUSSTOP.eq(_BusStop)),
    );
    final response3 = await Amplify.API
        .query(request: request3)
        .response;
    final data2 = response3.data?.items;
    if (data2 != null) {
      count = data2.length;
      print('$count');
    }
    else{
      count = 0;
    }
    //create the row
    final model = KAP(
      BusStop: _BusStop,
      TripNo: _TripNo,
      Count: count,
    );
    final request4 = ModelMutations.create(model);
    final response4 = await Amplify.API.mutate(request: request4).response;

    final createdKAP = response4.data;
  }


  void showBusStopSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.cyan[50],
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5),
                Text('Choose bus stop: ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: BusStops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(BusStops[index],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w900,
                            ),),
                          onTap: () {
                            setState((){
                              selectedBusStop = BusStops[index];
                            });
                            // Handle bus stop selection here
                            Navigator.pop(context); // Close the bottom sheet
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateSelectedBox(int box) {
    if (!confirmationPressed) {
      setState(() {
        selectedBox = box;
      });
      widget.updateSelectedBox(box);
    }
  }

  void updateBookingStatusKLT(int index, bool newValue) {
    setState(() {
      if (confirmationPressed) {
        // If confirmation is pressed, allow changing selection
        confirmationPressed = false;
      } else {
        if (newValue) {
          // If the trip is selected, update the booked trip index
          bookedTripIndexKLT = index;
        } else {
          // If the trip is deselected, reset the booked trip index if it matches
          if (bookedTripIndexKLT == index) {
            bookedTripIndexKLT = null;
          }
        }
      }
    });
  }

  void updateBookingStatusCLT(int index, bool newValue) {
    setState(() {
      if (confirmationPressed) {
        // If confirmation is pressed, allow changing selection
        confirmationPressed = false;
      } else {
        if (newValue) {
          // If the trip is selected, update the booked trip index
          bookedTripIndexCLT = index;
        } else {
          // If the trip is deselected, reset the booked trip index if it matches
          if (bookedTripIndexCLT == index) {
            bookedTripIndexCLT = null;
          }
        }
      }
    });
  }

  List<DateTime> getDepartureTimes() {
    if (selectedBox == 1) {
      return KTABus1DepartureTime;
    } else {
      return CLTBus1DepartureTime;
    }
  }

  String formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void showBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 2),
                  Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                'Thank you for booking with us. Your booking has been confirmed',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  children: [
                    Text(
                      'Trip Number:',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Text('${selectedBox == 1 ? bookedTripIndexKLT! + 1 : bookedTripIndexCLT! + 1}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Time:${formatTime(getDepartureTimes()[selectedBox == 1 ? bookedTripIndexKLT! : bookedTripIndexCLT!])}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.14),
                    Text(
                      '${formatTime(getDepartureTimes()[selectedBox == 1 ? bookedTripIndexKLT! : bookedTripIndexCLT!])}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Station:',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.19),
                    Text(
                      '${selectedBox == 1 ? 'KAP' : 'CLT'}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Bus Stop:',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    Text(
                      '$selectedBusStop',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String selectedStation = selectedBox == 1 ? 'KAP' : 'CLT';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Select MRT:'),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateSelectedBox(1);
                    });
                  } , // Update CLT
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    height: selectedBox == 1 ? 70 : 40,
                    curve: Curves.easeOutCubic,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: selectedBox == 1 ? Colors.blueAccent : Colors.grey,
                        child: Center(
                          child: Text(
                            'KAP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateSelectedBox(2);
                    });
                  },  // Update CLT
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    height: selectedBox == 2 ? 70 : 40,
                    curve: Curves.easeOutCubic,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: selectedBox == 2 ? Colors.blueAccent : Colors.grey,
                        child: Center(
                          child: Text(
                            'CLT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 5),
        if (selectedBox != 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(13.0, 10.0, 0.0, 0.0),
            child: Text('Selected Station: $selectedStation',
              style: TextStyle(
                  fontFamily: 'PlayFair',
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),),
          ),
        SizedBox(height: 5),
        if (selectedBox != 0)
          Row(
            children: [
              SizedBox(width: 8),
              Icon(
                Icons.warning,
                color: Colors.amber[500],
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                'Note: Departure time listed from Block 37',
                style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'PlayFair',
                ),
              ),
            ],
          ),
        if (selectedBox != 0)
          //showBookingDetails
          confirmationPressed
              ? BookingConfirmation(
            selectedBox: selectedBox,
            bookedTripIndexKLT: bookedTripIndexKLT,
            bookedTripIndexCLT: bookedTripIndexCLT,
            getDepartureTimes: getDepartureTimes,
            BusStop: selectedBusStop,
            onCancel: () {
              setState(() {
                confirmationPressed = false;
                //showBookingDetails = false;
                //delete();
              });
            },
          )
              :
          BookingService(
            departureTimes: getDepartureTimes(),
            selectedBox: selectedBox,
            bookedTripIndexKLT: bookedTripIndexKLT,
            bookedTripIndexCLT: bookedTripIndexCLT,
            updateBookingStatusKLT: updateBookingStatusKLT,
            updateBookingStatusCLT: updateBookingStatusCLT,
            confirmationPressed: confirmationPressed,
            countBooking: countBooking,
            showBusStopSelectionBottomSheet: showBusStopSelectionBottomSheet,
            onPressedConfirm: () {
              setState(() {
                confirmationPressed = true;
                //showBookingDetails = true;
                create(selectedStation, selectedBox == 1 ? bookedTripIndexKLT!+1 : bookedTripIndexCLT!+1, selectedBusStop);
              });
              showBookingConfirmationDialog(context);
            },
          ),
      ],
    );
  }
}

class BookingService extends StatefulWidget {
  final List<DateTime> departureTimes;
  final int selectedBox;
  final int? bookedTripIndexKLT;
  final int? bookedTripIndexCLT;
  final Function(int index, bool newValue) updateBookingStatusKLT;
  final Function(int index, bool newValue) updateBookingStatusCLT;
  final VoidCallback onPressedConfirm;
  final bool confirmationPressed;
  final Future<int?> Function(String MRT, int index) countBooking;
  final Function showBusStopSelectionBottomSheet;

  BookingService({
    required this.departureTimes,
    required this.selectedBox,
    required this.bookedTripIndexKLT,
    required this.bookedTripIndexCLT,
    required this.updateBookingStatusKLT,
    required this.updateBookingStatusCLT,
    required this.onPressedConfirm,
    required this.confirmationPressed,
    required this.countBooking,
    required this.showBusStopSelectionBottomSheet,
  });

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  Color finalColor = Colors.grey;
  late Timer _timer;
  late Map<int, int?> bookingCounts; //store count

  bool canConfirm() {
    return widget.selectedBox == 1 ? widget.bookedTripIndexKLT != null : widget.bookedTripIndexCLT != null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingCounts = {};
    _timer = Timer.periodic(Duration(milliseconds:100), (timer){
      _updateBookingCounts();
    });
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
  void _updateBookingCounts() async{
    for(int i = 0; i<widget.departureTimes.length; i++){
      int? count = await widget.countBooking(widget.selectedBox == 1 ?'KAP': 'CLT', i+1);
      setState(() {
        bookingCounts[i] = count;
      });
    }
  }

  bool _isFull(int? count){
  return count !=null && count >=5;
  }

  Color _getColor(int _count){
    if (_count < 3)
      return Colors.green;
    else if (_count >=3 && _count <5)
      return Colors.yellowAccent;
    else
      return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Seat Vacancy',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Container(width: MediaQuery.of(context).size.width * 0.15, height: 5, color: Colors.green),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Text('Available'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            Container(width: MediaQuery.of(context).size.width * 0.15, height: 5, color: Colors.yellowAccent),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Text('Half Full'),
          ],
        ),
        Row(
          children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.4),
          Text('FULL'),
            Container(width: MediaQuery.of(context).size.width * 0.15, height: 5, color: Colors.red),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.departureTimes.length,
            itemBuilder: (context, index) {
              final time = widget.departureTimes[index];
              int finalvalue = 0;
              bool isBookedKLT = index == widget.bookedTripIndexKLT;
              bool isBookedCLT = index == widget.bookedTripIndexCLT;
              bool canBook = widget.selectedBox == 1
                  ? widget.bookedTripIndexKLT == null
                  : widget.bookedTripIndexCLT == null;
              int? count = bookingCounts[index];
              bool isFull = _isFull(count);

              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: isFull == true? Colors.grey[300]: Colors.lightBlue[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Set to 0.0 for 90-degree corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Row(
                                children: [
                                  if (count != null)
                                    Container(width: 8, height: 57, color: _getColor(count)),
                                  Text(
                                    ' Departure Trip ${index + 1}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(width: 70),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 2,
                                      height: 40,
                                      color: Colors.black, // Adjust color as needed
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    '${time.hour.toString().padLeft(2, '0')}:${time
                                        .minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!isFull){
                              if (widget.selectedBox == 1) {
                                widget.updateBookingStatusKLT(index, !isBookedKLT);
                                widget.showBusStopSelectionBottomSheet(context);

                              } else {
                                widget.updateBookingStatusCLT(index, !isBookedCLT);
                                widget.showBusStopSelectionBottomSheet(context);
                              }
                            }
                          },
                          child: Icon(
                            widget.selectedBox == 1 ? (isBookedKLT ? Icons.check_box : Icons
                                .check_box_outline_blank) : (isBookedCLT ? Icons
                                .check_box : Icons.check_box_outline_blank),
                            color: isFull==true ? Colors.grey : Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        if (canConfirm())
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: widget.onPressedConfirm,
                child: Text('Confirm'),
              ),
            ),
          ),
        SizedBox(height: 20),
        if(widget.selectedBox == 1)
          Row(
            children: [
              SizedBox(width: 10),
              Text('Bus ETA for King Albert MRT',
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        SizedBox(height: 5),
        if(widget.selectedBox == 1)
          EveningStartPoint.getBusTime(KTABus1DepartureTime, context),
        SizedBox(height: 30),
        if(widget.selectedBox == 2)
          Row(
            children: [
              SizedBox(width: 10),
              Text('Bus ETA for Clementi MRT',
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        SizedBox(height: 5),
        if(widget.selectedBox == 2)
          EveningStartPoint.getBusTime(CLTBus1DepartureTime, context),
      ],
    );
  }
}

class BookingConfirmation extends StatefulWidget {
  final int selectedBox;
  final int? bookedTripIndexKLT;
  final int? bookedTripIndexCLT;
  final List<DateTime> Function() getDepartureTimes;
  final VoidCallback onCancel;
  final String BusStop;

  const BookingConfirmation({
    required this.selectedBox,
    required this.bookedTripIndexKLT,
    required this.bookedTripIndexCLT,
    required this.getDepartureTimes,
    required this.onCancel,
    required this.BusStop,
  });

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  late Map<String, String?> ColorValues;
  int random_num = 1;
  DateTime? now;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    getTime();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getTime();
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  List<Color> color = [
    Colors.red,
    Colors.yellow,
    Colors.cyanAccent,
    Colors.pinkAccent,
    Colors.deepOrange,
    Colors.green,
    Colors.indigo,
    Colors.purple,
    Colors.grey,
    Colors.brown
  ];

  Future<void> getTime() async {
    try {
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Singapore'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      now = DateTime.parse(datetime);
      now = now!.add(Duration(hours: int.parse(offset)));
    }
    catch (e) {
      print('caught error: $e');
    }
  }


  Color generateColor() {
    int roundedSeconds = (now!.second ~/ 30) * 30;
    DateTime roundedTime = DateTime(
        now!.year, now!.month, now!.day, now!.hour, now!.minute,
        roundedSeconds);
    int seed = roundedTime.millisecondsSinceEpoch ~/ (1000 * 30);
    Random random = Random(seed);
    int syncedRandomNum = random.nextInt(10);
    return color[syncedRandomNum];
  }

  // Color nextgenerateColor(){
  //   DateTime now = DateTime.now();
  //   int roundedSeconds = (now.second ~/ 30) * 30;
  //   DateTime roundedTime = DateTime(now.year, now.month, now.day, now.hour, now.minute+1, roundedSeconds);
  //   int seed = roundedTime.millisecondsSinceEpoch ~/ (1000*60);
  //   Random random = Random(seed);
  //   int syncedRandomNum = random.nextInt(10);
  //   return color[syncedRandomNum];
  // }

  // int generateSyncedRandomNumber() {
  //   DateTime now = DateTime.now();
  //   int roundedSeconds = (now.second ~/ 30) * 30;
  //   DateTime roundedTime = DateTime(now.year, now.month, now.day, now.hour, now.minute, roundedSeconds);
  //   int seed = roundedTime.millisecondsSinceEpoch ~/ (1000*60);
  //   Random random = Random(seed);
  //   int syncedRandomNum = random.nextInt(10);
  //   return syncedRandomNum;
  // }

  @override
  Widget build(BuildContext context) {
    final int? bookedTripIndex = widget.selectedBox == 1
        ? widget.bookedTripIndexKLT
        : widget.bookedTripIndexCLT;
    final DateTime bookedTime = widget.getDepartureTimes()[bookedTripIndex!];
    final String station = widget.selectedBox == 1 ? 'KAP' : 'CLT';
    DateTime currentTime = DateTime.now();
    bool isAfter3pm = currentTime.hour >= 15 ? true : false;

    if (bookedTime != null) {
      if (now == null) {
        return Loading();
      }
      else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_available, color: Colors.blueAccent),
                          Text(
                            'Booking Confirmation:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                              width: 30, height: 30, color: generateColor()),
                          // SizedBox(width: 10),
                          // Container(width:30, height:30, color: nextgenerateColor()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Trip Number',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4),
                          Text('${bookedTripIndex + 1}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),)
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.52),
                          Text('${bookedTime.hour.toString().padLeft(
                              2, '0')}:${bookedTime.minute.toString().padLeft(
                              2, '0')}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),)
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Station',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.48),
                          Text('$station',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),)
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'BusStop:',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45),
                          Text('${widget.BusStop}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.65),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: ElevatedButton(
                              onPressed: widget.onCancel,
                              child: Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            EveningStartPoint.getBusTime(widget.selectedBox == 1
                ? KTABus1DepartureTime
                : CLTBus1DepartureTime, context)

          ],
        );
      }
      }
    else
      return SizedBox();
  }}


