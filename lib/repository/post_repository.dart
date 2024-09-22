import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_state/model/posts_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Repository responsible for fetching posts from the API
class PostRepository {

  /// Fetches posts from a remote API and returns a list of PostModel objects
  Future<List<PostModel>> fetchPost() async {
    try {
      // Sends an HTTP GET request to the specified URL with a 10-second timeout
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'))
          .timeout(const Duration(seconds: 10));

      // Decodes the response body into a list of dynamic objects
      final body = json.decode(response.body) as List;

      // Debugging logs to check the status code and response body
      if (kDebugMode) {
        print(response.statusCode.toString());
        print(body);
      }

      // Checks if the response status code is 200 (success)
      if (response.statusCode == 200) {
        // Maps each dynamic object in the body to a PostModel object and returns the list
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PostModel(
            postId: map['postId'] as int,
            id: map['id'] as int,
            name: map['name'] as String,
            email: map['email'] as String,
            body: map['body'] as String,
          );
        }).toList();
      }
    } on SocketException {
      // If there's no internet connection, throws a 'No Internet Connection' exception
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      // If the request times out, throws a 'TimeoutException' with an empty message
      throw Exception('Request Timed Out');
    }

    // Throws a generic exception if fetching data fails
    throw Exception('Error fetching data');
  }
}
