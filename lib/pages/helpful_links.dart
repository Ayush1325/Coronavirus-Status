import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpfulLinks extends StatelessWidget {
  final links = [
    ["COVID-19 Global Tracker", "https://coronavirus.thebaselab.com/"],
    ["Ministry of Health and Family Welfare", "https://www.mohfw.gov.in/"],
    ["COVID-19 Indian Tracker Web", "https://www.covid19india.org/"],
    ["COVID-19 India API", "https://api.covid19india.org/"],
    [
      "WHO : COVID-19 Home Page",
      "https://www.who.int/emergencies/diseases/novel-coronavirus-2019"
    ],
    ["CDC", "https://www.cdc.gov/coronavirus/2019-ncov/faq.html"]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpful Links"),
      ),
      drawer: NavDrawer(),
      body: ListView.builder(
        itemCount: links.length,
        itemBuilder: (context, index) => FlatButton(
          child: Text(
            links[index][0],
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            _launchURL(links[index][1]);
          },
        ),
      ),
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
