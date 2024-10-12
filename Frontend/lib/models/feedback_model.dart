class FeedbackModel {
  final String name;
  final String username;
  final String time;
  final String product;
  final String comment;
  final String imageSrc;

  FeedbackModel({
    required this.name,
    required this.username,
    required this.time,
    required this.product,
    required this.comment,
    required this.imageSrc,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      time: json['time'] ?? '',
      product: json['product'] ?? '',
      comment: json['comment'] ?? '',
      imageSrc: json['imageSrc'] ?? '',
    );
  }
}
