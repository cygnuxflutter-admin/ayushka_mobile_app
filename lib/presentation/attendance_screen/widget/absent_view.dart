import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/size.dart';
import '../models/absent_employee_list/absent_employee_list_response.dart';

class AbsentPresentView extends StatelessWidget {
  AbsentPresentView({
    key,
    required this.attendanceEmployeeList,
    required this.index,
    required this.isPresent,
  });

  final RxList<AttendanceEmployeeList> attendanceEmployeeList;
  final int index;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        color: attendanceEmployeeList[index].isSelect.value
            ? Color(0xff0C5E1A5)
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => CustomIconButton(
                  height:
                      attendanceEmployeeList[index].isSelect.value ? 38 : 43,
                  width: attendanceEmployeeList[index].isSelect.value ? 38 : 43,
                  margin: getMargin(bottom: 1),
                  variant: isPresent
                      ? attendanceEmployeeList[index].isSelect.value
                          ? IconButtonVariant.FillWhite200
                          : IconButtonVariant.FillGreen600b2
                      : IconButtonVariant.FillRedA200,
                  child: CustomImageView(
                      imagePath: attendanceEmployeeList[index].isSelect.value
                          ? ImageConstant.checkMark
                          : attendanceEmployeeList[index].gender == "FEMALE"
                              ? ImageConstant.female
                              : ImageConstant.male),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${attendanceEmployeeList[index].empId}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: getFontSize(18),
                        fontFamily: 'Outfit',
                      ),
                    ),
                    Text(
                      "${attendanceEmployeeList[index].payrollName.length <= 15 ? attendanceEmployeeList[index].payrollName :attendanceEmployeeList[index].payrollName.substring(0, 15) + "..."}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87.withOpacity(0.7),
                      ),
                    ),

                  ],
                ),
              ),
              Spacer(),
              attendanceEmployeeList[index].attendanceType == 'HalfDay'
                  ? Row(
                    children: [
                      Image(
                          image: AssetImage(ImageConstant.halfDay),
                          height: AppSize.size(context).height * 0.05,
                          width: AppSize.size(context).width * 0.05,
                        ),
                      Text('  Half Day'),
                    ],
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
