import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/utils/constants/colors.dart';
import 'package:newsapp/utils/constants/sizes.dart';
import 'package:newsapp/views/detail_screen.dart';
import 'package:newsapp/views/widgets/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        title: const Icon(CupertinoIcons.line_horizontal_3, size: 28),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
            child: Row(
              children: [
                Icon(CupertinoIcons.search, size: 28),
                SizedBox(width: TSizes.spaceBtwItems),
                Icon(CupertinoIcons.bell, size: 28),
                SizedBox(width: TSizes.spaceBtwItems),
                Icon(CupertinoIcons.profile_circled, size: 28),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
          child: Column(
            children: [
              ///Banner
              Obx(() {
                if (controller.isLoading.value) {
                  return CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: TColors.light,
                          ),
                          child: const ShimmerEffect(
                              width: double.infinity, height: double.infinity));
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      height: 220,
                    ),
                  );
                }
                return CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) {
                    final bannerArticle = controller.bannerArticles[index];
                    return GestureDetector(
                      onTap: ()=>Get.to(DetailScreen(title: bannerArticle.title, imageUrl: bannerArticle.image, publisher: bannerArticle.publishedAt, date: bannerArticle.publishedAt, content: bannerArticle.content, readMoreUrl: bannerArticle.url)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: TColors.light,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: bannerArticle.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                fadeOutDuration:
                                    const Duration(milliseconds: 200),
                                fadeInDuration: const Duration(milliseconds: 200),
                                errorWidget: (context, url, error) {
                                  print('Image loading error: $error');
                                  return const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: TColors.warning,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      '${bannerArticle.sourceName} • ${bannerArticle.publishedAt}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      bannerArticle.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    height: 220,
                  ),
                );
              }),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Top News
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Stories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  Text("See all",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: TColors.darkerGrey))
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (_, index) => const Padding(
                      padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                      child: ShimmerEffect(height: 140, width: double.infinity),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.articles.length,
                  itemBuilder: (_, index) {
                    final article = controller.articles[index];
                    return GestureDetector(
                      onTap: ()=>Get.to(DetailScreen(title: article.title, imageUrl: article.image, publisher: article.publishedAt, date: article.publishedAt, content: article.content, readMoreUrl: article.url)),
                      child: Container(
                        margin:
                            const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                        padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                        decoration: BoxDecoration(
                          color: TColors.softGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: article.image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fadeOutDuration:
                                          const Duration(milliseconds: 200),
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline,
                                              color: TColors.warning, size: 40),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        article.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${article.publishedAt} • ${article.sourceName}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.bookmark_border,
                                        color: Colors.grey[400], size: 20),
                                    const SizedBox(width: 12),
                                    Icon(Icons.more_vert,
                                        color: Colors.grey[400], size: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 75,
        elevation: 0,
        backgroundColor: TColors.softGrey,
        indicatorColor: TColors.white.withOpacity(0.1),
        destinations: const [
          NavigationDestination(
              icon: Icon(Iconsax.document_text), label: 'Feed'),
          NavigationDestination(
              icon: Icon(CupertinoIcons.compass), label: 'Explore'),
          NavigationDestination(icon: Icon(Iconsax.save_2), label: 'Saved'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
