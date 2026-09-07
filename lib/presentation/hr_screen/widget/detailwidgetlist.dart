import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/hr_screen/employe_detail_screen/model/getEmployeeDetailResponse.dart';

class DetailWidgetList extends StatelessWidget {
  const DetailWidgetList({required this.employeeDetail});

  final SingleEmployeeDetail employeeDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: ColorConstant.orange300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PERSONAL DETAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.addEmployeeScreen,
                            arguments: "PERSONAL",
                            parameters: {
                              'employeeDetail':
                                  singleEmployeeDetailToJson(employeeDetail)
                            },
                          );
                        },
                        child: Image(
                          image: AssetImage(ImageConstant.editIcon),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.grey, thickness: 1),
                DetailWidget(
                  firstText: "Name",
                  secondText: employeeDetail.payrollName,
                ),
                DetailWidget(
                  firstText: "Gender",
                  secondText: employeeDetail.gender,
                ),
                DetailWidget(
                  firstText: "Dob",
                  secondText: convertDateFormat(date: employeeDetail.dob),
                ),
                DetailWidget(
                  firstText: "Parent Name",
                  secondText: employeeDetail.parentSpouseName,
                ),
                DetailWidget(
                  firstText: "Relation",
                  secondText: employeeDetail.relationship,
                ),
                DetailWidget(
                  firstText: "Mobile No",
                  secondText: employeeDetail.mobileNumber.toString(),
                ),
                DetailWidget(
                  firstText: "Aadhaar No",
                  secondText: employeeDetail.adharNumber,
                ),
                DetailWidget(
                  firstText: "Aadhaar Name",
                  secondText: employeeDetail.adharName,
                ),
                DetailWidget(
                  firstText: "Pan No",
                  secondText: employeeDetail.panCard,
                ),
                DetailWidget(
                  firstText: "Category",
                  secondText: employeeDetail.category,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: ColorConstant.orange300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BANK DETAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.addEmployeeScreen,
                            arguments: "BANK",
                            parameters: {
                              'employeeDetail':
                                  singleEmployeeDetailToJson(employeeDetail)
                            },
                          );
                        },
                        child: Image(
                          image: AssetImage(ImageConstant.editIcon),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.grey, thickness: 1),
                DetailWidget(
                  firstText: "Bank Account No",
                  secondText: employeeDetail.bankAccount.toString(),
                ),
                DetailWidget(
                  firstText: "Bank Name",
                  secondText: employeeDetail.bankName,
                ),
                DetailWidget(
                  firstText: "IFSC Code",
                  secondText: employeeDetail.ifscCode,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: ColorConstant.orange300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SALARY DETAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.addEmployeeScreen,
                            arguments: "SALARY",
                            parameters: {
                              'employeeDetail':
                              singleEmployeeDetailToJson(employeeDetail)
                            },
                          );
                        },
                        child: Image(
                          image: AssetImage(ImageConstant.editIcon),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.grey, thickness: 1),
                DetailWidget(
                  firstText: "Date",
                  secondText: convertDateFormat(date: employeeDetail.salaryInfo(empSalary: employeeDetail.salary).date),
                ),
                DetailWidget(
                  firstText: "Salary Amount",
                  secondText:"${employeeDetail.salaryInfo(empSalary: employeeDetail.salary).amountDecided}",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: ColorConstant.orange300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OTHER DETAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.addEmployeeScreen,
                            arguments: "OTHER",
                            parameters: {
                              'employeeDetail':
                                  singleEmployeeDetailToJson(employeeDetail)
                            },
                          );
                        },
                        child: Image(
                          image: AssetImage(ImageConstant.editIcon),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0, color: Colors.grey, thickness: 1),
                DetailWidget(
                  firstText: "Joining Date",
                  secondText: convertDateFormat(date: employeeDetail.joiningDate),
                ),
                DetailWidget(
                  firstText: "UAN No",
                  secondText: employeeDetail.uanNo.toString(),
                ),
                DetailWidget(
                  firstText: "PF No",
                  secondText: employeeDetail.pfNo,
                ),
                DetailWidget(
                  firstText: "ESI No",
                  secondText: employeeDetail.esiNo,
                ),
                DetailWidget(
                  firstText: "Remark",
                  secondText: employeeDetail.remark,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // List<EmpDetailSalary> salaryInfo({required List<EmpDetailSalary> empSalary}) {
  //   List<EmpDetailSalary> sortedList = List.from(empSalary);
  //   sortedList.sort((a, b) => b.date.compareTo(a.date));
  //   return sortedList;
  // }

  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);

    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);

    return formattedDate;
  }

}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            firstText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            secondText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorConstant.blueGray9007f,
            ),
          ),
        ],
      ),
    );
  }
}
