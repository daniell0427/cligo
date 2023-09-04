import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//firebase variables
FirebaseAuth fireauth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

//user variables
User? currentUser;
late String currentUserID;
String? currentUserEmail;
late String currentUserName;
late String currentPfp;

//ads variables
List routeIDs = [];
List matchingRoutesIDs = [];

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
}
