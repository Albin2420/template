// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';

// class FirestoreService {
//   FirestoreService._();

//   static final FirestoreService _instance = FirestoreService._();

//   factory FirestoreService() => _instance;

//   Future setStreakData({
//     required String userName,
//     required List streakvalue,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .update({'streakComplted': streakvalue});
//   }

//   Future<List<bool>> getdailyTestReportTest({
//     required String docName,
//     required String sub,
//   }) async {
//     try {
//       final doc =
//           await FirebaseFirestore.instance
//               .collection("neuflo_basic")
//               .doc(docName)
//               .get();

//       if (doc.exists) {
//         List<bool> res = [];
//         log(
//           "report of getdailyTestReportTest(): ${doc['dialyexamReport'][sub]}",
//         );
//         var data = doc['dialyexamReport'][sub];

//         res.add(data['Easy']);
//         res.add(data['Medium']);
//         res.add(data['Difficult']);
//         log("res of physics:$res");
//         return res;
//       }
//     } catch (e) {
//       log("Error in getdailyTestReportTest():$e");
//     }
//     return [false, false, false];
//   }

//   Future<int> getTotalTestsDoneperDay({required String docName}) async {
//     try {
//       final doc =
//           await FirebaseFirestore.instance
//               .collection('neuflo_basic')
//               .doc(docName)
//               .get();
//       if (doc.exists) {
//         log("totalTestsDoneperDay:${doc["totalTestsDoneperDay"]}");
//         return doc['totalTestsDoneperDay'];
//       } else {
//         return 0;
//       }
//     } catch (e) {
//       log("Error in gettotalTestsDoneperDay():$e");
//       return 0;
//     }
//   }

//   Future<AppUserInfo?> getCurrentUserDocument({
//     required String userName,
//   }) async {
//     DocumentSnapshot snap =
//         await FirebaseFirestore.instance
//             .collection("neuflo_basic")
//             .doc(userName)
//             .get();

//     if (snap.data() != null) {
//       Map<String, dynamic> data = jsonDecode(jsonEncode(snap.data()));

//       AppUserInfo userInfo = AppUserInfo.fromMap(data);

//       return userInfo;
//     } else {
//       return null;
//     }
//   }

//   Future dailyExamReportResetandStreakReset({required String userName}) async {
//     try {
//       log("dailyExamReportResetandStreakReset():$userName");
//       DocumentSnapshot snap =
//           await FirebaseFirestore.instance
//               .collection("neuflo_basic")
//               .doc(userName)
//               .get();

//       if (kDebugMode) {
//         log('CURRENT USER DOCUMENT snap => ${snap.data()}');
//       }
//       if (snap.data() != null) {
//         DateTime now = DateTime.now();
//         log("today:$now");
//         String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//         Map<String, dynamic> data = jsonDecode(jsonEncode(snap.data()));

//         log("end of weak:${data['endOfWeek']}");

//         if (isDatePassed(data['endOfWeek'])) {
//           log("timesup for reset streaklist");
//           resetStreakDailyExamReport(
//             userName: userName,
//             formattedDate: formattedDate,
//           );
//         } else if (formattedDate != data['dialyexamReport']['currentDate']) {
//           // Convert the formattedDate (current date) and data['dialyexamReport']['currentDate'] to DateTime objects
//           DateTime currentDate = DateTime.parse(
//             formattedDate,
//           ); // formattedDate is in yyyy-MM-dd format
//           DateTime storedDate = DateTime.parse(
//             data['dialyexamReport']['currentDate'],
//           ); // stored date in yyyy-MM-dd format

//           // Calculate the difference between the two dates
//           Duration difference = currentDate.difference(storedDate);

//           // Get the difference in days
//           int daysDifference = difference.inDays;

