import 'package:flutter/material.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';

class LoanDetailScreen extends StatelessWidget {
  final LoanModel loan;
  LoanDetailScreen(this.loan);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan details"),
      ),
      body: Container(
        color: BACKGROUND_COLOR,
        child: ListView(
          children: [
            Card(
              color: Colors.orange,
              child: Column(
                children: [
                  Text(
                    "Loan Amount",
                    style: TextStyle(height: 2),
                  ),
                  Text(
                    // NAIRA + loan.amount.toString(),
                    nairaFormat.format(loan.amount),
                    style: TextStyle(
                        fontSize: 30, height: 2, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Repayment term (months)",
                    style: TextStyle(height: 3),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    // color: Colors.black,
                    child: Center(child: Text(loan.tenor.toString())),
                  )
                ],
              ),
            ),
            Text(
              "  Repayment Schedule",
              style: TextStyle(height: 2, fontWeight: FontWeight.w300),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              color: Colors.white,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Amount")),
                  DataColumn(label: Text("Due date")),
                  DataColumn(label: Text("Status"))
                ],
                rows: []..addAll(
                    loan.loanRepaymentSchedules
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(Text(nairaFormat.format(e.amount))),
                              DataCell(Text(dateFormat.format(e.date))),
                              DataCell(Text(
                                e.status.toUpperCase(),
                                style: TextStyle(
                                  color: colorsMap[e.status],
                                ),
                              )),
                            ],
                          ),
                        )
                        .where((e) => e != null),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
