import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_project/pages/Flash_Card/flash_card_page.dart';
import 'package:flutter/material.dart';

class FlashCardsPage extends StatelessWidget {
  const FlashCardsPage({Key key}) : super(key: key);
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => FlashCardsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Flash Cards",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff57CC99),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Color(0xff57CC99),
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context, FlashCardEditPage.route()),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("FlashCards").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return const Text(
                    "You don't have any Flash Cards yet\n click the + Icon to add some!");
              return ListWheelScrollView.useDelegate(
                  itemExtent: 250,
                  useMagnifier: true,
                  perspective: 0.001,
                  magnification: 1.2,
                  renderChildrenOutsideViewport: true,
                  clipBehavior: Clip.none,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: snapshot.data.docs.length,
                    builder: (context, index) {
                      return Container(
                        width: 450,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff57CC99),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                snapshot.data.docs[index]['CardContent'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "Answer: ${snapshot.data.docs[index]['CardAnswer']}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ));
            }));
  }
}
