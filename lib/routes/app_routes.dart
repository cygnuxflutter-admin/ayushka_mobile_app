import 'package:cattle_app/presentation/change_guashala_screen/change_guashala_binding.dart';
import 'package:cattle_app/presentation/change_guashala_screen/change_guashala_screen.dart';
import 'package:cattle_app/presentation/cow_screen/cow_details/edit_cow_details_screen.dart';
import 'package:cattle_app/presentation/report_screen/guashala_report_binding.dart';
import 'package:cattle_app/presentation/report_screen/guashala_report_screen.dart';
import 'package:get/get.dart';
import 'package:cattle_app/presentation/Expense/Expense_entry_details_histoy_screen.dart';
import 'package:cattle_app/presentation/Expense/Expense_entry_details_screen.dart';
import 'package:cattle_app/presentation/Medication/medication_update_screen.dart';
import 'package:cattle_app/presentation/Medication/medication_binding.dart';
import 'package:cattle_app/presentation/Medication/medication_history_screen.dart';
import 'package:cattle_app/presentation/Medication/medication_screen.dart';
import 'package:cattle_app/presentation/add_milk_screen/add_milk_screen.dart';
import 'package:cattle_app/presentation/add_milk_screen/binding/add_milk_binding.dart';
import 'package:cattle_app/presentation/attendance_screen/attendance_screen_binding.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/add_cow_binding.dart';
import 'package:cattle_app/presentation/cow_screen/Add_cow/add_cow_screen.dart';
import 'package:cattle_app/presentation/cow_screen/cow_binding.dart';
import 'package:cattle_app/presentation/cow_screen/cow_details/cow_details_binding.dart';
import 'package:cattle_app/presentation/cow_screen/cow_details/family_hierarchy_screen.dart';
import 'package:cattle_app/presentation/cow_screen/cow_details/children_hierarchy_screen.dart';
import 'package:cattle_app/presentation/cow_screen/cow_screen.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/binding/dairy_usage_binding.dart';
import 'package:cattle_app/presentation/dairy_usage_screen/dairy_usage_screen.dart';
import 'package:cattle_app/presentation/dashboard_screen/binding/dashboard_binding.dart';
import 'package:cattle_app/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:cattle_app/presentation/filter_screen/filter_binding.dart';
import 'package:cattle_app/presentation/filter_screen/filter_screen.dart';
import 'package:cattle_app/presentation/hr_screen/add_employee_screen/addemployeescreenbinding.dart';
import 'package:cattle_app/presentation/hr_screen/employe_detail_screen/employedetailscreenbinding.dart';
import 'package:cattle_app/presentation/hr_screen/hr_screen.dart';
import 'package:cattle_app/presentation/hr_screen/hr_screen_binding.dart';
import 'package:cattle_app/presentation/login_screen/binding/login_binding.dart';
import 'package:cattle_app/presentation/medical_report_screen/medical_history.dart';
import 'package:cattle_app/presentation/medical_report_screen/medicine_update_screen.dart';
import 'package:cattle_app/presentation/medical_report_screen/add_medicine_history.dart';
import 'package:cattle_app/presentation/medical_report_screen/pending_cow_screen.dart';
import 'package:cattle_app/presentation/sales_entry/sales_transaction_screen.dart';
import 'package:cattle_app/presentation/shed_couting/shed_transfer/shed_transfer_binding.dart';
import 'package:cattle_app/presentation/splashScreen/splesh_screen.dart';
import 'package:cattle_app/presentation/splashScreen/splesh_screen_binding.dart';
import 'package:cattle_app/presentation/login_screen/login_screen.dart';
import 'package:cattle_app/presentation/milk_screen/binding/milk_binding.dart';
import 'package:cattle_app/presentation/milk_screen/milk_screen.dart';

import '../presentation/Expense/Expense_binding.dart';
import '../presentation/Expense/Expense_screen.dart';
import '../presentation/Medication/multiple_medication_update_screen.dart';
import '../presentation/add_milk_screen/add_bulk_milk.dart';
import '../presentation/attendance_screen/attendance_screen.dart';
import '../presentation/attendance_screen/page/all_emp_history_page.dart';
import '../presentation/cow_screen/Add_cow/cow_transfer_screen.dart';
import '../presentation/cow_screen/cow_details/cow_details_screen.dart';
import '../presentation/heat_pregnancy_screen/heat_pregnancy_binding.dart';
import '../presentation/heat_pregnancy_screen/heat_pregnancy_screen.dart';
import '../presentation/hr_screen/add_employee_screen/addemployeescreen.dart';
import '../presentation/hr_screen/employe_detail_screen/employedetailscreen.dart';
import '../presentation/medical_report_screen/medical_report_binding.dart';
import '../presentation/medical_report_screen/medical_report_screen.dart';
import '../presentation/sair_detail_screen/sair_detail_screen.dart';
import '../presentation/sair_detail_screen/sair_detail_screen_binding.dart';
import '../presentation/sales_entry/sales_entry_binding.dart';
import '../presentation/sales_entry/sales_entry_screen.dart';
import '../presentation/shed_couting/shed_counting_binding.dart';
import '../presentation/shed_couting/shed_counting_screen.dart';
import '../presentation/shed_couting/shed_transfer/Shed_transfer_screen.dart';
import '../presentation/vaccine_details_screen/vaccine_details_binding.dart';
import '../presentation/vaccine_details_screen/vaccine_details_screen.dart';
import '../presentation/vaccine_reminder_screen/binding/vaccine_reminder_binding.dart';
import '../presentation/vaccine_reminder_screen/vaccine_reminder_screen.dart';
class AppRoutes {
  static const String splashScreen = '/splashScreen';

