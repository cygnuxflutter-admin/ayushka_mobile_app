import 'dart:convert';

EditEmployeeRequest editEmployeeRequestFromJson(String str) =>
    EditEmployeeRequest.fromJson(json.decode(str));

String editEmployeeRequestToJson(EditEmployeeRequest data) =>
    json.encode(data.toJson());

class EditEmployeeRequest {
  // final String empId;
  final String payrollName;
  final String category;
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

  EditEmployeeRequest({
    // required this.empId,
    required this.category,
    required this.payrollName,
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
  });

  factory EditEmployeeRequest.fromJson(Map<String, dynamic> json) =>
      EditEmployeeRequest(
        // empId: json["emp_id"],
        payrollName: json["payroll_name"],
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
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        // "emp_id": empId,
        "payroll_name": payrollName,
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
        "category": category,
      };
}
