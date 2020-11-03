import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../settings_page.dart';
import 'assignment/assignment_page.dart';
import 'models/model.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key key}) : super(key: key);

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => AssignmentPage());

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  var _length;
  var _completed;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    Assignment.collectionReference.get().then((value) => setState(() {
          _length = value.docs.length;
        }));

    Assignment.completed.get().then((val) => _completed = val.docs[0]);

    return Scaffold(
      backgroundColor: Color(0xffF5CB5C),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.push(context, SettingsPage.route()))
        ],
        elevation: 0.0,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage("assets/assignment.png")),
        ),
        backgroundColor: Color(0xFF242423),
        title: Text(
          "Assignments",
          textAlign: TextAlign.start,
          style: textStyle.headline5.copyWith(
            color: Color(0xffF5CB5C),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Track your", style: textStyle.headline6),
                        Text("assingments!!", style: textStyle.headline6),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: _length == 0
                                ? Color(0xFF5C6D70)
                                : Color.fromRGBO(193, 214, 233, 1),
                            elevation: 20.0,
                            child: Container(
                              padding: _length == 0
                                  ? EdgeInsets.all(20.0)
                                  : EdgeInsets.all(10.0),
                              height: _length == 0 ? 80 : 350,
                              width: _length == 0 ? 300 : 500,
                              child: _length == 0
                                  ? Text("Add assignments",
                                      textAlign: TextAlign.center,
                                      style: textStyle.headline6.copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ))
                                  : Column(children: [
                                      Text("Progress",
                                          style: textStyle.headline5
                                              .copyWith(color: Colors.white)),
                                      PieChartView()
                                    ]),
                            ),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                          context, AssignmentPageWidget.route())
                                      .then((value) => setState(() {}));
                                });
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.add, //color: Colors.white
                                ),
                                title: Text("Assignments",
                                    style: textStyle.headline6.copyWith(
                                      fontSize: 18,
                                    )),
                              ),
                            )),
                        Container(
                          height: 500,
                          child: Stack(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Assignments")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) return Text("");
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Dismissible(
                                        key: UniqueKey(),
                                        background: Container(
                                          color: Colors.red,
                                        ),
                                        onDismissed: (direction) async {
                                          await FirebaseFirestore.instance
                                              .runTransaction((Transaction
                                                  myTransaction) async {
                                            await myTransaction.delete(snapshot
                                                .data.docs[index].reference);
                                          });
                                          setState(() {
                                            _completed.reference.updateData({
                                              'CompletedAssignments': _completed[
                                                      'CompletedAssignments'] -
                                                  1
                                            });
                                          });
                                        },
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (build) =>
                                                      AssignmentPageWidget(
                                                    preName: snapshot
                                                            .data.docs[index]
                                                        ["AssignmentName"],
                                                    preDeadline: snapshot
                                                            .data.docs[index]
                                                        ["AssignmentDeadline"],
                                                    editIndex: index,
                                                    documents: snapshot
                                                        .data.docs[index],
                                                  ),
                                                ),
                                              ).then(
                                                  (value) => setState(() {}));
                                            });
                                          },
                                          title: Text(snapshot.data.docs[index]
                                              ["AssignmentName"]),
                                          subtitle: Text(
                                            "${snapshot.data.docs[index]["AssignmentDeadline"]}",
                                            style: textStyle.caption,
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.check_box),
                                            iconSize: 30.0,
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _completed.reference
                                                      .updateData(
                                                    {
                                                      'CompletedAssignments':
                                                          _completed[
                                                                  'CompletedAssignments'] +
                                                              1
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
