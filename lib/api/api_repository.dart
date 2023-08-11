import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_constants.dart';


class ApiRepository {
 ///Login
  Future<dynamic> loginCall(String mobile, String password) async {
    
    final res = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.signInUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "mobile": mobile.toString(),
          "password": password.toString()
        }));
        
    return jsonDecode(res.body);
  }

   Future<dynamic> usersListCall(String token) async {
    
    final res = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.profileList),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "limit": 50,        
        }));
        
    return jsonDecode(res.body);
   
  }




  // Future<dynamic> login(LoginRequest data) async {
  //   final res = await apiProvider.login(
  //       ApiConstants.signInUrl + ApiConstants.apiKey, data);
  //   if (res.statusCode == 200) {
  //     return LoginResponse.fromJson(res.body);
  //   }
  // }

  // Future<RegisterResponse?> register(RegisterRequest data) async {
  //   final res = await apiProvider.register(
  //       ApiConstants.signUpUrl + ApiConstants.apiKey, data);
  //   if (res.statusCode == 200) {
  //     return RegisterResponse.fromJson(res.body);
  //   }
  // }

  // Future<UserDatabaseResponse?> registerUserToDB(
  //     UserDatabaseRequest data) async {
  //   final res = await http.post(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users.json'),
  //       headers: {'Accept': 'application/json'},
  //       body: data.toRawJson());
  //   if (res.statusCode == 200) {
  //     return UserDatabaseResponse.fromJson(jsonDecode(res.body));
  //   }
  // }

  // Future<Users?> getUsers(GetUserRequest data) async {
  //   final res = await apiProvider.getUsers(
  //       ApiConstants.getUserUrl + ApiConstants.apiKey, data);
  //   if (res.statusCode == 200) {
  //     return Users.fromJson(res.body['users'][0]);
  //   }
  // }

  // Future<UserDatabaseResponse?> updateUserLocation(
  //     String lat, String long, dbId) async {
  //   final res = await http.patch(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users/' + dbId + '.json'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'locLat': lat.toString(),
  //         'locLong': long.toString(),
  //       }));
  //   if (res.statusCode == 200) {
  //     return UserDatabaseResponse.fromJson(jsonDecode(res.body));
  //   }
  // }

  // Future<UserDatabaseResponse?> getUserFromDb(dbId) async {
  //   final res = await http.get(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users/' + dbId + '.json'));
  //   if (res.statusCode == 200) {
  //     return UserDatabaseResponse.fromJson(jsonDecode(res.body));
  //   }
  // }

  // Future<dynamic> getAllUsers() async {
  //   final res = await http
  //       .get(Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users.json'));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getDbId(id) async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/users.json?orderBy="localId"&equalTo="' +
  //       id +
  //       '"'));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getUserFromDbAllDrivers() async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/users.json?orderBy="type"&equalTo="driver"'));
  //   print(res.body);
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getUserFromDbAllParents() async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/users.json?orderBy="type"&equalTo="parent"'));
  //   print(res.body);
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getRelationIdByParent(id) async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/relations.json?orderBy="parentId"&equalTo="' +
  //       id +
  //       '"'));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getRelationIdByDriver(id) async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/relations.json?orderBy="driverId"&equalTo="' +
  //       id +
  //       '"'));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> getRelationIdBySchool(id) async {
  //   final res = await http.get(Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //       '/relations.json?orderBy="schoolId"&equalTo="' +
  //       id +
  //       '"'));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> updateFCMToken(String token, dbId) async {
  //   final res = await http.patch(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users/' + dbId + '.json'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'fcmToken': token.toString(),
  //       }));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<String?> acceptUser(String dbId) async {
  //   final res = await http.patch(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users/' + dbId + '.json'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'status': "accepted",
  //       }));
  //   if (res.statusCode == 200) {
  //     return "accepted";
  //   }
  // }

  // Future<dynamic> updateUserProfile(String displayName, String address,
  //     String contactNumber, String dbId) async {
  //   final res = await http.patch(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl + '/users/' + dbId + '.json'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'displayName': displayName.toString(),
  //         'address': address.toString(),
  //         'contactNumber': contactNumber.toString(),
  //       }));
  //   print(res.body);
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> sendNotif(String token, String title, String body) async {
  //   final res =
  //       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Authorization':
  //                 'Bearer AAAAKPR5x80:APA91bHFiLikrH7rT5txmUzqSUjww_c_YQcmtYPANs2AXjygRkVmg5CUHlnFwK6sxjK0yaLL5bP7VJoqcW5C8dLNPRA6WAupMN5iAlyattX0C9R7sGSaHT4t2p_hm2hD8WBjPMkSZTVA'
  //           },
  //           body: jsonEncode({
  //             "to": token.toString(),
  //             "priority": "high",
  //             "notification": {
  //               "body": body.toString(),
  //               "title": title.toString(),
  //               "title_loc_key": "10"
  //             }
  //           }));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }

  // Future<dynamic> updateParentOfTheirDriverId(
  //     String driverId, relationId) async {
  //   final res = await http.patch(
  //       Uri.parse(ApiConstants.dbRealtimeBaseUrl +
  //           '/relations/' +
  //           relationId +
  //           '.json'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'driverId': driverId.toString(),
  //       }));
  //   if (res.statusCode == 200) {
  //     return jsonDecode(res.body);
  //   }
  // }
}
