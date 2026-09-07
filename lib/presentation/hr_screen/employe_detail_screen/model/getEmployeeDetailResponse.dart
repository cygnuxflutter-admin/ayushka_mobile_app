
import 'dart:convert';

GetEmployeeDetailResponse getEmployeeDetailResponseFromJson(String str) => GetEmployeeDetailResponse.fromJson(json.decode(str));

String getEmployeeDetailResponseToJson(GetEmployeeDetailResponse data) => json.encode(data.toJson());

SingleEmployeeDetail singleEmployeeDetailFromJson(String str) =>
    SingleEmployeeDetail.fromJson(json.decode(str));

String singleEmployeeDetailToJson(SingleEmployeeDetail data) =>
    json.encode(data.toJson());


class GetEmployeeDetailResponse {
  final String status;
  final String message;
  final SingleEmployeeDetail singleEmployeeDetail;

  GetEmployeeDetailResponse({
    required this.status,
    required this.message,
    required this.singleEmployeeDetail,
  });

  factory GetEmployeeDetailResponse.fromJson(Map<String, dynamic> json) => GetEmployeeDetailResponse(
    status: json["status"],
    message: json["message"],
    singleEmployeeDetail: SingleEmployeeDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "SingleEmployeeDetail": singleEmployeeDetail.toJson(),
  };
}

class SingleEmployeeDetail {
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
  final List<EmpDetailSalary> salary;
  final String category;
  final String id;

  SingleEmployeeDetail({
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
    required this.category,
    required this.id,
  });

  factory SingleEmployeeDetail.fromJson(Map<String, dynamic> json) => SingleEmployeeDetail(
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
    updatedAt:json["updatedAt"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    gaushalaId: json["gaushala_id"],
    salary: List<EmpDetailSalary>.from(json["salary"].map((x) => EmpDetailSalary.fromJson(x))),
    category: json["category"],
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
    "category": category,
    "id": id,
  };
   EmpDetailSalary salaryInfo({required List<EmpDetailSalary> empSalary}) {
    List<EmpDetailSalary> sortedList = List.from(empSalary);
    sortedList.sort((a, b) => b.date.compareTo(a.date));
    return sortedList[0];
  }
}

class EmpDetailSalary {
  final String id;
  final String date;
  final int amountDecided;
  final String salaryId;

  EmpDetailSalary({
    required this.id,
    required this.date,
    required this.amountDecided,
    required this.salaryId,
  });

  factory EmpDetailSalary.fromJson(Map<String, dynamic> json) => EmpDetailSalary(
    id: json["_id"],
    date: json["date"],
    amountDecided: json["amountDecided"],
    salaryId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date,
    "amountDecided": amountDecided,
    "id": salaryId,
  };


}


