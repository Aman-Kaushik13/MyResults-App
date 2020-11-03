import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_project/pages/flash_cards.dart';
import 'package:cool_project/pages/settings_page.dart';
import 'package:cool_project/pages/subject_page.dart';
import 'package:flutter/material.dart';

// CFDBD5
// E8EDDF
// 242423
// FE5D26

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => MyHomePage());

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.push(context, SettingsPage.route())),
          ],
          elevation: 0.0,
          toolbarHeight: 100,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage("assets/book.png")),
          ),
          backgroundColor: Color(0xff242423),
          title: Text(
            'Students Application',
            textAlign: TextAlign.start,
            style: textStyle.headline6.copyWith(
              fontSize: 18,
              color: Color(0xffF5CB5C),
            ),
          )),
      key: _scaffoldKey,
      backgroundColor: Color(0xffF5CB5C),
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar(
          //   leading: IconButton(
          //     padding: EdgeInsets.all(18.0),
          //     icon: Icon(Icons.arrow_back_ios),
          //     iconSize: 30.0,
          //     onPressed: () => {},
          //   ),
          //   elevation: 40.5,
          //   floating: true,
          //   expandedHeight: 100.0,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Container(color: Color(0xffF5CB5C)),
          //     title: Text(
          //       'Students Application',
          //       textAlign: TextAlign.start,
          //       style: textStyle.headline6.copyWith(
          //         fontStyle: FontStyle.italic,
          //         color: Colors.white,
          //         fontSize: 18
          //       ),
          //     ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                            child: Text(
                              "Track Assignments",
                              style: textStyle.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10.0,
                            color: Color(0xFFCB8589),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: 200.0,
                              width: 220.0,
                              child: ListTile(
                                title:
                                    Image(image: AssetImage("assets/book.png")),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(
                          "Evaluate",
                          style: textStyle.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Card(
                          color: Color(0xFFFE5D26),
                          elevation: 10.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 200.0,
                            width: 220.0,
                            child: ListTile(
                                title: Image(
                              image: AssetImage("assets/medical-results.png"),
                            )),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(
                          "Excel",
                          style: textStyle.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          color: Color(0xFF8D5A97),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 200.0,
                            width: 220.0,
                            child: ListTile(
                              title: Image(
                                  image: AssetImage("assets/quality.png")),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, FlashCardsPage.route()),
                              child: Card(
                  elevation: 18.0,
                  margin: EdgeInsets.all(10.0),
                  
                  child: Container(
                    color: Color(0xff57CC99),
                    height: 250,
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "View your flash Cards",
                          textAlign: TextAlign.center,
                          style:
                              textStyle.headline6.copyWith(color: Colors.white),
                        ),
                        Text(
                            "You can create your own flash cards to learn better and perform better in exams!\nThis App lets you do just that", textAlign: TextAlign.center,
                                        style: textStyle.bodyText1
                                            .copyWith(color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(children: [
                    Container(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, SubjectPage.route())
                                .then((value) => setState(() {}));
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.add, //color: Colors.white
                            ),
                            title: Text("Add more",
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
                                  .collection("Subjects")
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
                                        },
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (build) =>
                                                        SubjectPage(
                                                          preName: snapshot.data
                                                                  .docs[index]
                                                              ['SubjectName'],
                                                          preMarks: snapshot
                                                                  .data
                                                                  .docs[index]
                                                              ['SubjectMarks'],
                                                          preOutof: snapshot
                                                                  .data
                                                                  .docs[index][
                                                              'SubjectMarksOutOf'],
                                                          editIndex: index,
                                                          documents: snapshot
                                                              .data.docs[index],
                                                        ))).then(
                                                (value) => setState(() {}));
                                          },
                                          title: Text(snapshot
                                              .data.docs[index]['SubjectName']
                                              .toString()),
                                          subtitle: Text(
                                            "${snapshot.data.docs[index]['SubjectMarks'].toString()} / ${snapshot.data.docs[index]['SubjectMarksOutOf'].toString()}",
                                            style: textStyle.caption,
                                          ),
                                        ));
                                  },
                                );
                              })
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
