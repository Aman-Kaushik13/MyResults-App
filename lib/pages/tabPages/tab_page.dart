import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:flutter/material.dart';

import 'models/tab_navigation_item.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;

  _addSubjects() {
    setState(() {
      Map<String, dynamic> _subj = {
        "SubjectName": "Math",
        "SubjectMarks": "80",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj);
      Map<String, dynamic> _subj1 = {
        "SubjectName": "Literature",
        "SubjectMarks": "35",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj1);
      Map<String, dynamic> _subj2 = {
        "SubjectName": "Science",
        "SubjectMarks": "50",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj2);
      Map<String, dynamic> _subj3 = {
        "SubjectName": "PE",
        "SubjectMarks": "70",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj3);

      Map<String, dynamic> _subj4 = {
        "SubjectName": "Physics",
        "SubjectMarks": "90",
        "SubjectMarksOutOf": "100",
      };

      Subject.collectionReference.add(_subj4);
      Map<String, dynamic> _subj5 = {
        "SubjectName": "History",
        "SubjectMarks": "45",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj5);
      Map<String, dynamic> _subj6 = {
        "SubjectName": "French",
        "SubjectMarks": "20",
        "SubjectMarksOutOf": "100",
      };
      Subject.collectionReference.add(_subj6);
    });
  }

  _addAssignments() {
    setState(() {
      Map<String, dynamic> _subj = {
        "AssignmentName": "Maths HW",
        "AssignmentDeadline": "4th nov",
      };
      Assignment.collectionReference.add(_subj);

      Map<String, dynamic> _subj1 = {
        "AssignmentName": "Eng Essay",
        "AssignmentDeadline": "16th nov",
      };
      Assignment.collectionReference.add(_subj1);

      Map<String, dynamic> _subj2 = {
        "AssignmentName": "Maths Test",
        "AssignmentDeadline": "20th nov",
      };
      Assignment.collectionReference.add(_subj2);
      Map<String, dynamic> _subj3 = {
        "AssignmentName": "Read Physics book",
        "AssignmentDeadline": "2nd nov",
      };
      Assignment.collectionReference.add(_subj3);

      Map<String, dynamic> _subj4 = {
        "AssignmentName": "Home Assignment",
        "AssignmentDeadline": "19th nov",
      };
      Assignment.collectionReference.add(_subj4);

      Map<String, dynamic> _subj5 = {
        "AssignmentName": "Practice",
        "AssignmentDeadline": "2nd nov",
      };
      Assignment.collectionReference.add(_subj5);

      Map<String, dynamic> _subj6 = {
        "AssignmentName": "Personal Assignments",
        "AssignmentDeadline": "15th nov",
      };
      Assignment.collectionReference.add(_subj6);

      Map<String, dynamic> _subj7 = {
        "AssignmentName": "Prepare for Exams",
        "AssignmentDeadline": "14th nov",
      };
      Assignment.collectionReference.add(_subj7);
    });
  }

  var _completed;
  _addCompleted() {
    setState(() {
      _completed.reference.updateData(
          {'CompletedAssignments': _completed['CompletedAssignments'] + 4});
    });
  }

  _addFlashCards() {
    setState(() {
      Map<String, dynamic> _subj = {
        "CardContent": "The best Youtuber",
        "CardAnswer": "Tech With Tim",
      };

      FlashCards.collectionReference.add(_subj);
      Map<String, dynamic> _subj1 = {
        "CardContent": "Nuclear sizes are expressed in a unit named?",
        "CardAnswer": "Fermi",
      };

      FlashCards.collectionReference.add(_subj1);

      Map<String, dynamic> _subj2 = {
        "CardContent":
            "The speed of light will be minimum \nwhile passing through",
        "CardAnswer": "glass",
      };

      FlashCards.collectionReference.add(_subj2);

      Map<String, dynamic> _subj3 = {
        "CardContent":
            "The most suitable unit for expressing \nnuclear radius is",
        "CardAnswer": "fermi",
      };

      FlashCards.collectionReference.add(_subj3);
      Map<String, dynamic> _subj4 = {
        "CardContent": "An air bubble in water will act like a?",
        "CardAnswer": "concave lens",
      };

      FlashCards.collectionReference.add(_subj4);
      Map<String, dynamic> _subj5 = {
        "CardContent": "An air bubble in water will act like a?",
        "CardAnswer": "concave lens",
      };

      FlashCards.collectionReference.add(_subj5);
      Map<String, dynamic> _subj6 = {
        "CardContent": "Who created this app?",
        "CardAnswer": "Aman Kaushik",
      };

      FlashCards.collectionReference.add(_subj6);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    Assignment.completed.get().then((val) => _completed = val.docs[0]);

    return Scaffold(
      floatingActionButton: RawMaterialButton(
        elevation: 10.0,
        fillColor: Color(0xFF242423),
        splashColor: Color(0xffF5CB5C),
        onPressed: () {
          _addSubjects();
          _addAssignments();
          _addCompleted();
          _addFlashCards();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Generate Data",
            style: textStyle.button.copyWith(color: Color(0xffF5CB5C)),
          ),
        ),
        shape: const StadiumBorder(),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.show_chart,
            ),
            label: "Chart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_rounded,
            ),
            label: "Assignments",
          ),
        ],
      ),
    );
  }
}
