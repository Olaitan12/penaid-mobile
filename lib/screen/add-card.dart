import 'package:flutter/material.dart';

class CardSetup extends StatefulWidget {
  _CardSetup createState() => _CardSetup();
}

class _CardSetup extends State<CardSetup> {
  TextEditingController cvv = TextEditingController();
  TextEditingController expiryMonth = TextEditingController();
  TextEditingController expiryYear = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card setup"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: cardNumber,
              decoration: InputDecoration(
                labelText: "Card number",
                hintText: "0000 0000 0000 0000",
                prefixIcon:
                    ImageIcon(AssetImage("assets/icons/card/card-number.png")),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: TextFormField(
                      controller: expiryMonth,
                      decoration: InputDecoration(
                          labelText: "Month",
                          hintText: "09",
                          prefixIcon: Icon(Icons.date_range)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: TextFormField(
                      controller: expiryYear,
                      decoration: InputDecoration(
                          labelText: "Year",
                          hintText: "20",
                          prefixIcon: Icon(Icons.date_range)),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextFormField(
                        controller: cvv,
                        decoration: InputDecoration(
                          hintText: "000",
                          labelText: "cvv",
                          prefixIcon: ImageIcon(
                              AssetImage(
                                "assets/icons/card/cvv.png",
                              ),
                              size: 12),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: pin,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Card pin",
                    labelText: "PIN",
                    prefixIcon: Icon(Icons.lock_outline)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Submit"),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
