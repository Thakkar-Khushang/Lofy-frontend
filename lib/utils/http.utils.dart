import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lofy_frontend/utils/auth.utils.dart';

import 'package:lofy_frontend/utils/error.utils.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

const _baseUrl = "lofy-backend.herokuapp.com";

dynamic _returnResponse(http.Response response) async {
  debugPrint(response.body.toString());
  switch (response.statusCode) {
    case 201:
    case 200:
      if (response.body.toString() == "") {
        return null;
      }
      var responseJson = json.decode(response.body.toString());
      debugPrint(responseJson.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      showSnackBar("Unauthorized: Signing Out");
      // await logOut();
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw NotFoundException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

Future<dynamic> getUnauth(String url, {dynamic query}) async {
  debugPrint('Api Unauth Get, url $url');
  var responseJson;
  try {
    final response = await http.get(
      (query != null)
          ? Uri.https(_baseUrl, url, query)
          : Uri.https(_baseUrl, url),
    );
    responseJson = _returnResponse(response);
  } on SocketException {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  } catch (e) {
    debugPrint("HTTP Error-----------: $e");
    rethrow;
  }
  debugPrint('api Unauth get recieved!');
  return responseJson;
}

// Auth Get Api
Future<dynamic> getAuth(String url, {dynamic query}) async {
  debugPrint('Api Auth Get, url $url');
  var responseJson;
  try {
    dynamic token = await getToken();
    if (token == null) {
      await logOut();
    } else {
      final response = await http.get(
        (query != null)
            ? Uri.https(_baseUrl, url, query)
            : Uri.https(_baseUrl, url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
        },
      );

      responseJson = _returnResponse(response);
    }
  } on SocketException {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  } catch (e) {
    debugPrint("HTTP Error-----------: ${e.toString()}");
    rethrow;
  }
  debugPrint('api Auth get recieved!');
  return responseJson;
}

// UnAuth Post Api
Future<dynamic> postUnauth(String url, String body, {dynamic query}) async {
  debugPrint('Api Unauth Post, url $url');
  var responseJson;
  try {
    final response = await http.post(
        (query != null)
            ? Uri.https(_baseUrl, url, query)
            : Uri.https(_baseUrl, url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    responseJson = _returnResponse(response);
  } on SocketException {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  } catch (e) {
    debugPrint("HTTP Error-----------: $e");
    rethrow;
  }
  debugPrint('api Unauth Post recieved!');
  return responseJson;
}

// Auth Post Api
Future<dynamic> postAuth(String url, dynamic body, {dynamic query}) async {
  debugPrint('Api Auth Post, url $url');
  var responseJson;
  try {
    var token = await getToken();
    if (token == null) {
      await logOut();
    } else {
      final response = await http.post(
        (query != null)
            ? Uri.https(_baseUrl, url, query)
            : Uri.https(_baseUrl, url),
        body: body,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer " + token,
        },
      );
      responseJson = _returnResponse(response);
    }
  } on SocketException {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  } catch (e) {
    debugPrint("HTTP Error-----------: $e");
    rethrow;
  }
  debugPrint('api Auth Post recieved!');
  return responseJson;
}

// Auth Post Api
Future<dynamic> patchAuth(String url, dynamic body, {dynamic query}) async {
  debugPrint('Api Auth Patch, url $url');
  var responseJson;
  try {
    var token = await getToken();
    if (token == null) {
      await logOut();
    } else {
      final response = await http.patch(
        (query != null)
            ? Uri.https(_baseUrl, url, query)
            : Uri.https(_baseUrl, url),
        body: body,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer " + token,
        },
      );
      responseJson = _returnResponse(response);
    }
  } on SocketException {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  } catch (e) {
    debugPrint("HTTP Error-----------: $e");
    rethrow;
  }
  debugPrint('api Auth Post recieved!');
  return responseJson;
}
