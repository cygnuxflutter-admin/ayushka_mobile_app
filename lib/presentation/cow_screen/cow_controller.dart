import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../milk_screen/controller/milk_controller.dart';
import '../milk_screen/models/cowList_res.dart';

enum ModuleEnum { shedCountingScreen, cowsScreen, attendance, hr, none }

ModuleEnum moduleEnum = ModuleEnum.none;

class CowsScreenController extends GetxController {
  final filteredCowList = <Datum>[].obs;
  final originalCowList = <Datum>[].obs;
  final searchController = TextEditingController();
  final currentPage = 1.obs;
  final int itemsPerPage = 100;
  final isSearching = false.obs;
  Timer? _debounceTimer;

  MilkController milkController = Get.find<MilkController>();

  @override
  void onInit() {
    super.onInit();
    // Fetch data when controller is initialized
    getData();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }

  Future<void> getData() async {
    // Schedule status change after the current frame to avoid triggering setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) => milkController.changeStatus(DataStatusE.loading));
    if (moduleEnum == ModuleEnum.shedCountingScreen) {
      originalCowList.assignAll(List<Datum>.from(await Get.arguments));
    } else {
      originalCowList.assignAll(List<Datum>.from(milkController.cowList));
    }
    _sortCows(originalCowList);

    if (moduleEnum == ModuleEnum.cowsScreen) {
      _loadCowsForPage(currentPage.value);
    } else {
      filteredCowList.assignAll(originalCowList);
    }
    // Schedule status change after data is loaded
  WidgetsBinding.instance.addPostFrameCallback((_) => milkController.changeStatus(DataStatusE.done));
  }

  void onSearchTextChanged(String newText) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    isSearching.value = true;

    if (newText.isEmpty) {
      isSearching.value = false;
      if (moduleEnum == ModuleEnum.cowsScreen) {
        _loadCowsForPage(currentPage.value);
      } else {
        filteredCowList.assignAll(originalCowList);
      }
    } else {
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        _updateFilteredCowList(newText);
        isSearching.value = false;
      });
    }
  }

  void _loadCowsForPage(int page) {
    final startIndex = (page - 1) * itemsPerPage;
    filteredCowList.assignAll(
      originalCowList.skip(startIndex).take(itemsPerPage).toList(),
    );
  }

  void _updateFilteredCowList(String query) {
    final lowercaseQuery = query.toLowerCase();
    filteredCowList.assignAll(
      originalCowList
          .where((cow) =>
              cow.tagId.toString().toLowerCase().contains(lowercaseQuery) ||
              cow.calfName.toLowerCase().contains(lowercaseQuery))
          .toList(),
    );
  }

  void nextPage() {
    if (currentPage.value < (originalCowList.length / itemsPerPage).ceil()) {
      currentPage.value++;
      _loadCowsForPage(currentPage.value);
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      _loadCowsForPage(currentPage.value);
    }
  }

  void _sortCows(List<Datum> list) {
    list.sort((a, b) {
      final idA = a.tagId;
      final idB = b.tagId;
      final intA = int.tryParse(idA) ?? double.infinity;
      final intB = int.tryParse(idB) ?? double.infinity;

      if (intA != double.infinity && intB != double.infinity) {
        return intA.compareTo(intB);
      } else if (intA == double.infinity && intB == double.infinity) {
        return idA.compareTo(idB);
      } else {
        return intA == double.infinity ? 1 : -1;
      }
    });
  }
}
