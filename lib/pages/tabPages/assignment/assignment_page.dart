import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AssignmentPageWidget extends StatefulWidget {
  AssignmentPageWidget(
      {Key key, this.preName, this.editIndex, this.preDeadline, this.documents})
      : super(key: key);
  String preName;
  String preDeadline;
  int editIndex;
  dynamic documents;
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => AssignmentPageWidget());

  @override
  _AssignmentPageWidgetState createState() => _AssignmentPageWidgetState();
}

class _AssignmentPageWidgetState extends State<AssignmentPageWidget> {
  final assignmentController = TextEditingController();
  final deadlineController = TextEditingController();

  final snackBar = SnackBar(content: Text('Please fill all the fields'));

  @override
  void initState() {
    assignmentController.text = widget.preName;
    deadlineController.text = widget.preDeadline;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    assignmentController.dispose();
    deadlineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [Image(image: AssetImage("assets/pen.png"))],
        title: Text("Add Assingments",style: textStyle.headline6.copyWith(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: FlatButton(
            textColor: Color(0xFF242423),
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          TextField(
            controller: assignmentController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.book), labelText: "Assignment"),
          ),
          TextField(
            controller: deadlineController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.paste), labelText: "Deadline"),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RaisedButton(
                  splashColor: Colors.redAccent,
                  // padding: EdgeInsets.all(8.0),
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 70,
                  ),
                  color: Colors.white,
                  elevation: 0.0,
                  shape: const CircleBorder(),
                ),
                RaisedButton(
                  splashColor: Colors.greenAccent,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () => {
                    if (assignmentController.text.isEmpty ||
                        deadlineController.text.isEmpty)
                      {Scaffold.of(context).showSnackBar(snackBar)}
                    else
                      {
                        if (widget.editIndex != null)
                          {
                            setState(() {
                              widget.documents.reference.updateData({
                                "AssignmentName": assignmentController.text,
                                "AssignmentDeadline": deadlineController.text,
                              });
                            })
                          }
                        else
                          {
                            setState(() {
                              Map<String, dynamic> _subj = {
                                "AssignmentName": assignmentController.text,
                                "AssignmentDeadline": deadlineController.text,
                              };
                              Assignment.collectionReference.add(_subj);
                            }),
                          }
                      },
                    Navigator.pop(context)
                  },
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                  color: Colors.white,
                  elevation: 0.0,
                  shape: const CircleBorder(),
                ),
              ]),
        ]),
      ),
    );
  }
}
