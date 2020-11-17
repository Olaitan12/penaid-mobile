import 'package:flutter/material.dart';

class UserModel {
  // final List<LoanModel> loans;
  final List<LoanModel> loans;
  final String email;
  final String phoneNumber;
  final String accountNumber;
  final String bankCode;
  final String address;
  final String stateOfResisdence;
  final String gender;
  final String dateOfBirth;
  final String nationalIdType;
  final String nationalIdNumber;
  final String referrerCode;
  final RetirementDetails retirement;
  final EmployerDetails employer;
  final NextOfKinDetails nextOfKin;
  final CardDetails card;
  UserModel(
    this.loans,
    this.email,
    this.phoneNumber,
    this.accountNumber,
    this.address,
    this.bankCode,
    this.dateOfBirth,
    this.gender,
    this.nationalIdNumber,
    this.nationalIdType,
    this.referrerCode,
    this.stateOfResisdence,
    this.nextOfKin,
    this.employer,
    this.retirement,
    this.card,
  );
  factory UserModel.fromJson(dynamic json) {
    try {
      return UserModel(
        LoanModel.list(json["loan_requests"]),
        json["email"] as String ?? "",
        json["phone"] as String ?? "",
        json["account_number"] as String ?? "",
        json["address"] as String ?? "",
        json["bank_code"] as String ?? "",
        json["date_of_birth"] as String ?? "",
        json["gender"] as String ?? "",
        json["id_number"] as String ?? "",
        json["national_id_type"] as String ?? "",
        json["referrer_code"] as String ?? "",
        json["state"] as String ?? "",
        NextOfKinDetails.fromJson(json["next_of_kin"]),
        EmployerDetails.fromJson(json["employment_history"]),
        RetirementDetails.fromJson(json["retirement_program"]),
        CardDetails.fromJson(json["card_authorization"]),
      );
    } catch (e) {
      debugPrint("User Model");
      debugPrint(e.toString());
      return null;
    }
  }
}

class LoanModel {
  final String status;
  final String paymentStatus;
  final bool disbursed;
  final DateTime disburseDate;
  final DateTime requestDate;
  final String purpose;
  final String purposeDescription;
  final double amount;
  final int loanId;
  final int tenor;
  final List<LoanRepaymentSchedule> loanRepaymentSchedules;
  final RemitaMandate remita;

  // bool get isNull => LoanModel == null ;

  LoanModel(
      this.loanId,
      this.tenor,
      this.amount,
      this.status,
      this.paymentStatus,
      this.requestDate,
      this.disburseDate,
      this.disbursed,
      this.purpose,
      this.purposeDescription,
      this.loanRepaymentSchedules,
      this.remita);
  factory LoanModel.fromJson(dynamic json) {
    try {
      return json == null
          ? null
          : LoanModel(
              json["loan_request_id"] as int,
              json["tenor"] as int,
              double.parse(json["amount"].toString() ?? "1.0"),
              json["status"] as String ?? "",
              json["payment_status"] as String ?? "",
              DateTime.parse(json["createdAt"] ?? "1949-02-27"),
              DateTime.parse(json["disburse_date"] ?? "1949-02-27"),
              json["disbursed"] as bool,
              json["purpose"] as String ?? "",
              json["description"] as String ?? "",
              LoanRepaymentSchedule.list(json["loan_schedules"]),
              RemitaMandate.fromJson(json["remita_authorization"]));
    } catch (e) {
      debugPrint("Loan Model");
      debugPrint(e.toString());
      return null;
    }
  }
  static List<LoanModel> list(List<dynamic> list) {
    return list.map((row) => LoanModel.fromJson(row)).toList();
  }
}

