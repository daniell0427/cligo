import 'package:cligo/constants/routes.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/database/services/route_service.dart';
import 'package:cligo/features/create_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cligo/constants/colors.dart';
import 'package:intl/intl.dart';

import '../database/push_to_firebase/create_user_ad.dart';

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
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Pallete.colorDim0),
          backgroundColor: MaterialStateProperty.all(Pallete.colorDim4),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //side: const BorderSide(color: Pallete.colorDim0, width: 2),
            ),
          ),
        ),
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus(); //close keyboard

          //validators
          bool isValid = false;
          if (formKey1.currentState!.validate() &&
              formKey2.currentState!.validate()) {
            isValid = true;
          }

          //get the info from fields and assign it to variables
          final startLocation = locationController.text;
          final destination = destinationController.text;
          final date = dateController.text;
          late int? seats;
          if (seatsController.text != '') {
            seats = int.tryParse(seatsController.text);
          } else {
            seats = null;
          }

          SnackBar? message;

          //what to do based on parameter 'functionName:'

          if (isValid == true && seats != null && date != '') {
            //format date
            DateTime date2 = DateFormat('dd-MM-yy').parse(date);
            var formattedDate = DateFormat('yy-MM-dd').format(date2);

            //for add_view
            if (functionName == 'pushToDatabase') {
              //push add to database
              pushUserAdData(
                currentUserID,
                currentUserName,
                startLocation,
                destination,
                formattedDate,
                seats,
                currentPfp,
              );

              locationController.clear(); //clear field
              destinationController.clear(); //clear field
              dateController.clear(); //clear field
              seatsController.clear(); //clear field

              //snackbar message
              message = const SnackBar(
                content: Text(
                  'Anunțul tău a fost trimis!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }

            //for homeview
            else if (functionName == 'takeFromDatabase') {
              variables(); //empty mathingRouteIDs list

              //get route ids && filter them
              await RouteService().getMatchingIDs(
                startLocation,
                destination,
                formattedDate,
                seats,
              );

              //get RouteSearchView
              Navigator.of(context).pushNamed(routesSearch);
            }

            //if error in functionName variable
            else {
              //snackbar message
              message = const SnackBar(
                content: Text(
                  'Ups, ceva neașteptat s-a întâmplat! Dacă eroarea persistă contactați-ne!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
          }

          //in case textfields are not compleated
          else {
            message = const SnackBar(
              content: Text(
                'Completați toate spațiile!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          if (message != null) {
            createSnackbar(context, message); //show snackbar
          }
        },
        child: Text(
          textLabel,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
