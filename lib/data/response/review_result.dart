part of 'responses.dart';

class ReviewResult {
  bool error;
  String message;
  List<Review> reviews;

  ReviewResult({
    required this.error,
    required this.message,
    required this.reviews,
  });

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
        error: json['error'],
        message: json['message'],
        reviews: List<Review>.from(
          (json['customerReviews'] as List).map((e) => Review.fromJson(e)),
        ),
      );
}
