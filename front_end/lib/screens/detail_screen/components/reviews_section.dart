import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/product_Model.dart' as model;
import '../../../utils/colors.dart';
import 'all_reviews_section.dart';

class ReviewsSection extends StatelessWidget {
  final List<model.Review> reviews;
  final int totalReviews;
  const ReviewsSection({required this.reviews, required this.totalReviews});

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          reviews.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'No Reviews',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviews.length == 1 ? 1 : 2,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width * 0.8,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    reviews[index].user.profile == ''
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/profile.png'),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: customGrey,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              reviews[index].user.profile,
                                            ),
                                          ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          toBeginningOfSentenceCase(
                                                  reviews[index]
                                                      .user
                                                      .username) ??
                                              '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.yMMMd().format(
                                              reviews[index].addedAt.addedAt),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      double.parse(reviews[index].number),
                                  updateOnDrag: false,
                                  ignoreGestures: true,
                                  itemSize: 12,
                                  minRating: 1,
                                  maxRating: 5,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => SvgPicture.asset(
                                    'assets/images/Star.svg',
                                    height: 20,
                                    color: customYellow,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              toBeginningOfSentenceCase(
                                      reviews[index].review) ??
                                  '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
          reviews.isEmpty || reviews.length <= 2
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () {
                    Get.to(
                      () => AllReviewsSection(
                        reviews: reviews,
                        totalReviews: totalReviews,
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'show all',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
