import 'package:flutter/material.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/screen/loan-details.dart';

class LoanListTable extends StatelessWidget {
  final List<LoanModel> loanList;

  LoanListTable(this.loanList);
  // var f =  NumberFormat("###.0#", "en_US");
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        margin: EdgeInsets.only(top: 10),
        child: //Padding(
            // padding: EdgeInsets.all(15),
            loanList == null
                ? Text(
                    "No loan found!",
                  )
                : ListView(
                    children: [
                      DataTable(
                        // border: TableBorder.all(),
                        columns: [
                          DataColumn(
                            numeric: true,
                            label: Text("Amount"),
                          ),
                          DataColumn(
                            numeric: true,
                            label: Text("Tenor"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                          // DataColumn(
                          //   label: Text("Remita"),
                          // )
                        ],
                        rows: []..addAll(
                            loanList
                                .map((loan) => DataRow(cells: [
                                      DataCell(Text(loan.amount.toString()),
                                          onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoanDetailScreen(loan)));
                                      }),
                                      DataCell(Text(loan.tenor.toString())),
                                      DataCell(Text(
                                        loan.paymentStatus.toUpperCase(),
                                        style: TextStyle(
                                            color: colorsMap[loan.paymentStatus
                                                .toLowerCase()]),
                                      )),
                                      // DataCell(loan.remita == null
                                      //     ? Text("NONE")
                                      //     : Text(loan.remita.activated
                                      //         ? "ACTIVE"
                                      //         : "PENDING"))
                                    ]))
                                .where((e) => e != null),
                          ),
                      ),
                    ],
                  ),
      ),
      // ),
    );
  }
}

/**
 * email: aremutade@gmail.com,
 * phone: 08133359229,
 * account_number: 2089084908,
 * bank_code: 011,
 * address: Some destination address,
 * state: Lagos,
 * gender: male,
 * date_of_birth: 1993-10-07,
 * marital_status: single,
 * number_of_children: 0,
 * number_of_dependent: 0,
 * national_id_type: international passport,
 * id_number: 90099900,
 * referrer_code: null,
 * profile_status: verified,
 * recipient_id: null,
 * mobile_app_user: false,
 * createdAt: 2019-12-19T13:10:33.000Z,
 * loan_requests:
 */
