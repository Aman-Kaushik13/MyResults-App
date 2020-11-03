import 'dart:math';

import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:flutter/material.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({
    Key key,
  }) : super(key: key);

  @override
  _PieChartViewState createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  var _length;
  var _completed;
  @override
  Widget build(BuildContext context) {
    Assignment.collectionReference
        .get()
        .then((value) => _length = value.docs.length);
    Assignment.completed
        .get()
        .then((val) => _completed = val.docs[0]['CompletedAssignments']);
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.white,
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: ProgressPainter(
                      _length,
                      _completed,
                      width: constraint.maxWidth * 0.5,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(193, 214, 233, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(-1, -1),
                        color: Colors.white,
                      ),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "${(_completed / _length * 100).round()}%",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double width;
  final int length;
  int completed;
  ProgressPainter(this.length, this.completed, {this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    // var paint = Paint()..style = PaintingStyle.stroke;
    // // ..strokeWidth = width / 2;

    // double startRadian = -pi / 2;

    // double total;
    // int numberOfAssignments = length;
    // int numberOfCompleted = Assignment.completed;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 4;

    //   var outerCircle = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = width / 2;

    double result = completed / length * 100;
    double value = completed / length;

    if (result <= 0) {
      paint.color = Colors.red;
    } else if (result <= 10) {
      paint.color = Colors.redAccent;
    } else if (result <= 30) {
      paint.color = Colors.orange;
    } else if (result <= 50) {
      paint.color = Color(0xff57CC99);
    } else if (result <= 80) {
      paint.color = Color(0xff57CC99);
    } else if (result <= 100) {
      paint.color = Colors.green;
    } else {
      paint.color = Colors.lightGreenAccent;
    }
    double angle = 2 * pi * (value);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, paint);
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ProgressPainter oldDelegate) => false;
}

class MarksPainter extends CustomPainter {
  var index;
  var marks;
  MarksPainter({
    this.index,
    this.marks,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // result = Subject.subjects.map((e) => double.parse(e) / 100 * 100 * 5) as double;

    var p1 = Offset(10, 100);

    var p2 = Offset(
        double.parse(marks[index]['SubjectMarks']) + 100 + 100 / 100 * 100,
        100);

    var result = int.parse(marks[index]['SubjectMarks']) * 100 / 100;

    var paint = Paint()..strokeWidth = 50;

    if (result <= 0) {
      paint.color = Colors.red;
    } else if (result <= 10) {
      paint.color = Colors.redAccent;
    } else if (result <= 30) {
      paint.color = Colors.orange;
    } else if (result <= 50) {
      paint.color = Color(0xff57CC99);
    } else if (result <= 80) {
      paint.color = Color(0xff57CC99);
    } else if (result <= 100) {
      paint.color = Colors.green;
    }

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(MarksPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MarksPainter oldDelegate) => false;
}
