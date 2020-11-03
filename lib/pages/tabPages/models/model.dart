import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  static var marksObtained = [];
  static var marks = [];
  static var subjects = [];
  static CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Subjects");
}

class Assignment {
  static var assingments = [];
  static var deadline = [];
  static CollectionReference completed =
        FirebaseFirestore.instance.collection("Completed");
  static CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Assignments");
}

class SalesData {
  SalesData(this.year, this.sales, {this.size});
  String year;
  double sales;
  dynamic size = 200;
}

class DarkTheme{
  static CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("DarkTheme");
}

class FlashCards{
   static CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("FlashCards");
}