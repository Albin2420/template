// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';

// class HiveService  extends GetxService{
//   Future<Box<E>> openBox<E>(String boxName) async {
//     if (kDebugMode) {
//       log('opening box [$boxName]');
//     }

//     if (Hive.isBoxOpen(boxName)) {
//       return Hive.box<E>(boxName);
//     } else {
//       return Hive.openBox<E>(boxName);
//     }
//   }

//   Future<bool> hasLength<E>(String boxName) async {
//     final openedBox = await openBox<E>(boxName);
//     var length = openedBox.length;
//     if (kDebugMode) {
//       log('box [$boxName] length: $length');
//     }

//     return length != 0;
//   }

//   Future<void> add<E>(String boxName, E item) async {
//     if (kDebugMode) {
//       log('adding item [$item] to box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     await box.add(item);
//   }

//   Future<void> addAll<E>(String boxName, List<E> items) async {
//     if (kDebugMode) {
//       log('adding [${items.length}]  items to box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     await box.addAll(items);
//   }

//   Future<void> putAt<E>(String boxName, int index, E item) async {
//     if (kDebugMode) {
//       log('putting item [$item] at index [$index] to box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     await box.putAt(index, item);
//   }

//   Future<void> put<E>(String boxName, dynamic key, E item) async {
//     if (kDebugMode) {
//       log('putting item [$item] at key [$key] to box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     await box.put(key, item);
//   }

//   Future<E?> get<E>(String boxName, dynamic key) async {
//     if (kDebugMode) {
//       log('getting item at key [$key] from box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     return box.get(key);
//   }

//   Future<Box<T>> getBox<T>(String boxName) async {
//     if (kDebugMode) {
//       log('getting box [$boxName]');
//     }

//     final box = await openBox<T>(boxName);
//     return box;
//   }

//   Future<List<E>> getAll<E>(String boxName) async {
//     if (kDebugMode) {
//       log('getting all items from box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     return box.values.toList();
//   }

//   Future<void> delete<E>(String boxName, dynamic key) async {
//     if (kDebugMode) {
//       log('deleting item at key [$key] from box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     var values = box.values.toList();
//     if (values.isEmpty) return;
//     await box.delete(key);
//     if (kDebugMode) {
//       log('item with key [$key] deleted from [$boxName]');
//     }
//   }

//   Future<void> deleteAt<E>(String boxName, int index) async {
//     if (kDebugMode) {
//       log('deleting item at index [$index] from box [$boxName]');
//     }

//     final box = await openBox<E>(boxName);
//     var values = box.toMap().values.toList();
//     if (values.length > index) {
//       await box.deleteAt(index);
//     }
//   }

//   Future<void> closeBox(String boxName) async {
//     if (kDebugMode) {
//       log('closing box [$boxName]');
//     }

//     if (Hive.isBoxOpen(boxName)) {
//       await Hive.box(boxName).close();
//     }
//   }

//   Future<void> deleteBox<E>(String boxName) async {
//     if (kDebugMode) {
//       log('deleting box [$boxName]');
//     }

//     if (Hive.isBoxOpen(boxName)) {
//       await Hive.box(boxName).deleteFromDisk();
//     }
//   }

//   Future<void> deleteAllBoxes() async {
//     if (kDebugMode) {
//       log('deleting all boxes');
//     }
//     await Hive.deleteFromDisk();
//     Hive.close();
//   }
// }
