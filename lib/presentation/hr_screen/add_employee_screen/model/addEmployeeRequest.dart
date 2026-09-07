
import 'dart:convert';

AddEmployeeRequest addEmployeeRequestFromJson(String str) => AddEmployeeRequest.fromJson(json.decode(str));

String addEmployeeRequestToJson(AddEmployeeRequest data) => json.encode(data.toJson());

class AddEmployeeRequest {
  final String empId;
  final String joiningDate;
  final bool isEmpTemporary;
  final String payrollName;
  final String gender;
  final String adharName;
  final String parentSpouseName;
  final String relationship;
  final String dob;
  final String category;
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
  final List<SalaryDetails> salary;

  AddEmployeeRequest( {
    required this.empId,
    required this.joiningDate,
    required this.isEmpTemporary,
    required this.payrollName,
    required this.gender,
    required this.adharName,
    required this.parentSpouseName,
    required this.relationship,
    required this.dob,
    required this.category,
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
    required this.salary,
  });

  factory AddEmployeeRequest.fromJson(Map<String, dynamic> json) => AddEmployeeRequest(
    empId: json["emp_id"],
    joiningDate: json["joining_date"],
    payrollName: json["payroll_name"],
    gender: json["gender"],
    adharName: json["adhar_name"],
    parentSpouseName: json["parent_spouse_name"],
    relationship: json["relationship"],
    dob: json["dob"],
    category: json["category"],
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
    salary: List<SalaryDetails>.from(json["salary"].map((x) => SalaryDetails.fromJson(x))), isEmpTemporary: json["isEmpTemporary"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "joining_date": joiningDate,
    "payroll_name": payrollName,
    "gender": gender,
    "adhar_name": adharName,
    "parent_spouse_name": parentSpouseName,
    "relationship": relationship,
    "dob": dob,
    "category": category,
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
    "isEmpTemporary": isEmpTemporary,
    "salary": List<dynamic>.from(salary.map((x) => x.toJson())),
  };
}

class SalaryDetails {
  final String date;
  final int amountDecided;

  SalaryDetails({
    required this.date,
    required this.amountDecided,
  });

  factory SalaryDetails.fromJson(Map<String, dynamic> json) => SalaryDetails(
    date:json["date"],
    amountDecided: json["amountDecided"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "amountDecided": amountDecided,
  };
}
