import 'package:flutter/material.dart';
import 'package:penaid/screen/add-card.dart';

class CardManager extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CardSetup()));
                },
                child: Card(
                  color: Colors.orange[100],
                  elevation: 1.5,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.add_circle, color: Colors.green),
                        Text(
                          "Add new card",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text("Add a new card if we don't have your card details.\n" +
                            "If we don't have your card information it might cause a delay of "),
                      ],
                    ),
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CardSetup()));
              },
              child: Card(
                color: Colors.tealAccent[100],
                elevation: 2.5,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.update, color: Colors.green),
                      Text(
                        "Update existing card details",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                          "In case your old card gets missing, stolen, damaged or expired.\n" +
                              "Click to update with your new card details"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
