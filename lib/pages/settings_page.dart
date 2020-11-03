// import 'package:cool_project/pages/tabPages/theme/dark_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_project/pages/tabPages/models/model.dart';
import 'package:cool_project/pages/tabPages/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => SettingsPage());

  static bool darkTheme = false;
  static bool selected = true;
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [Image(image: AssetImage("assets/settings.png"))],
        title: Text("Settings",
            style: textStyle.headline5.copyWith(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: FlatButton(
            textColor: Color(0xFF242423),
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ListTile(
                // tileColor: Color(0xFFE8EDDF),
                title: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Customize your UI",
                          style:
                              textStyle.headline5.copyWith(color: Colors.blue),
                        ),
                        Text(
                          "Change the mode",
                          style:
                              textStyle.headline6.copyWith(color: Colors.blue),
                        ),
                        Text("Many options!",
                            style: TextStyle(color: Colors.blueAccent)),
                      ]),
                ),
              ),
            ),
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
            StreamBuilder<QuerySnapshot>(
                stream: DarkTheme.collectionReference.snapshots(),
                builder: (context, snapshot) {
                  return ListTile(
                    title: Text("Dark mode"),
                    trailing: LiteRollingSwitch(
                        textOn: "",
                        textOff: "",
                        value: snapshot.data.docs[0]['darkTheme'],
                        onChanged: (val) {
                          if (snapshot.data.docs[0]['darkTheme'] == false) {
                            _themeChanger.setTheme(ThemeData.dark());
                          }
                          if (snapshot.data.docs[0]['darkTheme'] == true) {
                            _themeChanger.setTheme(ThemeData.light());
                          }
                          snapshot.data.docs[0].reference.updateData({
                            'darkTheme': val,
                          });
                        }),
                  );
                }),
            // ListTile(
            //   contentPadding: EdgeInsets.all(10.0),
            //   title: Text("Color themes", style: textStyle.headline6.copyWith(color: Colors.grey[300]),),
            //   tileColor: Colors.grey[600],
            // ),
            ListTile(
              selected: selected,
              title: Text("Recieve Notifications"),
              trailing: LiteRollingSwitch(
                textOn: "",
                textOff: "",
                onChanged: (value) => selected = value,
              ),
            ),
            ListTile(
              title: Text("About"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "MyResults App",
                  applicationIcon: Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/logo.png",
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),

            Card(
              elevation: 40.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 200,
                width: 200,
                child: Column(
                  children: [
                    Text(
                      "Support",
                      style: textStyle.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:
                          Text("support@gmail.com", textAlign: TextAlign.left),
                    ),
                    Text(
                      "MyResults/twitter.com",
                      style: textStyle.bodyText2,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "MyResults.com",
                      style: textStyle.bodyText2,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