//           // Log the difference
//           log("Difference in days: $daysDifference");
//           log("reset dialyexamReport and update the currentDate");
//           resetDailyExamReport(
//             userName: userName,
//             formattedDate: formattedDate,
//           );
//           updateStreak(docname: userName, difference: daysDifference);
//         } else {
//           log("today");
//         }
//       } else {
//         return null;
//       }
//     } catch (e) {
//       log('Error:$e');
//       return null;
//     }
//   }

//   bool isDatePassed(String dateString) {
//     try {
//       // Parse the input string to a DateTime object
//       final inputDate = DateTime.parse(dateString);

//       // Get current date with time set to midnight
//       final now = DateTime.now();
//       final today = DateTime(now.year, now.month, now.day);

//       // Extract just the date part of the input
//       final inputDateOnly = DateTime(
//         inputDate.year,
//         inputDate.month,
//         inputDate.day,
//       );

//       // If dates are the same (today), it's not passed
//       if (inputDateOnly.isAtSameMomentAs(today)) {
//         log("got it................");
//         return false;
//       }

//       // Compare dates
//       // If input date is before today, it's passed
//       return inputDateOnly.isBefore(today);
//     } catch (e) {
//       log('Error parsing date: $e');
//       return false; // Or handle the error as needed
//     }
//   }

//   Future<void> resetStreakDailyExamReport({
//     required String userName,
//     required String formattedDate, // Pass the formatted current date
//   }) async {
//     try {
//       DateTime now = DateTime.now();
//       int daysToSunday = now.weekday % 7; // 0 for Sunday, 1 for Monday, etc.
//       DateTime startOfWeek = now.subtract(Duration(days: daysToSunday));
//       DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

//       // Format the start and end of the week as strings
//       String startOfWeekString = DateFormat('yyyy-MM-dd').format(startOfWeek);
//       String endOfWeekString = DateFormat('yyyy-MM-dd').format(endOfWeek);

//       int day = getCurrentDayIndex();
//       List<int> streaklist = generateDaysList(day);
//       log("updated list in resetStreak():$streaklist");

//       var dialyexamReport = {
//         "Physics": {"Easy": false, "Medium": false, "Difficult": false},
//         "Chemistry": {"Easy": false, "Medium": false, "Difficult": false},
//         "Biology": {"Easy": false, "Medium": false, "Difficult": false},
//         "currentDate": formattedDate,
//       };

//       // Reset streak and update the start and end of the week as strings
//       await FirebaseFirestore.instance
//           .collection("neuflo_basic")
//           .doc(userName)
//           .update({
//             'streakComplted': streaklist,
//             'startOfWeek': startOfWeekString,
//             'endOfWeek': endOfWeekString,
//             'dialyexamReport': dialyexamReport,
//             'currentstreakIndex': day,
//             'totalTestsDoneperDay': 0,
//           });
//     } catch (e) {
//       log("Error in resetStreak():$e");
//     }
//   }

//   Future<void> updateDailyExamReport({
//     required String subject,
//     required String level,
//     required String docname,
//   }) async {
//     try {
//       log("subject in updateDailyExamReport():$subject");
//       log("level in updateDailyExamReport():$level");

//       // Validate the level is correct for a subject
//       if (!["Easy", "Medium", "Difficult"].contains(level)) {
//         log("Invalid level passed: $level");
//         return; // exit if the level is not valid
//       }

//       // Fetch the current document to get the existing value of 'totalTestsDoneperDay'
//       var docSnapshot =
//           await FirebaseFirestore.instance
//               .collection("neuflo_basic")
//               .doc(docname)
//               .get();

//       if (docSnapshot.exists) {
//         int totalTestsDoneperDay =
//             docSnapshot.data()?['totalTestsDoneperDay'] ??
//             0; // Get current value (default to 0 if null)

//         // Update the Firestore document
//         await FirebaseFirestore.instance
//             .collection("neuflo_basic")
//             .doc(docname)
//             .update({
//               'dialyexamReport.$subject.$level':
//                   true, // Set the specific subject-level to true
//               'totalTestsDoneperDay':
//                   totalTestsDoneperDay +
//                   1, // Increment the totalTestsDoneperDay
//             });

