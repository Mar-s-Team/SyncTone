import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var searchText = ''.obs;
  var results = <Object>[].obs;
  var isLoading = false.obs;
  bool hasSearched = false;

  void search(String query) async {
    isLoading.value = true;
    hasSearched = true;
    isLoading.value = false;
  }

  void clearSelection(){
    isLoading = false.obs;
    searchText = ''.obs;
    hasSearched = false;
    results.clear();
  }
}