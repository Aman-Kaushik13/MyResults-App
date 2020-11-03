import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SubjectPage extends StatefulWidget {
  SubjectPage(
      {Key key,
      this.preName,
      this.editIndex,
      this.preMarks,
      this.preOutof,
      this.documents})
      : super(key: key);
  String preName;
  String preMarks;
  String preOutof;
  int editIndex;
  dynamic documents;
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => SubjectPage());

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final controller = TextEditingController();
  final marksController = TextEditingController();
  final marksObtainedController = TextEditingController();
  final snackBar = SnackBar(content: Text('Please fill all the fields'));

  @override
  void initState() {
    controller.text = widget.preName;
    marksController.text = widget.preMarks;
    marksObtainedController.text = widget.preOutof;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    marksController.dispose();
    marksObtainedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Image(image: AssetImage("assets/pen.png"))],
        title: Text("Add Subjects", style: TextStyle(color: Colors.black),),
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
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.book), labelText: "Subject"),
          ),
          TextField(
            controller: marksController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.paste), labelText: "Marks"),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: marksObtainedController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.paste), labelText: "Marks out of"),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RaisedButton(
                  splashColor: Colors.redAccent,
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
                    if (controller.text.isEmpty ||
                        marksController.text.isEmpty ||
                        marksObtainedController.text.isEmpty)
                      {Scaffold.of(context).showSnackBar(snackBar)}
                    else
                      {
                        if (widget.editIndex != null)
                          {
                            setState(() {
                              widget.documents.reference.updateData({
                                "SubjectName": controller.text,
                                "SubjectMarks": marksController.text,
                                "SubjectMarksOutOf":
                                    marksObtainedController.text,
                              });
                            })
                          }
                        else
                          {
                            setState(() {
                              Map<String, dynamic> _subj = {
                                "SubjectName": controller.text,
                                "SubjectMarks": marksController.text,
                                "SubjectMarksOutOf":
                                    marksObtainedController.text,
                              };
                              Subject.collectionReference.add(_subj);
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