  static const String loginScreen = '/login_screen';

  static const String dashboardScreen = '/dashboard_screen';

  static const String milkScreen = '/milk_screen';

  static const String addMilkScreen = '/add_milk_screen';

  static const String initialRoute = '/initialRoute';

  static const String filterScreen = '/filterScreen';

  static const String cowsScreen = '/cowsScreen';

  static const String cowsDetailScreen = '/cowsDetailScreen';
  static const String editCowDetailsScreen = '/editCowDetailsScreen';

  static const String addNewCow = '/addNewCow';
  static const String shedTransfer = '/shedTransfer';
  static const String CowTransfer = '/CowTransfer';
  static const String dairyUsageScreen = '/DairyUsageScreen';
  static const String expenseScreen = '/expenseScreen';
  static const String expenseEntryDetails = '/expenseEntryDetails';
  static const String expenseEntryDetailsHistory =
      '/expenseEntryDetailsHistory';
  static const String shedCounting = '/shedCounting';
  static const String sealsEntry = '/sealsEntry';
  static const String sealsTransaction = '/sealsTransaction';

  static const String attendance = '/AttendanceScreen';
  static const String heatPregnancy = '/heatPregnancy';
  static const String addBulkMilk = '/addBulkMilk';

  static const String hr = '/HrScreen';

  static const String employeeDetailScreen = '/EmployeeDetailScreen';

