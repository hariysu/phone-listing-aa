import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/application_constants.dart';
import '../models/phone_details.dart';
import '../models/phones.dart';

class WebService {
  Future<Phones> fetchPhones(
      {String url = ApplicationConstants.API_LISTING}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Phones.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<PhoneDetails> fetchPhoneDetails() async {
    final response =
        await http.get(Uri.parse(ApplicationConstants.API_DETAILS));
    if (response.statusCode == 200) {
      //print(response.body);
      return PhoneDetails.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
