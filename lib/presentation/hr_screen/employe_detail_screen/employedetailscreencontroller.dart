import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:cattle_app/data/apiClient/api_client.dart';
import 'package:cattle_app/data/apiClient/api_methods.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../widgets/loder.dart';
import '../hr_screen_controller.dart';
import 'model/getEmployeeDetailResponse.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

enum DataStatus { loading, done, error }

class EmployeeDetailScreenController extends GetxController {
  HrScreenController hrScreenController = Get.put(HrScreenController());

  SingleEmployeeDetail? singleEmployeeDetail;

  Rx<DataStatus> dataStatus = DataStatus.loading.obs;

  String? Title;

  String? employeeID;

  @override
  void onInit() {
    employeeID = Get.arguments;
    cmGetEmployeeDetailApi(id: employeeID!);
    super.onInit();
  }

  Future<void> cmGetEmployeeDetailApi({required String id}) async {
    try {
      final Response response = await WebService.cmGetRequestWithToken(
          url: "${ApiClient.getEmployeeDetail}${id}",
          token: PrefUtils.getToken.toString(),
          body: '');
      if (response.statusCode == 200) {
        GetEmployeeDetailResponse getEmployeeDetailResponse =
            getEmployeeDetailResponseFromJson(response.data);
        if (getEmployeeDetailResponse.status == "SUCCESS") {
          singleEmployeeDetail = getEmployeeDetailResponse.singleEmployeeDetail;
          Title = "${singleEmployeeDetail!.empId}";
          changeStatus(DataStatus.done);
        } else {
          print(getEmployeeDetailResponse.status);
          changeStatus(DataStatus.error);
        }
      } else {
        print(response.statusCode);
        changeStatus(DataStatus.error);
      }
    } catch (e) {
      print(e);
      changeStatus(DataStatus.error);
    }
  }

  void checkAddData() {
    AppLoader().show();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLoader().hide();
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("PRINT"),
            content: Container(
              height: 500,
              width: 500,
              child: PdfPreview(
                build: (format) => generatePdf(),
                initialPageFormat: PdfPageFormat.a4,
              ),
            ),
          );
        },
      );
    });
  }

  Future<Uint8List> generatePdf() async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  empDetailsPrintView(label: 'EMP ID : ', value: '${singleEmployeeDetail!.empId}'),
                  empDetailsPrintView(label: 'Name : ', value: '${singleEmployeeDetail!.payrollName}'),
                  empDetailsPrintView(label: 'Gender : ', value: '${singleEmployeeDetail!.gender}'),
                  empDetailsPrintView(label: 'Dob : ', value: '${convertDateFormat(date:singleEmployeeDetail!.dob)}'),
                  empDetailsPrintView(label: 'Parent Name : ', value: '${singleEmployeeDetail!.parentSpouseName}'),
                  empDetailsPrintView(label: 'Relation : ', value: '${singleEmployeeDetail!.relationship}'),
                  empDetailsPrintView(label: 'Relation : ', value: '${singleEmployeeDetail!.relationship}'),
                  empDetailsPrintView(label: 'Mobile NO : ', value: '${singleEmployeeDetail!.mobileNumber}'),
                  empDetailsPrintView(label: 'Aadhaar No : ', value: '${singleEmployeeDetail!.adharNumber}'),
                  empDetailsPrintView(label: 'Aadhaar Name : ', value: '${singleEmployeeDetail!.adharName}'),
                  empDetailsPrintView(label: 'Pan No : ', value: '${singleEmployeeDetail!.panCard}'),
                  empDetailsPrintView(label: 'Category : ', value: '${singleEmployeeDetail!.category}'),
                  empDetailsPrintView(label: 'Bank Account No : ', value: '${singleEmployeeDetail!.bankAccount}'),
                  empDetailsPrintView(label: 'Bank Name : ', value: '${singleEmployeeDetail!.bankName}'),
                  empDetailsPrintView(label: 'IFSC Code : ', value: '${singleEmployeeDetail!.ifscCode}'),
                  empDetailsPrintView(label: 'Salary Date : ', value: '${convertDateFormat(date:singleEmployeeDetail!.salary[0].date)}'),
                  empDetailsPrintView(label: 'Salary Amount : ', value: '${singleEmployeeDetail!.salary[0].amountDecided}'),
                  empDetailsPrintView(label: 'Joining Date : ', value: '${convertDateFormat(date:singleEmployeeDetail!.joiningDate)}'),
                  empDetailsPrintView(label: 'UAN NO : ', value: '${singleEmployeeDetail!.uanNo}'),
                  empDetailsPrintView(label: 'PF NO : ', value: '${singleEmployeeDetail!.pfNo}'),
                  empDetailsPrintView(label: 'ESI NO : ', value: '${singleEmployeeDetail!.esiNo}'),
                  empDetailsPrintView(label: 'Remark : ', value: '${singleEmployeeDetail!.remark}'),

                ],
              ),
            ),
          ];
        },
      ),
    );

    return doc.save();
  }

  empDetailsPrintView({
    required String label,
    required String value,
  }) {
    return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
      pw.Text(label,   style: pw.TextStyle(
          // decoration: pw.TextDecoration.underline,
          color: PdfColors.black,
          fontWeight: pw.FontWeight.normal,
          fontSize: 15)),
      pw.Text(value,   style: pw.TextStyle(
          // decoration: pw.TextDecoration.underline,
          color: PdfColors.black,
          fontWeight: pw.FontWeight.normal,
          fontSize: 15)),
    ]);
  }
  String convertDateFormat({required String date}) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(date);

    String formattedDate = DateFormat("dd-MM-yyyy").format(inputDate);

    return formattedDate;
  }


  changeStatus(DataStatus value) => dataStatus(value);
}
