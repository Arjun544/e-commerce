import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/home_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../models/product_Model.dart';
import 'package:get/get.dart';

import 'search_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final HomeScreenController homeScreenController = Get.find();

  @override
  String get searchFieldLabel => 'Search products';

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey.withOpacity(0.7),
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/images/Arrow - Left.svg',
        color: darkBlue.withOpacity(0.7),
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'Search term must be longer than two letters.',
            ),
          )
        ],
      );
    }

    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      homeScreenController.searchProduct(page: 1, query: query);
    }
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'Search term must be longer than two letters.',
            ),
          )
        ],
      );
    }
    return StreamBuilder(
        stream: homeScreenController.searchStreamController.stream,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          return snapshot.data!.results.isEmpty
              ? const Center(
                  child: Text(
                    'No Products found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data!.results.length} products ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.results.length,
                            padding: const EdgeInsets.only(top: 15),
                            itemBuilder: (context, index) {
                              log(snapshot.data!.results[index].toString());
                              return SearchItem(
                                query: query,
                                product: snapshot.data!.results[index],
                              );
                            }),
                      ),
                    ],
                  ),
                );
        });
  }
}
