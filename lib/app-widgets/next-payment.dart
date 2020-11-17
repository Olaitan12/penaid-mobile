import 'package:flutter/material.dart';
// import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';

// ignore: must_be_immutable
class NextPayment extends StatelessWidget {
  final List<LoanRepaymentSchedule> schedule;
  NextPayment(this.schedule);
  BuildContext _context;
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: []..addAll(
            schedule.map((e) => paymentCard(e)).where((e) => e != null),
          ),
      ),
    );
  }

  Widget paymentCard(LoanRepaymentSchedule payment) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: <Widget>[
            Row(children: [
              Text(
                "Next payment",
                style: Theme.of(_context).textTheme.headline5,
              ),
              payment != null
                  ? Text(
                      (payment.status),
                      style: TextStyle(color: colorsMap[payment.status]),
                    )
                  : Text("i")
            ]),
            Text(
              nairaFormat.format(payment.amount),
              style: TextStyle(
                  fontSize: 32,
                  height: 2,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(_context).primaryColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(payment.date) ?? "",
                  style: TextStyle(height: 2),
                ),
                Image.asset(
                  "assets/full-logo.png",
                  width: 32,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
