import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashCardEditPage extends StatefulWidget {
  FlashCardEditPage(
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
      MaterialPageRoute(builder: (context) => FlashCardEditPage());

  @override
  _FlashCardEditPageState createState() => _FlashCardEditPageState();
}

class _FlashCardEditPageState extends State<FlashCardEditPage> {
  final content = TextEditingController();
  final answer = TextEditingController();

  final snackBar = SnackBar(content: Text('Please fill all the fields'));

  @override
  void initState() {
    content.text = widget.preName;
    answer.text = widget.preMarks;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    content.dispose();
    answer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Image(image: AssetImage("assets/pen.png"))],
        title: Text("Add Flash Cards",style: TextStyle(color: Colors.black)),
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
            controller: content,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.book), labelText: "Question"),
          ),
          TextField(
            controller: answer,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.paste), labelText: "Answer"),
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
                    if (content.text.isEmpty || answer.text.isEmpty)
                      {Scaffold.of(context).showSnackBar(snackBar)}
                    else
                      {
                        if (widget.editIndex != null)
                          {
                            setState(() {
                              widget.documents.reference.updateData({
                                'CardAnswer': answer.text,
                                'CardContent': content.text,
                              });
                            })
                          }
                        else
                          {
                            setState(() {
                              Map<String, dynamic> _subj = {
                                'CardAnswer': answer.text,
                                'CardContent': content.text,
                              };
                              FlashCards.collectionReference.add(_subj);
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
