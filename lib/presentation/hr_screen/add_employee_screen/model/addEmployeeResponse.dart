import 'dart:convert';

AddEmployeeResponse addEmployeeResponseFromJson(String str) => AddEmployeeResponse.fromJson(json.decode(str));

String addEmployeeResponseToJson(AddEmployeeResponse data) => json.encode(data.toJson());

class AddEmployeeResponse {
  final String status;
  final String message;
  final AddEmployeeData addEmployeeData;

  AddEmployeeResponse({
    required this.status,
    required this.message,
    required this.addEmployeeData,
  });

  factory AddEmployeeResponse.fromJson(Map<String, dynamic> json) => AddEmployeeResponse(
    status: json["status"],
    message: json["message"],
    addEmployeeData: AddEmployeeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "AddEmployeeData": addEmployeeData.toJson(),
  };
}

class AddEmployeeData {
  final String empId;
  final String gaushalaId;
  final bool isEmpTemporary;
  final String payrollName;
  final String joiningDate;
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
  final List<Salary> salary;
  final bool isDeleted;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String id;

  AddEmployeeData({
    required this.empId,
    required this.gaushalaId,
    required this.isEmpTemporary,
    required this.payrollName,
    required this.joiningDate,
    required this.category,
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
    required this.salary,
    required this.isDeleted,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory AddEmployeeData.fromJson(Map<String, dynamic> json) => AddEmployeeData(
    empId: json["emp_id"],
    gaushalaId: json["gaushala_id"],
    payrollName: json["payroll_name"],
    isEmpTemporary: json["isEmpTemporary"],
    joiningDate: json["joining_date"],
    category: json["category"],
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
    salary: List<Salary>.from(json["salary"].map((x) => Salary.fromJson(x))),
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    updatedAt:json["updatedAt"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "gaushala_id": gaushalaId,
    "isEmpTemporary": isEmpTemporary,
    "payroll_name": payrollName,
    "joining_date": joiningDate,
    "category": category,
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
    "salary": List<dynamic>.from(salary.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "id": id,
  };
}

class Salary {
  final DateTime date;
  final int amountDecided;
  final String id;
  final String salaryId;

  Salary({
    required this.date,
    required this.amountDecided,
    required this.id,
    required this.salaryId,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    date: DateTime.parse(json["date"]),
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
