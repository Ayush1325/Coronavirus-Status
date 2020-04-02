import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      drawer: NavDrawer(),
      body: ListView(padding: EdgeInsets.all(10), children: [
        RichText(
          text: TextSpan(
              text: "About this app",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              children: [
                TextSpan(
                    text:
                        "\nThis app uses the same api as the COVID-19 website given in helpful links. I created it because I just wanted an app.",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )),
                TextSpan(
                    text:
                        "\nIt is influenced heavily by the website so please check it out. This app still lacks some functionality compared to the site but should be sufficient for most people.",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )),
              ]),
        ),
      ]),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
