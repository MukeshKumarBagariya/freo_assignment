import 'dart:async';
import 'dart:convert';
import 'package:freo_assignment/models/search_result_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart' as rx;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchController extends GetxController {
  var searchResults = <SearchResultModel>[].obs;
  var isSearching = false.obs;
  final searchQuerySubject = BehaviorSubject<String>();
  late StreamSubscription<String> debounceStream;
  static const String cacheKey = 'search_results_cache';

  //loding the cached search results from SharedPreferences
  Future<void> loadCachedResults() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedResults = prefs.getString(cacheKey);

    if (cachedResults != null) {
      print("Inside me ");
      final decodedResults = json.decode(cachedResults);
      searchResults.value = [SearchResultModel.fromJson(decodedResults)];
    }
  }

  // storing the cache search results as JSON
  Future<void> cacheResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsToCache = searchResults.isNotEmpty ? searchResults[0].toJson() : null;

    if (resultsToCache != null) {
      await prefs.setString(cacheKey, json.encode(resultsToCache));
    }
  }


  SearchController() {
    //using the debounce because it will help to reduce the api call and inefficient buffering of data.
    debounceStream = searchQuerySubject.stream.debounce((event) => rx.Rx.timer(event, const Duration(seconds: 1)))
        .listen((query){
      if (query.isNotEmpty) {
        search(query);
      } else {
        clearSearchResults();
      }
    });
  }

  void search(String query) async {
    print("Founded query is $query");
    isSearching.value = true;
    try {
      final Map<String, String> params = {
        "action": "query",
        "format": "json",
        "prop": "pageimages|pageterms",
        "list": "",
        "titles": "$query",
        "generator": "prefixsearch",
        "redirects": "1",
        "formatversion": "2",
        "piprop": "thumbnail",
        "pilimit": "10",
        "wbptterms": "description",
        "gpssearch": "$query",
      };

      final Uri uri = Uri.https(
        'en.wikipedia.org',
        '/w/api.php',
        params,
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Founded response is ${data}");
        searchResults.value = [SearchResultModel.fromJson(data)];
        cacheResults();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isSearching.value = false;
    }
  }

  void clearSearchResults() {
    searchResults.clear();
  }

  @override
  void dispose() {
    debounceStream.cancel();
    searchQuerySubject.close();
    super.dispose();
  }

}