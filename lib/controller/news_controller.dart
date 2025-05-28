import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var bannerArticles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
    getBannerNews();
  }

  void getBannerNews() async {
    try {
      isLoading.value = true;
      bannerArticles.value = await NewsService.fetchBannerNews();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not fetch banner $e',
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      var result = await NewsService.fetchNews();
      articles.assignAll(result);
        } finally {
      isLoading(false);
    }
  }

  void readFullArticle({required String readMoreUrl}) async{
    final Uri url = Uri.parse(readMoreUrl);
    final bool success = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
    if (!success) {
      Get.snackbar(
        'Error',
        'Could not open Link',
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
    }
  }
}
