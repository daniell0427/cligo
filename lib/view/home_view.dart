import 'package:cligo/database/functions/get_ads_id.dart';
import 'package:cligo/forms/searchfield_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cligo/newWidgets/calatorieItem.dart';
import '../features/searchfield_form_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _startLocation;
  late final TextEditingController _endLocation;
  late final TextEditingController _dateinput;
  late final TextEditingController _availableSeats;

  @override
  void initState() {
    _startLocation = TextEditingController();
    _endLocation = TextEditingController();
    _dateinput = TextEditingController();
    _availableSeats = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _startLocation.dispose();
    _endLocation.dispose();
    _dateinput.dispose();
    _availableSeats.dispose();

    super.dispose();
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 185, 201),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //searchBox(),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: FittedBox(
                  child: Column(
                    children: [
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.only(
    //     top: 20.0,
    //     bottom: 5.0,
    //     left: 5.0,
    //     right: 5.0,
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Row(
    // children: [
    //   //location form
    //   searchfieldForm(_startLocation, _formKey1, 'Locația'),
    //   //end location form

    //           const Padding(
    //             padding: EdgeInsets.only(left: 40),
    //           ),

    //           //destination form
    //           searchfieldForm(_endLocation, _formKey2, 'Destinația'),
    //           //end destination form
    //         ],
    //       ),

    //       Padding(
    //         padding: const EdgeInsets.only(top: 20),
    //         child: Row(
    //           children: [
    //             //enter date box
    //             SizedBox(
    //               width: 180,
    //               height: 50,
    //               child: TextField(
    //                 style: const TextStyle(color: Colors.white),
    //                 controller: _dateinput,
    //                 decoration: const InputDecoration(
    //                   prefixIcon: Icon(Icons.calendar_today),
    //                   prefixIconColor: Colors.white,
    //                   labelText: "Data",
    //                   labelStyle: TextStyle(color: Colors.white),
    //                   filled: true,
    //                   fillColor: Color.fromARGB(122, 57, 57, 57),
    //                   enabledBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.white,
    //                     ),
    //                     borderRadius: BorderRadius.all(Radius.circular(0.0)),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.white,
    //                     ),
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(0.0),
    //                     ),
    //                   ),
    //                 ),
    //                 readOnly: true,
    //                 onTap: () async {
    //                   DateTime? pickedDate = await showDatePicker(
    //                       context: context,
    //                       initialDate: DateTime.now(),
    //                       firstDate: DateTime.now(),
    //                       lastDate: DateTime(2101));
    //                   if (pickedDate != null) {
    //                     String formattedDate =
    //                         DateFormat('dd-MM-yyyy').format(pickedDate);
    //                     setState(
    //                       () {
    //                         _dateinput.text = formattedDate;
    //                       },
    //                     );
    //                   } else {
    //                     print("Date is not selected");
    //                   }
    //                 },
    //               ),
    //             ), //end of enter date box

    //             const Padding(
    //               padding: EdgeInsets.only(left: 40),
    //             ),

    //             // available seats box
    //             SizedBox(
    //               width: 180,
    //               height: 50,
    //               child: TextField(
    //                 style: const TextStyle(color: Colors.white),
    //                 controller: _availableSeats,
    //                 keyboardType: TextInputType.number,
    //                 inputFormatters: <TextInputFormatter>[
    //                   FilteringTextInputFormatter.digitsOnly
    //                 ],
    //                 decoration: const InputDecoration(
    //                   prefixIcon: Icon(Icons.boy),
    //                   prefixIconColor: Colors.white,
    //                   labelText: "Nr. persoane",
    //                   labelStyle: TextStyle(color: Colors.white),
    //                   filled: true,
    //                   fillColor: Color.fromARGB(122, 57, 57, 57),
    //                   enabledBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.white,
    //                     ),
    //                     borderRadius: BorderRadius.all(Radius.circular(0.0)),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.white,
    //                     ),
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(0.0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             //end available seat box
    //           ],
    //         ),
    //       ),

    //       //searchfield button
    //       Padding(
    //         padding: const EdgeInsets.only(top: 10),
    //         child: SearchfieldButton(
    //           formKey1: _formKey1,
    //           formKey2: _formKey2,
    //           locationController: _startLocation,
    //           destinationController: _endLocation,
    //           dateController: _dateinput,
    //           seatsController: _availableSeats,
    //           textLabel: 'Caută',
    //           functionName: 'takeFromDatabase',
    //         ),
    //       )
    //       //end searchfield button
    //     ],
    //   ),
    // );
  }
}
