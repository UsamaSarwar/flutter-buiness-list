// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class Business {
  final String name;
  final String location;
  final String contactNo;

  Business({required this.name, required this.location, required this.contactNo});

  factory Business.fromJson(Map<String, dynamic> json) {
    // Normalize and validate messy keys
    final name = json['biz_name']?.toString().trim() ?? '';
    final location = json['bss_location']?.toString().trim() ?? '';
    final contactNo = json['contct_no']?.toString().trim() ?? '';
    if (name.isEmpty || location.isEmpty || contactNo.isEmpty) {
      throw FormatException('Invalid business data');
    }
    return Business(name: name, location: location, contactNo: contactNo);
  }
}

class BusinessProvider with ChangeNotifier {
  List<Business> _businesses = [];
  bool _loading = false;
  String? _error;

  List<Business> get businesses => _businesses;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchBusinesses() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('businesses_cache');
      if (cached != null) {
        final List<dynamic> data = json.decode(cached);
        _businesses = data.map((e) => Business.fromJson(e)).toList();
        _loading = false;
        notifyListeners();
        return;
      }
      // Use Dio for local asset fetch
      final dio = Dio();
      final response = await rootBundle.loadString('assets/businesses.json');
      final List<dynamic> data = json.decode(response);
      _businesses = data.map((e) => Business.fromJson(e)).toList();
      // Cache for offline use
      await prefs.setString('businesses_cache', json.encode(data));
    } catch (e) {
      _error = 'Failed to load businesses';
    }
    _loading = false;
    notifyListeners();
  }
}
