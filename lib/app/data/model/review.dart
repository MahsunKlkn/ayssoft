class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] as int,
      comment: (json['comment'] ?? '') as String,
      date: (json['date'] ?? '') as String,
      reviewerName: (json['reviewerName'] ?? '') as String,
      reviewerEmail: (json['reviewerEmail'] ?? '') as String,
    );
  }
}