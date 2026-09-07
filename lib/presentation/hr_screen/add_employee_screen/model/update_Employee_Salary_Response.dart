import 'package:meta/meta.dart';
import 'dart:convert';

UpdateEmployeeSalaryResponse updateEmployeeSalaryResponseFromJson(String str) => UpdateEmployeeSalaryResponse.fromJson(json.decode(str));

String updateEmployeeSalaryResponseToJson(UpdateEmployeeSalaryResponse data) => json.encode(data.toJson());

class UpdateEmployeeSalaryResponse {
  final String status;
  final String message;
  final UpdateEmployeeSalaryData updateEmployeeSalaryData;

  UpdateEmployeeSalaryResponse({
    required this.status,
    required this.message,
    required this.updateEmployeeSalaryData,
  });

  factory UpdateEmployeeSalaryResponse.fromJson(Map<String, dynamic> json) => UpdateEmployeeSalaryResponse(
    status: json["status"],
    message: json["message"],
    updateEmployeeSalaryData: UpdateEmployeeSalaryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "updateEmployeeSalaryData": updateEmployeeSalaryData.toJson(),
  };
}

class UpdateEmployeeSalaryData {
  final String empId;
  final String payrollName;
  final String joiningDate;
  final String gender;
  final String adharName;
  final String parentSpouseName;
  final String relationship;
  final String dob;
  final String adharNumber;
  final String panCard;
  final int bankAccount;
  final String bankName;
  final String ifscCode;
  final int mobileNumber;
  final int uanNo;
  final String remark;
  final String pfNo;
  final String esiNo;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String gaushalaId;
  final List<upDateSalaryDetials> salary;
  final String id;

  UpdateEmployeeSalaryData({
    required this.empId,
    required this.payrollName,
    required this.joiningDate,
    required this.gender,
    required this.adharName,
    required this.parentSpouseName,
    required this.relationship,
    required this.dob,
    required this.adharNumber,
    required this.panCard,
    required this.bankAccount,
    required this.bankName,
    required this.ifscCode,
    required this.mobileNumber,
    required this.uanNo,
    required this.remark,
    required this.pfNo,
    required this.esiNo,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isActive,
    required this.gaushalaId,
    required this.salary,
    required this.id,
  });

  factory UpdateEmployeeSalaryData.fromJson(Map<String, dynamic> json) => UpdateEmployeeSalaryData(
    empId: json["emp_id"],
    payrollName: json["payroll_name"],
    joiningDate: json["joining_date"],
    gender: json["gender"],
    adharName: json["adhar_name"],
    parentSpouseName: json["parent_spouse_name"],
    relationship: json["relationship"],
    dob: json["dob"],
    adharNumber: json["adhar_number"],
    panCard: json["pan_card"],
    bankAccount: json["bank_account"],
    bankName: json["bank_name"],
    ifscCode: json["IFSC_code"],
    mobileNumber: json["mobile_number"],
    uanNo: json["UAN_no"],
    remark: json["remark"],
    pfNo: json["PF_no"],
    esiNo: json["ESI_no"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    gaushalaId: json["gaushala_id"],
    salary: List<upDateSalaryDetials>.from(json["salary"].map((x) => upDateSalaryDetials.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "payroll_name": payrollName,
    "joining_date": joiningDate,
    "gender": gender,
    "adhar_name": adharName,
    "parent_spouse_name": parentSpouseName,
    "relationship": relationship,
    "dob": dob,
    "adhar_number": adharNumber,
    "pan_card": panCard,
    "bank_account": bankAccount,
    "bank_name": bankName,
    "IFSC_code": ifscCode,
    "mobile_number": mobileNumber,
    "UAN_no": uanNo,
    "remark": remark,
    "PF_no": pfNo,
    "ESI_no": esiNo,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "gaushala_id": gaushalaId,
    "salary": List<dynamic>.from(salary.map((x) => x.toJson())),
    "id": id,
  };
}

class upDateSalaryDetials {
  final String date;
  final int amountDecided;
  final String id;
  final String salaryId;

  upDateSalaryDetials({
    required this.date,
    required this.amountDecided,
    required this.id,
    required this.salaryId,
  });

  factory upDateSalaryDetials.fromJson(Map<String, dynamic> json) => upDateSalaryDetials(
    date:json["date"],
    amountDecided: json["amountDecided"],
    id: json["_id"],
    salaryId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "amountDecided": amountDecided,
    "_id": id,
    "id": salaryId,
  };
}
