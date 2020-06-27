import 'package:flutter/material.dart';

class DashboardHomeView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Balance",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "N34,000.00",
                      style: TextStyle(
                          fontSize: 32,
                          height: 2,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Client Name",
                          style: TextStyle(height: 2),
                        ),
                        Image.asset(
                          "assets/full-logo.png",
                          width: 32,
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}