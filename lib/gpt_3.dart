// From: https://raw.githubusercontent.com/boronhub/gpt_3_dart/main/lib/gpt_3_dart.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Param {
  String name;
  dynamic value;

  Param(this.name, this.value);

  @override
  String toString() {
    return '{ $name, $value }';
  }
}

class OpenAI {
  String apiKey;
  OpenAI({required this.apiKey});

  Uri getUrl(function, [engine]) {
    List engineList = ['ada', 'babbage', 'curie', 'davinci'];

    String url = 'https://api.openai.com/v1/images/$function';

    if (engineList.contains(engine)) {
      url = 'https://api.openai.com/v1/engines/$engine/$function';
    }
    return Uri.parse(url);
  }

  Future<String> complete(
    String prompt,
    int maxTokens, {
    num? temperature,
    num? topP,
    int? n,
    bool? stream,
    int? logProbs,
    bool? echo,
    String? engine,
  }) async {
    String apiKey = this.apiKey;
    List data = [];
    data.add(Param('temperature', temperature));
    data.add(Param('top_p', topP));
    data.add(Param('n', n));
    data.add(Param('stream', stream));
    data.add(Param('logprobs', logProbs));
    data.add(Param('echo', echo));
    Map reqData = {};
    for (final item in data) {
      if (item.name != null && item.value != null) {
        reqData[item.name] = item.value;
      }
    }
    reqData["prompt"] = prompt;
    reqData["max_tokens"] = maxTokens;
    var response = await http
        .post(
          getUrl("completions", engine),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 120));

    Map<String, dynamic> json = jsonDecode(response.body);
    if (json.containsKey("error")) {
      throw "ERROR API: ${json["error"]["message"]}";
    }
    List<dynamic> resp = json["choices"];
    return resp[0]["text"];
  }

  Future<List> search(List documents, String query, {engine}) async {
    Map reqData = {"documents": documents, "query": query};
    var response = await http
        .post(
          getUrl("search", engine),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 60));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> resp = map["data"];
    return resp;
  }

  Future<String> image(String prompt) async {
    String apiKey = this.apiKey;

    Map reqData = {};
    reqData["prompt"] = prompt;
    reqData["n"] = 5;
    reqData["size"] = "512x512";
    reqData["response_format"] = "url";

    var response = await http
        .post(
          getUrl("generations", reqData),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 60));

    Map<String, dynamic> map = json.decode(response.body);
    String resp = map["data"][0]["url"];
    return resp;
  }
}
