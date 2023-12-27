import 'package:flutter/material.dart';
import 'package:health/Resources/AppBar/app_bar.dart';
import 'package:health/Resources/Search_bar/search_bar.dart';

class UserPackages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              MySearchBar(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Packages",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildListTile("تحلیل صورتہ الدم  ", "ابتدا من 60 ریال", Icons.science_outlined),
                    buildListTile("فحص فیتامین ب 12", "ابتدا من 120 ریال", Icons.science_outlined),
                    buildListTile("فحص الحرمون", "ابتدا من 180 ریال", Icons.science_outlined),
                    buildListTile("تحلیل السکر التراکمی", "ابتدا من 60 ریال", Icons.science_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        contentPadding: EdgeInsets.all(10),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(icon, color: Colors.black),
        tileColor: Colors.lightBlue.shade50,
      ),
    );
  }
}