  static const String addEmployeeScreen = '/AddEmployeeScreen';
  static const String addVaccineScreen = '/addVaccineScreen';
  static const String vaccineDetailsScreen = '/vaccineDetailsScreen';
  static const String medicalUpdateScreen = '/medicalUpdateScreen';
  static const String medicalHistory = '/medicalHistory';
  static const String addMedicineHistory = '/addMedicineHistory';
  static const String medicationScreen = '/medicationScreen';
  static const String medicationUpdateScreen = '/medicationUpdateScreen';
  static const String medicationHistoryScreen = '/medicationHistoryScreen';
  static const String pendingCowScreen = '/pendingCowScreen';
  static const String multipleMedicationUpdateScreen =
      '/multipleMedicationUpdateScreen';
  static const String familyHierarchy = '/familyHierarchy';
  static const String childrenHierarchy = '/childrenHierarchy';
  static const String allEmpHistory = '/allEmpHistory';
  static const String changeGuashala = '/changeGuashala';
  static const String sairDetailScreen = '/sairDetailScreen';
  static const String guashalaReportScreen = '/guashalaReportScreen';
  static const String vaccineReminderScreen = '/vaccineReminderScreen';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
      ],
    ),
    GetPage(
      name: milkScreen,
      page: () => MilkScreen(),
      bindings: [
        MilkBinding(),
      ],
    ),
    GetPage(
      name: addMilkScreen,
      page: () => AddMilkScreen(),
      bindings: [
        AddMilkBinding(),
      ],
    ),
    GetPage(
      name: addBulkMilk,
      page: () => AddBulkMilkScreen(),
      bindings: [
        AddMilkBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: filterScreen,
      page: () => FilterScreen(
        sortedData: (List<String> value) {},
      ),
      bindings: [
        FilterBinding(),
      ],
    ),
    GetPage(
      name: cowsScreen,
      page: () => CowsScreen(),
      bindings: [
        CowsScreenBinding(),
      ],
    ),
    GetPage(
      name: cowsDetailScreen,
      page: () => CowDetailScreen(),
      bindings: [
        CowsDetailScreenBinding(),
      ],
    ),
    GetPage(
      name: editCowDetailsScreen,
      page: () => EditCowDetailsScreen(),
    ),
    GetPage(
      name: familyHierarchy,
      page: () => FamilyHierarchy(),
      bindings: [
        CowsDetailScreenBinding(),
      ],
    ),
    GetPage(
      name: childrenHierarchy,
      page: () => ChildrenHierarchy(),
      bindings: [
        CowsDetailScreenBinding(),
      ],
    ),
    GetPage(
      name: addNewCow,
      page: () => AddCowScreen(),
      bindings: [
        AddCowScreenBinding(),
      ],
    ),
    GetPage(
      name: CowTransfer,
      page: () => CowTransferScreen(),
      bindings: [
        AddCowScreenBinding(),
      ],
    ),
    GetPage(
      name: dairyUsageScreen,
      page: () => DairyUsageScreen(),
      bindings: [
        DairyUsageBinding(),
      ],
    ),
    GetPage(
      name: expenseScreen,
      page: () => ExpenseScreen(),
      bindings: [
        ExpenseScreenBinding(),
      ],
    ),
    GetPage(
      name: expenseScreen,
      page: () => ExpenseScreen(),
      bindings: [
        ExpenseScreenBinding(),
      ],
    ),
    GetPage(
      name: expenseEntryDetails,
      page: () => ExpenseEntryDetailsScreen(),
      bindings: [
        ExpenseScreenBinding(),
      ],
    ),
    GetPage(
      name: expenseEntryDetailsHistory,
      page: () => ExpenseEntryDetailsHistoryScreen(),
      bindings: [
        ExpenseScreenBinding(),
      ],
    ),
    GetPage(
      name: shedTransfer,
      page: () => ShedTransfer(),
      bindings: [
        ShedTransferBinding(),
      ],
    ),
    GetPage(
      name: shedCounting,
      page: () => ShedCounting(),
      bindings: [
        ShedCountingBinding(),
      ],
    ),
    GetPage(
      name: sealsEntry,
      page: () => SalesEntryScreen(),
      bindings: [
        SalesEntryScreenBinding(),
      ],
    ),
    GetPage(
      name: sealsTransaction,
      page: () => SalesTransactionScreen(),
      bindings: [
        SalesEntryScreenBinding(),
      ],
    ),
    GetPage(
      name: attendance,
      page: () => AttendanceScreen(),
      bindings: [
        AttendanceScreenBinding(),
      ],
    ),
    GetPage(
      name: allEmpHistory,
      page: () => AllEmpHistory(),
      bindings: [
        AttendanceScreenBinding(),
      ],
    ),
    GetPage(
      name: hr,
      page: () => HrScreen(),
      bindings: [
        HrScreenBinding(),
      ],
    ),
    GetPage(
      name: employeeDetailScreen,
      page: () => EmployeeDetailScreen(),
      bindings: [
        EmployeeDetailScreenBinding(),
      ],
    ),
    GetPage(
      name: addEmployeeScreen,
      page: () => AddEmployeeScreen(),
      bindings: [
        AddEmployeeScreenBinding(),
      ],
    ),
    GetPage(
      name: addVaccineScreen,
      page: () => MedicalReportScreen(),
      bindings: [
        MedicalReportBinding(),
      ],
    ),
    GetPage(
      name: medicalUpdateScreen,
      page: () => MedicalUpdateScreen(),
      bindings: [
        MedicalReportBinding(),
      ],
    ),
    GetPage(
      name: pendingCowScreen,
      page: () => PendingCowScreen(),
      bindings: [
        MedicalReportBinding(),
      ],
    ),
    GetPage(
      name: medicalHistory,
      page: () => MedicalHistory(),
      bindings: [
        MedicalReportBinding(),
      ],
    ),
    GetPage(
      name: addMedicineHistory,
      page: () => AddMedicineHistory(),
      bindings: [
        MedicalReportBinding(),
      ],
    ),
    GetPage(
      name: vaccineDetailsScreen,
      page: () => VaccineDetails(),
      bindings: [
        vaccineDetailsBinding(),
      ],
    ),
    GetPage(
      name: heatPregnancy,
      page: () => HeatPregnancy(),
      bindings: [
        HeatPregnancyBinding(),
      ],
    ),
    GetPage(
      name: medicationScreen,
      page: () => MedicationScreen(),
      bindings: [
        MedicationBinding(),
      ],
    ),
    GetPage(
      name: medicationUpdateScreen,
      page: () => MedicationUpdateScreen(),
      bindings: [
        MedicationBinding(),
      ],
    ),
    GetPage(
      name: medicationHistoryScreen,
      page: () => MedicationHistoryScreen(),
      bindings: [
        MedicationBinding(),
      ],
    ),
    GetPage(
      name: multipleMedicationUpdateScreen,
      page: () => MultipleMedicationUpdateScreen(),
      bindings: [
        MedicationBinding(),
      ],
    ),
    GetPage(
      name: changeGuashala,
      page: () => ChangeGuashalaScreen(),
      bindings: [
        ChangeGuashalaScreenBinding(),
      ],
    ),
    GetPage(
      name: sairDetailScreen,
      page: () => SairDetailScreen(),
      bindings: [
        SairDetailScreenBinding(),
      ],
    ),
    GetPage(
      name: guashalaReportScreen,
      page: () => GuashalaReportScreen(),
      bindings: [
        GuashalaReportScreenBinding(),
      ],
    ),
    GetPage(
      name: vaccineReminderScreen,
      page: () => VaccineReminderScreen(),
      bindings: [
        VaccineReminderBinding(),
      ],
    ),
  ];
}
