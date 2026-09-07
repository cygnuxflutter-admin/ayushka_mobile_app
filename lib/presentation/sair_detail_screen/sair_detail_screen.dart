import 'package:cattle_app/core/app_export.dart';
import 'package:cattle_app/presentation/sair_detail_screen/sair_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'dart:io';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'model/Sair_Detail_Screen_response.dart';

class SairDetailScreen extends GetView<SairDetailScreenController> {
  const SairDetailScreen({Key? key}) : super(key: key);

  Future<void> _downloadPdf() async {
    try {
      final pdfData = await _buildPdf(PdfPageFormat.a4);
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/sair_report.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfData);
      await Printing.sharePdf(bytes: pdfData, filename: 'sair_report.pdf');
      Get.snackbar('Success', 'PDF saved to $filePath');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download PDF: $e');
    }
  }

  Future<void> _showPdfOptionsDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: 500,
          padding: const EdgeInsets.all(10),
          child: PdfPreview(
            build: (format) async => _buildPdf(format),
            pageFormats: {'A4': PdfPageFormat.a4},
          ),
        ),
      ),
    );
  }

  // Build PDF document with header and table
  Future<Uint8List> _buildPdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final logoBytes = (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    final logo = pw.MemoryImage(logoBytes);
    pdf.addPage(pw.MultiPage(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(24),
      header: (ctx) => pw.Column(
        children: [
          pw.Center(child: pw.Image(logo, height: 60)),
          pw.SizedBox(height: 10),
          pw.Text('Sair Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),
        ],
      ),
      build: (ctx) => [
        pw.Header(level: 2, child: pw.Text('Male Cows')),
        pw.Table.fromTextArray(
          headers: const ['Tag ID', 'Name', 'Breed', 'Gender'],
          data: controller.sairList.where((d) => !d.isFemale).map((d) => [
            d.tagId,
            d.calfName,
            d.type,
            'Male',
          ]).toList(),
        ),
        pw.SizedBox(height: 20),
        pw.Header(level: 2, child: pw.Text('Female Cows')),
        pw.Table.fromTextArray(
          headers: const ['Tag ID', 'Name', 'Breed', 'Gender'],
          data: controller.sairList.where((d) => d.isFemale).map((d) => [
            d.tagId,
            d.calfName,
            d.type,
            'Female',
          ]).toList(),
        ),
      ],
    ));
    return await pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      appBar: CustomAppBar(
        leadingIconOnTap: () {
          Get.back();
        },
        leadingIcon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        centerTitle: true,
        height: 60,
        title: "Sair Detail",
        styleType: Style.bgFillBluegray900,
        actions: [
          Obx(() => controller.sairList.isNotEmpty
              ? InkWell(
                  onTap: () async {
                    await _showPdfOptionsDialog();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.picture_as_pdf, color: Colors.white, size: 30),
                  ),
                )
              : const SizedBox()),
          Obx(() => controller.sairList.isNotEmpty
              ? InkWell(
                  onTap: () async {
                    await _downloadPdf();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.download, color: Colors.white, size: 30),
                  ),
                )
              : const SizedBox()),
          Padding(
            padding: getPadding(left: 13, top: 6, right: 13, bottom: 20),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      elevation: 0,
                      content: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 15,
                              child: Icon(Icons.close,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextFormField(
                                  globalKey:
                                      controller.sairIDKey,
                                  controller: controller.sairID,
                                  hintText: "Sair ID",
                                  labelText: "Sair ID",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Sair ID ';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomButton(
                                    text: "Apply",
                                    width: 200,
                                    height: 55,
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    variant: ButtonVariant.FillGreen600b2,
                                    onTap: () {
                                      if (controller.sairIDKey.currentState?.validate() ?? false) {
                                        controller.SairDetail();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() => controller.sairList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No Records Found",
                    style: TextStyle(
                      color: Color(0xff2C3E50),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Use the search icon at the top to find Sair details.",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                itemCount: controller.sairList.length,
                itemBuilder: (context, index) {
                  final datum = controller.sairList[index];
                  return SairDetailItemWidget(
                    datum: datum,
                    onTap: () {
                      // Navigate or show details on tap if needed
                    },
                  );
                },
              ),
            )),
    );
  }
}

class SairDetailItemWidget extends StatelessWidget {
  final SairDetailDatum datum;
  final VoidCallback? onTap;

  const SairDetailItemWidget({required this.datum, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFemale = datum.isFemale;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left icon container
            Container(
              height: 52,
              width: 52,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isFemale
                    ? const Color(0xffFFF0E0)
                    : const Color(0xffF0F4F8),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                isFemale
                    ? 'assets/images/gircow-r 1.png'
                    : 'assets/images/bullIcon.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            // Middle text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TAG #${datum.tagId}",
                    style: TextStyle(
                      color: isFemale
                          ? const Color(0xffE67E22)
                          : const Color(0xff7F8C8D),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    datum.calfName,
                    style: const TextStyle(
                      color: Color(0xff2C3E50),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Right Gender Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isFemale
                    ? const Color(0xffFFF2F2)
                    : const Color(0xffEBF3FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFemale ? Icons.female : Icons.male,
                    color: isFemale
                        ? const Color(0xffE74C3C)
                        : const Color(0xff3498DB),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isFemale ? "Female" : "Male",
                    style: TextStyle(
                      color: isFemale
                          ? const Color(0xffE74C3C)
                          : const Color(0xff3498DB),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