class LoanRepaymentSchedule {
  final int scheduleId;
  final int loanRequestId;
  final double amount;
  final String status;
  final DateTime date;
  LoanRepaymentSchedule(
      this.scheduleId, this.loanRequestId, this.amount, this.status, this.date);
  factory LoanRepaymentSchedule.fromJson(dynamic json) {
    try {
      return json == null
          ? null
          : LoanRepaymentSchedule(
              json["loan_schedule_id"] as int,
              json["loan_request_id"] as int,
              double.tryParse(json["amount"].toString() ?? "1.0"),
              json["status"] as String ?? "",
              DateTime.parse(json["date"]));
    } catch (e) {
      debugPrint("Loan repayment model");
      debugPrint(e.toString());
      return null;
    }
  }
  static List<LoanRepaymentSchedule> list(List<dynamic> list) {
    return list.map((row) => LoanRepaymentSchedule.fromJson(row)).toList();
  }
}

class RemitaMandate {
  final int loanRequestId;
  final String mandateId;
  final String requestId;
  final String startDate;
  final String endDate;
  final String activationDate;
  final bool activated;
  final double amount;
  RemitaMandate(this.loanRequestId, this.mandateId, this.requestId, this.amount,
      this.activated, this.startDate, this.endDate, this.activationDate);

  factory RemitaMandate.fromJson(dynamic json) {
    try {
      debugPrint(json.toString());
      return json == null
          ? null
          : RemitaMandate(
              json["loan_request_id"] as int,
              json["mandate_id"] as String,
              json["request_id"] as String,
              double.tryParse(json["amount"]),
              json["activated"] as bool,
              json["start_date"] as String,
              json["end_date"] as String,
              json["activation_date"] as String,
            );
    } catch (e) {
      debugPrint("Remita model");
      debugPrint(e.toString());
      return null;
    }
  }
  static List<RemitaMandate> list(List<dynamic> list) {
    return list.map((row) => RemitaMandate.fromJson(row)).toList();
  }
}

class RetirementDetails {
  final int retirementYear;
  final String pensionPlan;
  final double monthlyPension;
  get runtimeType => RetirementDetails;

  RetirementDetails(this.monthlyPension, this.pensionPlan, this.retirementYear);

  factory RetirementDetails.fromJson(dynamic json) {
    debugPrint(json.toString());
    return json == null
        ? null
        : RetirementDetails(
            double.parse(json["monthly_payment"].toString()),
            json["plan"] as String,
            int.parse(json["year_of_retirement"].toString()));
  }
}

class EmployerDetails {
  final String employerName;
  final String industry;
  final int yearsOfService;
  final String lastJobTitle;
  final String sector;
  get runtimeType => EmployerDetails;

  EmployerDetails(
    this.employerName,
    this.industry,
    this.sector,
    this.lastJobTitle,
    this.yearsOfService,
  );

  factory EmployerDetails.fromJson(dynamic json) {
    debugPrint(json.toString());
    return json == null
        ? null
        : EmployerDetails(
            json["employer_name"] as String,
            json["industry"] as String,
            json["sector"] as String,
            json["job_title"] as String,
            json["years_of_service"] as int,
          );
  }
}

class NextOfKinDetails {
  final String surname;
  final String firstName;
  final String phoneNumber;
  final String address;
  final String relationship;
  get runtimeType => NextOfKinDetails;

  NextOfKinDetails(this.surname, this.firstName, this.relationship,
      this.phoneNumber, this.address);

  factory NextOfKinDetails.fromJson(dynamic json) {
    debugPrint(json.toString());
    return json == null
        ? null
        : NextOfKinDetails(
            json["surname"] as String,
            json["firstname"] as String,
            json["relationship"] as String,
            json["phone_number"] as String,
            json["address"] as String,
          );
  }
}

class CardDetails {
  final int last4;
  final String expiryMonth;
  final String expiryYear;
  final String bank;
  final String brand;

  CardDetails(
      this.last4, this.bank, this.expiryMonth, this.expiryYear, this.brand);
  get runtimeType => CardDetails;
  factory CardDetails.fromJson(dynamic json) {
    debugPrint(json.toString());
    return json == null
        ? null
        : CardDetails(
            json["last4"] as int,
            json["bank"].toString(),
            json["exp_month"].toString(),
            json["exp_year"].toString(),
            json["brand"].toString(),
          );
  }
}