//         // Fetch the updated document to count true values for each subject
//         var updatedDocSnapshot =
//             await FirebaseFirestore.instance
//                 .collection("neuflo_basic")
//                 .doc(docname)
//                 .get();

//         if (updatedDocSnapshot.exists) {
//           var dailyExamReport =
//               updatedDocSnapshot.data()?['dialyexamReport'] ?? {};

//           // Separate subjects: Physics, Chemistry, and Biology
//           int physicsTrueCount = 0;
//           int chemistryTrueCount = 0;
//           int biologyTrueCount = 0;

//           // Function to count true values for a subject
//           int countTrueValues(Map<String, dynamic> subjectReport) {
//             int trueCount = 0;
//             subjectReport.forEach((level, value) {
//               if (value == true) {
//                 trueCount++;
//               }
//             });
//             return trueCount;
//           }

//           // Check for Physics, Chemistry, and Biology subjects and count true values
//           if (dailyExamReport['Physics'] != null) {
//             physicsTrueCount = countTrueValues(dailyExamReport['Physics']);
//           }
//           if (dailyExamReport['Chemistry'] != null) {
//             chemistryTrueCount = countTrueValues(dailyExamReport['Chemistry']);
//           }
//           if (dailyExamReport['Biology'] != null) {
//             biologyTrueCount = countTrueValues(dailyExamReport['Biology']);
//           }

//           log("Physics true count: $physicsTrueCount");
//           log("Chemistry true count: $chemistryTrueCount");
//           log("Biology true count: $biologyTrueCount");

//           int totalcount =
//               physicsTrueCount + chemistryTrueCount + biologyTrueCount;

//           // If all subjects have completed 3 tests (total 9 tests), update streak list
//           if (totalcount == 9) {
//             log("time to update streak list");
//             await setstreakTocompleted(docName: docname);
//           }
//         }
//       } else {
//         log("Document not found for $docname");
//       }
//     } catch (e) {
//       log("error in updateDailyExamReport():$e");
//     }
//   }

//   Future<void> setstreakTocompleted({required String docName}) async {
//     try {
//       var docRef = FirebaseFirestore.instance
//           .collection("neuflo_basic")
//           .doc(docName);

//       // Fetch the document
//       var docSnapshot = await docRef.get();
//       if (docSnapshot.exists) {
//         // Retrieve the current streakComplted array
//         List<dynamic> streakCompleted = docSnapshot['streakComplted'];
//         int streakIndex = docSnapshot['currentstreakIndex'];

//         streakCompleted[streakIndex] = 2;
//         await docRef.update({"streakComplted": streakCompleted});
//       }
//     } catch (e) {
//       log("Error in setstreakTocompleted():$e");
//     }
//   }

//   Future<void> updateStreak({
//     required String docname,
//     required int difference,
//   }) async {
//     try {
//       // Get the document reference
//       var docRef = FirebaseFirestore.instance
//           .collection("neuflo_basic")
//           .doc(docname);

//       // Fetch the document
//       var docSnapshot = await docRef.get();
//       if (docSnapshot.exists) {
//         // Retrieve the current streakComplted array
//         List<dynamic> streakCompleted = docSnapshot['streakComplted'];
//         log("streakcompleted:$streakCompleted");
//         int streakIndex = docSnapshot['currentstreakIndex'];

//         log("streakcompleted[index]:${streakCompleted[streakIndex]}");

//         if (streakCompleted[streakIndex] != 2) {
//           streakCompleted[streakIndex] = -1;
//           streakCompleted[streakIndex + difference] = 0;
//         } else {
//           streakCompleted[streakIndex + difference] = 0;
//         }
//         await docRef.update({
//           "streakComplted": streakCompleted,
//           'currentstreakIndex': streakIndex + difference,
//         });
//       }
//     } catch (e) {
//       log("Error in updateStreak(): $e");
//     }
//   }

