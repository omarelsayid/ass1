class FeedBackModel {
  final String fullName;
  final String email;
  final String feedBackMessage;
  final String rating;

  FeedBackModel({
    required this.rating,
    required this.fullName,
    required this.email,
    required this.feedBackMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'feedBackMessage': feedBackMessage,
      'rating': rating,
    };
  }

  factory FeedBackModel.fromMap(Map<String, dynamic> map) {
    return FeedBackModel(
      rating: map['rating'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      feedBackMessage: map['feedBackMessage'] as String,
    );
  }
}
