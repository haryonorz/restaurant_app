part of 'models.dart';

class Review {
  late String name;
  late String review;
  late String date;

  Review({
    required this.name,
    required this.review,
    required this.date,
  });

  Review.fromJson(Map<String, dynamic> reviews) {
    name = reviews['name'];
    review = reviews['review'];
    date = reviews['date'];
  }
}
