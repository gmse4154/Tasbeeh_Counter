
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager
{
  static List<Map<String, int>> keyValueList =[];

  //static List<Map<String, int>> get keyValueList => _keyValueList;

  static void saveNewData(String key , int value,BuildContext context)
  {
    keyValueList.add({key:value});
    DataManager._updateListinStorage();
    // Display a message
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dhikr saved successfully'),)
    );
  }

  static void updateData(int index,String key ,int value,BuildContext context)
  {
    keyValueList[index] = {key: value};

    DataManager._updateListinStorage();
    // Display a message
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dhikr Updated Successfully'),)
    );
  }

  static void _updateListinStorage()async {
    // Convert the list to a JSON string
    String jsonString = jsonEncode(keyValueList);

    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the JSON string to SharedPreferences
    prefs.setString("amgTasbeehDataList", jsonString);
  }

  // Method to load the list from SharedPreferences
  static void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("amgTasbeehDataList");

    if (jsonString != null) {
      // Decode the JSON string to a List<Map<String, dynamic>>
      List<dynamic> decodedList = jsonDecode(jsonString);

      // Clear the existing list and add the decoded list
      keyValueList.clear();

      // Dynamically check and convert each element to Map<String, int>
      for (dynamic element in decodedList) {
        if (element is Map<String, dynamic>) {
          Map<String, int> convertedElement = Map<String, int>.from(element);
          keyValueList.add(convertedElement);
        }
      }
    }
  }

  static void removeData(int index){
    keyValueList.removeAt(index);
    _updateListinStorage();
  }



}

