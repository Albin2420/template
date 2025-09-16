import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = 'Neuflo';

  // Networking and APIs
  // static const String baseUrl = 'https://appi.example.com/';
  // static const String defaultApiKey = 'YOUR_API_KEY';

  // Storage and Databases
  // static const String appTableName = 'app_table';
  // static const String databaseName = 'app_database.db';
}

class Constant {
  static void init({required context}) {
    figmaScreenWidth = 393;
    figmaScreenHeight = 844;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
 
  static late double screenWidth;
  static late double screenHeight;
  static late double figmaScreenWidth;
  static late double figmaScreenHeight;
}
