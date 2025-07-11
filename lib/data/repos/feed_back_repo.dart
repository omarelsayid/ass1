import 'package:ass1/data/models/feed_back_model.dart';

abstract class FeedBackRepo {
  Future<void> sendFeedBack(FeedBackModel feedBackModel);
  Future<List<FeedBackModel>> getFeedbacks();
}
