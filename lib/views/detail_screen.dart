import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/utils/constants/colors.dart';
import 'package:newsapp/utils/constants/sizes.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.publisher,
      required this.date,
      required this.content,
      required this.readMoreUrl});

  final String title;
  final String imageUrl;
  final String publisher;
  final String date;
  final String content;
  final String readMoreUrl;

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Iconsax.arrow_left_2,
              size: 24,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Iconsax.language_square, size: 24),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Icon(Iconsax.save_2, size: 24),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Icon(Icons.more_vert, size: 24)
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: imageUrl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text(title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    Text(publisher,
                        style: TextStyle(
                          color: TColors.darkerGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text(date,
                        style: TextStyle(
                          color: TColors.darkGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.readFullArticle(readMoreUrl: readMoreUrl);
                        },
                        child: const Text(
                          'Read Full Article',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
