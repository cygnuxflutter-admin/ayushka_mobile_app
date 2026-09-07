import 'package:flutter/material.dart';
import 'package:cattle_app/widgets/size.dart';

import '../../../core/utils/image_constant.dart';
import '../models/absent_employee_list/absent_employee_list_response.dart';

class MaleFemaleCountView extends StatelessWidget {
   MaleFemaleCountView({key, required this.countList});

  final List<AttendanceEmployeeList> countList;


  @override
  Widget build(BuildContext context) {
    int male = countList.where((element) => element.gender == 'MALE').length;
    int female = countList.where((element) => element.gender == 'FEMALE').length;
    return Container(
      width: double.infinity,
      height: AppSize.size(context).height * 0.05,
      decoration: BoxDecoration(
        color: Color(0xff232f34),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(AssetImage(ImageConstant.male), color: Colors.white),
          Text(
            ' : $male',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: AppSize.size(context).width * 0.35),
          ImageIcon(AssetImage(ImageConstant.female), color: Colors.white),
          Text(
            ' : $female',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }


}
