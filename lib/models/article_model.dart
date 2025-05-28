import 'package:intl/intl.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final String publishedAt;
  final String sourceName;

  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final date = json['publishedAt'] ?? '';
    final formattedDate = _formatDate(date);

    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      publishedAt: formattedDate,
      sourceName: json['source']['name'] ?? '',
    );
  }

  static String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString).toLocal();
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
