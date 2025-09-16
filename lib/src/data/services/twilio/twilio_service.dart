import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  String? authToken;
  String? accountSid;
  String? twilioNumber;

  late final TwilioFlutter twilioFlutter;

  TwilioService() {
    accountSid = dotenv.env['ACCOUNT_SID'];
    authToken = dotenv.env['AUTH_TOKEN'];
    twilioNumber = dotenv.env['TWILIO_NUMBER'];

    log('accountSid => $accountSid');
    log('authToken => $authToken');
    log('twilioNumber => $twilioNumber');
    initializeTwilio();
  }

  void initializeTwilio() {
    try {
      twilioFlutter = TwilioFlutter(
        accountSid: accountSid ?? '',
        authToken: authToken ?? '',
        twilioNumber: twilioNumber ?? '',
      );

      log('------- TWILIO INITIALIZED => ${twilioFlutter.toString()} -------');
    } on Exception catch (e) {
      log('error intializing twilio : $e');
    }
  }

  int createOtp() {
    var rnd = math.Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    print(next.toInt());
    return next.toInt();
  }

  Future<String> addVerifiedPhoneNumber(
      {required String phoneNumber, required String userName}) async {
    final url = Uri.parse(
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/OutgoingCallerIds.json');

    log('add url => $url');

    log('$accountSid:$authToken');

    log('phno: $phoneNumber');
    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'PhoneNumber': phoneNumber,
        'FriendlyName': userName, // Optional
      },
    );

    log('RESPONSE => ${response.body}');
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['sid'];
    } else {
      throw Exception('Failed to add verified phone number');
    }
  }

  Future<void> removeVerifiedPhoneNumber({
    required String phoneNumberSid,
    required String accountSid,
    required String authToken,
  }) async {
    final url = Uri.parse(
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/OutgoingCallerIds/$phoneNumberSid.json');
    final response = await http.delete(
      url,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to remove verified phone number');
    }
  }
}
