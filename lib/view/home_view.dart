import 'package:cligo/forms/searchfield_form.dart';
import 'package:flutter/material.dart';
import 'package:cligo/features/bottom_navigation.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _startLocation;
  late final TextEditingController _endLocation;
  late final TextEditingController dateinput;

  @override
  void initState() {
    _startLocation = TextEditingController();
    _endLocation = TextEditingController();
    dateinput = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _startLocation.dispose();
    _endLocation.dispose();
    dateinput.dispose();

    super.dispose();
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              searchfieldForm(_startLocation, _formKey1, 'Locația'),
              const Padding(
                padding: EdgeInsets.only(left: 40),
              ),
              searchfieldForm(_endLocation, _formKey2, 'Destinația'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 200,
              height: 50,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: dateinput,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  prefixIconColor: Colors.white,
                  labelText: "Enter Date",
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(122, 57, 57, 57),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    setState(
                      () {
                        dateinput.text = formattedDate;
                      },
                    );
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: searchfieldButton(_formKey1, _formKey2),
          )
        ],
      ),
    );
  }
}
