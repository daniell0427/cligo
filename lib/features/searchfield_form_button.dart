import 'package:cligo/database/read_data/user_advertisment.dart';
import 'package:flutter/material.dart';

class SearchfieldButton extends StatelessWidget {
  final GlobalKey<FormState> formKey1;
  final GlobalKey<FormState> formKey2;
  final TextEditingController locationController;
  final TextEditingController destinationController;
  final TextEditingController dateController;
  final TextEditingController seatsController;
  final String textLabel;
  final String functionName;

  const SearchfieldButton({
    super.key,
    required this.formKey1,
    required this.formKey2,
    required this.locationController,
    required this.destinationController,
    required this.dateController,
    required this.seatsController,
    required this.textLabel,
    required this.functionName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus(); //close keyboard

          //validators
          bool isValid = false;
          if (formKey1.currentState!.validate() &&
              formKey2.currentState!.validate()) {
            isValid = true;
          }

          //get the info from fields and assign it to variables
          final startLocation = locationController.text;
          final endLocation = destinationController.text;
          final date = dateController.text;
          late int? seats;
          if (seatsController.text != '') {
            seats = int.tryParse(seatsController.text);
          } else {
            seats = null;
          }

          //what to do based on parameter 'functionName:'
          SnackBar message;

          //for add_view
          if (isValid == true) {
            if (functionName == 'pushToDatabase') {
              if (seats != null &&
                  startLocation != '' &&
                  endLocation != '' &&
                  date != '') {
                pushUserAdData(
                    startLocation, endLocation, date, seats); //send ad
                locationController.clear(); //clear field
                destinationController.clear(); //clear field
                dateController.clear(); //clear field
                seatsController.clear(); //clear field
                message = const SnackBar(
                  content: Text(
                    'Anunțul tău a fost trimis!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                message = const SnackBar(
                  content: Text(
                    'Completați toate spațiile!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            }

            //for homeview
            else if (functionName == 'takeFromDatabase') {
              message = const SnackBar(
                content: Text(
                  'haha',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              message = const SnackBar(
                content: Text(
                  'Ups, ceva neașteptat s-a întâmplat! Dacă eroarea persistă contactați-ne!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            ScaffoldMessenger.of(context).showSnackBar(message); //show snackbar
          }
        },
        child: Text(
          textLabel,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
