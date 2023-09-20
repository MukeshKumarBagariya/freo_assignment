import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:freo_assignment/controller/search_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatelessWidget {

  final SearchController controller = Get.put(SearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wiki Search', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 48.0,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // 3D effect offset
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                // controller.search(value);
                controller.searchQuerySubject.add(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                hintText: 'Enter a search query...',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.searchResults.isEmpty && !controller.isSearching.value) {
                return const Center(
                  child: Text(
                    'No results',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              } else if(controller.isSearching.value){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.searchResults[0].query.pages.length,
                  itemBuilder: (context, index) {
                    final result = controller.searchResults[0].query.pages[index];
                    return Card(
                      elevation: 3, // Adjust the elevation for the 3D effect
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Adjust the border radius for rounded corners
                      ),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: result.thumbnail?.source ?? "",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        title: Text(
                          result.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          result.terms?.description[0] ?? "",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onTap: () async {
                          final url = 'https://en.wikipedia.org/wiki/${result.title}';
                          await launchUrl(Uri.parse(url));
                        },
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
