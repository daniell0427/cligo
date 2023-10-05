import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

//firebase variables
FirebaseAuth fireauth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;


//user variables
User? currentUser;
late String currentUserID;
String? currentUserEmail;
late String currentUserName;
late String currentPfp;

//routes variables
List routeIDs = [];
List matchingRoutesIDs = [];
List myRouteIDs = [];


void variables() {
  //user var
  currentUser = FirebaseAuth.instance.currentUser;
  currentUserID = fireauth.currentUser!.uid;
  currentUserEmail = fireauth.currentUser?.email;
  currentUserName = fireauth.currentUser?.displayName ?? '';
  currentPfp = fireauth.currentUser?.photoURL ?? '';

  //ads var
  matchingRoutesIDs = [];
  routeIDs = [];
  myRouteIDs = [];
}
