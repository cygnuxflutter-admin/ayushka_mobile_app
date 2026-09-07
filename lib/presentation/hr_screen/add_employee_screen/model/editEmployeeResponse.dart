import 'dart:convert';

EditEmployeeResponse editEmployeeResponseFromJson(String str) =>
    EditEmployeeResponse.fromJson(json.decode(str));

String editEmployeeResponseToJson(EditEmployeeResponse data) =>
    json.encode(data.toJson());

class EditEmployeeResponse {
  final String status;
  final String message;
  final Data data;

  EditEmployeeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditEmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EditEmployeeResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
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
  final String category;
  final String createdAt;
  final String updatedAt;
  final bool isDeleted;
  final bool isActive;
  final String id;

  Data({
    required this.empId,
    required this.category,
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
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        empId: json["emp_id"],
        category: json["category"],
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
        "id": id,
        "category": category,
      };
}
