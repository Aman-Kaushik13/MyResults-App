import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:cool_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../settings_page.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key key}) : super(key: key);
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => ChartPage());

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final double cardHeight = 200;
  final double cardWidth = 180;

  // dynamic getData() {
  //   return Subject.subjects
  //       .map((e) => SalesData(
  //           e, double.parse(Subject.marks[Subject.subjects.indexOf(e)])))
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Subjects").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            dynamic getData() {
              return snapshot.data.docs
                  .map((e) => SalesData(
                      e['SubjectName'], double.parse(e['SubjectMarks'])))
                  .toList();
            }

            String average() {
              var sum = 0.0;

              for (var i = 0; i < snapshot.data.docs.length; i++) {
                sum += int.parse(snapshot.data.docs[i]['SubjectMarks']) /
                    snapshot.data.docs.length;
              }
              var answer = sum.round().toString();
              return answer + "%";
            }

            if (!snapshot.hasData) return Text("");

            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () =>
                          Navigator.push(context, SettingsPage.route()))
                ],
                leading: Text(" "),
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/progress.png"),
                  ),
                ),
                elevation: 0.0,
                toolbarHeight: 100,
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Color(0xff242423),
              body: snapshot.data.docs.length == 0
                  ? Text(
                      "Please put in your Subjects and your marks to Evaluate!!",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  : ListView(
                      children: [
                        Card(
                            elevation: 20.0,
                            child: Container(
                              color: Color(0xff57CC99),
                              height: 200,
                              width: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Motivation:",
                                      textAlign: TextAlign.left,
                                      style: textStyle.caption
                                          .copyWith(color: Colors.white)),
                                  Text(
                                    "Well Done!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  Text("Great job!",
                                      style: textStyle.bodyText1
                                          .copyWith(color: Colors.white)),
                                  Text(
                                      "The Algorithm predicts that you will be able to do better next time!",
                                      textAlign: TextAlign.center,
                                      style: textStyle.bodyText1
                                          .copyWith(color: Colors.white))
                                ],
                              ),
                            )),
                        Container(
                          height: 300,
                          child: SfCartesianChart(
                            trackballBehavior: TrackballBehavior(
                                enable: true,
                                // Display mode of trackball tooltip
                                tooltipDisplayMode:
                                    TrackballDisplayMode.floatAllPoints),
                            title: ChartTitle(
                                text: "Grades",
                                textStyle: textStyle.headline6
                                    .copyWith(color: Colors.white)),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              elevation: 30.0,
                              animationDuration: 2,
                            ),
                            primaryXAxis: CategoryAxis(),
                            series: <SplineSeries<SalesData, String>>[
                              SplineSeries<SalesData, String>(
                                  dataSource: getData(),
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  markerSettings:
                                      MarkerSettings(isVisible: true)),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          color: Color(0xFFFE5D26),
                          child: Container(
                            margin: EdgeInsets.all(18.0),
                            padding: EdgeInsets.all(20.0),
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Average Marks",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  average(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                height: 200,
                                width: 410,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Card(
                                        elevation: 10.0,
                                        child: Container(
                                          height: 250,
                                          width: 250,
                                          color: Color(0xFFE5D26),
                                          child: SfCircularChart(
                                            legend: Legend(
                                              isVisible: true,
                                              isResponsive: true,
                                            ),
                                            annotations: <
                                                CircularChartAnnotation>[
                                              CircularChartAnnotation(
                                                  widget: Container(
                                                    child: const Text(
                                                        'Empty data'),
                                                  ),
                                                  angle: 200,
                                                  radius: '90%'),
                                            ],
                                            backgroundColor: Colors.blueGrey,
                                            series: <CircularSeries>[
                                              PieSeries<SalesData, String>(
                                                  dataSource: getData(),
                                                  xValueMapper:
                                                      (SalesData data, _) =>
                                                          data.year,
                                                  yValueMapper:
                                                      (SalesData data, _) =>
                                                          data.sales,
                                                  // Radius for each segment from data source
                                                  pointRadiusMapper:
                                                      (SalesData data, _) =>
                                                          data.size)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 10.0,
                                        child: Container(
                                          height: 250,
                                          width: 250,
                                          color: Color(0xFFFE5D26),
                                          child: SfCircularChart(
                                            legend: Legend(
                                                isVisible: true,
                                                isResponsive: true),
                                            annotations: <
                                                CircularChartAnnotation>[
                                              CircularChartAnnotation(
                                                  widget: Container(
                                                    child: const Text(
                                                        'Empty data'),
                                                  ),
                                                  angle: 200,
                                                  radius: '90%'),
                                            ],
                                            backgroundColor: Colors.blueGrey,
                                            series: <CircularSeries>[
                                              DoughnutSeries<SalesData, String>(
                                                dataSource: getData(),
                                                xValueMapper:
                                                    (SalesData data, _) =>
                                                        data.year,
                                                yValueMapper:
                                                    (SalesData data, _) =>
                                                        data.sales,
                                                enableSmartLabels: true,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])),
                          ],
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SfCartesianChart(
                                  // Columns will be rendered back to back
                                  enableSideBySideSeriesPlacement: false,
                                  series: <ChartSeries>[
                                    ColumnSeries<SalesData, double>(
                                      dataSource: getData(),
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.sales,
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.sales,
                                    ),
                                  ]),
                              SfCartesianChart(
                                  // Columns will be rendered back to back
                                  enableSideBySideSeriesPlacement: false,
                                  series: <ChartSeries>[
                                    ColumnSeries<SalesData, double>(
                                        dataSource: getData(),
                                        xValueMapper: (SalesData sales, _) =>
                                            sales.sales,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.sales,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ]),
                              SfCartesianChart(series: <ChartSeries>[
                                BarSeries<SalesData, double>(
                                    dataSource: getData(),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.sales,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales,
                                    width: 0.6, // Width of the bars
                                    spacing: 0.3 // Spacing between the bars
                                    )
                              ])
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                                elevation: 30.0,
                                child: Container(
                                  color: Colors.blue[300],
                                  height: 300,
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Tip:",
                                          textAlign: TextAlign.left,
                                          style: textStyle.caption
                                              .copyWith(color: Colors.white)),
                                      Text(
                                          "You can use Flash Cards to learn better and score more!\n you can use this app to make Flash cards and achieve better grades!",
                                          textAlign: TextAlign.center,
                                          style: textStyle.bodyText1
                                              .copyWith(color: Colors.white))
                                    ],
                                  ),
                                )),
                            Card(
                                child: Container(
                              color: Color(0xff57CC99),
                              height: 280,
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Info:",
                                      textAlign: TextAlign.left,
                                      style: textStyle.caption
                                          .copyWith(color: Colors.white)),
                                  Text("You scored the most in Maths",
                                      textAlign: TextAlign.center,
                                      style: textStyle.bodyText1
                                          .copyWith(color: Colors.white))
                                ],
                              ),
                            )),
                          ],
                        ),
                        Container(
                          height: 400,
                          width: 500,
                          color: Color(0xff242423),
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 40.0, left: 20.0),
                                      child: Text(
                                        snapshot.data.docs[index]
                                            ['SubjectName'],
                                        style: textStyle.headline5
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    foregroundPainter: MarksPainter(
                                      marks: snapshot.data.docs,
                                            index: index
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SfCartesianChart(
                            plotAreaBackgroundColor: Color(0xff57CC99),
                            series: <ChartSeries>[
                              // Renders bubble chart
                              BubbleSeries<SalesData, double>(
                                dataSource: getData(),
                                sizeValueMapper: (SalesData sales, _) =>
                                    sales.size,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                              )
                            ]),
                        SfCartesianChart(series: <ChartSeries>[
                          SplineAreaSeries<SalesData, double>(
                              dataSource: getData(),
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              xValueMapper: (SalesData sales, _) => sales.sales)
                        ]),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          height: 250,
                          width: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/logo.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 500,
                        )
                      ],
                    ),
            );
          }),
    );
  }
}