//   Future resetDailyExamReport({
//     required String userName,
//     required String formattedDate, // Pass the formatted current date
//   }) async {
//     // Prepare the updated daily exam report data
//     // ["Easy", "Medium", "Difficult"]
//     var dialyexamReport = {
//       "Physics": {"Easy": false, "Medium": false, "Difficult": false},
//       "Chemistry": {"Easy": false, "Medium": false, "Difficult": false},
//       "Biology": {"Easy": false, "Medium": false, "Difficult": false},
//       "currentDate": formattedDate,
//     };

//     // Update the Firestore document
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .update({
//           'dialyexamReport': dialyexamReport,
//           'totalTestsDoneperDay': 0,
//         });
//   }

//   int getCurrentDayIndex() {
//     DateTime now = DateTime.now();

//     // Get the weekday (1 = Monday, 7 = Sunday)
//     int weekday = now.weekday;

//     // Adjust so that 0 = Sunday, 1 = Monday, ..., 6 = Saturday
//     int currentDayIndex = (weekday % 7);

//     return currentDayIndex;
//   }

//   List<int> generateDaysList(int currentDayIndex) {
//     List<int> days = List.filled(7, -1); // Start by filling all days with -1

//     // Set the current day to 0
//     days[currentDayIndex] = 0;

//     for (int i = currentDayIndex + 1; i < days.length; i++) {
//       days[i] = 1;
//     }
//     return days;
//   }

//   Future addBasicDetails({
//     required String userName,
//     required String phonenum,
//     required String? email,
//     required String? name,
//     String? imageUrl,
//     required int id,
//     bool? isProfileSetupComplete,
//     required List<int> streaklist,
//     required int currentstreakIndex,
//     required int organization,
//   }) async {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//     // Calculate the start of the week (Sunday)
//     int daysToSunday = now.weekday % 7; // 0 for Sunday, 1 for Monday, etc.
//     DateTime startOfWeek = now.subtract(Duration(days: daysToSunday));
//     DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

//     // Format start and end of the week
//     String startOfWeekFormatted = DateFormat('yyyy-MM-dd').format(startOfWeek);
//     String endOfWeekFormatted = DateFormat('yyyy-MM-dd').format(endOfWeek);

//     // Prepare the daily exam report

//     var dialyexamReport = {
//       "Physics": {"Easy": false, "Medium": false, "Difficult": false},
//       "Chemistry": {"Easy": false, "Medium": false, "Difficult": false},
//       "Biology": {"Easy": false, "Medium": false, "Difficult": false},
//       "currentDate": formattedDate,
//     };

//     // Add the current week's start and end date to the data
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .set({
//           "streakComplted": streaklist,
//           "Todate": formattedDate,
//           "phone": phonenum,
//           "email": email,
//           "name": name,
//           "imageUrl": imageUrl,
//           "id": id,
//           "isProfileSetupComplete": isProfileSetupComplete,
//           "dialyexamReport": dialyexamReport,
//           "startOfWeek": startOfWeekFormatted, // Start of the current week
//           "endOfWeek": endOfWeekFormatted, // End of the current week
//           "currentstreakIndex": currentstreakIndex,
//           "totalTestsDoneperDay": 0,
//           "organization": organization,
//         });
//   }

//   Future createUser({required String phonenum}) async {
//     await FirebaseFirestore.instance
//         .collection("neuflo_users")
//         .doc(phonenum)
//         .set({"phone": phonenum});
//   }

//   void updateBasicDetails({
//     required String userName,
//     required String? email,
//     required String? name,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .update({"email": email, "name": name});
//   }

//   void addPhoneDetails({
//     required String userName,
//     required String phonenum,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .update({"phone": phonenum});
//   }

//   Future<dynamic> getStreakValueFromFirebase({required String userName}) async {
//     DocumentSnapshot snap =
//         await FirebaseFirestore.instance
//             .collection("neuflo_basic")
//             .doc(userName)
//             .get();
//     Map<String, dynamic> data = jsonDecode(jsonEncode(snap.data()));

//     if (kDebugMode) {
//       log('STREAK COMPLETED ===> $data["streakComplted"]');
//     }
//     return data["streakComplted"];
//   }

//   Future<String> getTodateFromFirebase({required String userName}) async {
//     DocumentSnapshot snap =
//         await FirebaseFirestore.instance
//             .collection("neuflo_basic")
//             .doc(userName)
//             .get();
//     Map<String, dynamic> data = jsonDecode(jsonEncode(snap.data()));
//     return data["Todate"];
//   }

//   // Future<List> getListExamId({
//   //   required String userName,
//   // }) async {
//   //   DocumentSnapshot snap = await FirebaseFirestore.instance
//   //       .collection("neuflo_basic")
//   //       .doc(userName)
//   //       .get();
//   //   Map<String, dynamic> data = jsonDecode(jsonEncode(snap.data()));

//   //   // log('practiceTestId from FIRESTORE ===> $data');

//   //   if (data['dailyTestIds'] == null) {
//   //     return [];
//   //   } else {
//   //     return data['dailyTestIds'];
//   //   }
//   // }

//   Future<void> updateTodate({
//     required String userName,
//     required String date,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("neuflo_basic")
//         .doc(userName)
//         .update({'Todate': date});
//   }

//   Future<bool> doesDocumentExist({
//     required String userName,
//     required String collectionName,
//   }) async {
//     final CollectionReference collection = FirebaseFirestore.instance
//         .collection(collectionName);
//     final DocumentSnapshot document = await collection.doc(userName).get();
//     return document.exists;
//   }

//   Future<AppUserInfo?> getUserDocumentByEmail({required String email}) async {
//     var collectionRef = FirebaseFirestore.instance.collection('neuflo_basic');

//     // Query to find the document with the matching email
//     QuerySnapshot querySnapshot =
//         await collectionRef.where('email', isEqualTo: email).get();

//     // If we find a document, return the first document from the query
//     if (querySnapshot.docs.isNotEmpty) {
//       if (querySnapshot.docs.first.data() != null) {
//         Map<String, dynamic> data = jsonDecode(
//           jsonEncode(querySnapshot.docs.first.data()),
//         );

//         AppUserInfo userInfo = AppUserInfo.fromMap(data);
//         if (kDebugMode) {
//           log('USER EXISITING FOR THE GOOGLE USER => $userInfo');
//         }
//         return userInfo;
//       } else {
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }

//   Future<int> getId({required String userName}) async {
//     log('  GET ID USERNAME => $userName');
//     final DocumentSnapshot snap =
//         await FirebaseFirestore.instance
//             .collection('neuflo_basic')
//             .doc(userName)
//             .get();
//     Map<String, dynamic> dataId = jsonDecode(jsonEncode(snap.data()));
//     return dataId['id'];
//   }

//   Future<String?> uniqueid() async {
//     final DocumentSnapshot snap =
//         await FirebaseFirestore.instance
//             .collection('neuflo_counter')
//             .doc('uniquid')
//             .get();
//     Map<String, dynamic> dataId = jsonDecode(jsonEncode(snap.data()));
//     // log('dataId : ${dataId['counter']}');
//     return dataId['counter'];
//   }

//   Future<void> updateid(int id) async {
//     await FirebaseFirestore.instance
//         .collection('neuflo_counter')
//         .doc('uniquid')
//         .set({'counter': id.toString()});
//   }

//   Future<void> deleteDocument({required String docName}) async {
//     try {
//       // Get a reference to the document
//       DocumentReference documentRef = FirebaseFirestore.instance
//           .collection('neuflo_basic')
//           .doc(docName);

//       // Delete the document
//       await documentRef.delete();

//       if (kDebugMode) {
//         log('Document with ID: $docName deleted successfully');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         log('Error deleting document from firestore : $e');
//       }
//     }
//   }
// }
