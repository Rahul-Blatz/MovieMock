import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String movieData = response.body;

      var decodedData = jsonDecode(movieData);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
