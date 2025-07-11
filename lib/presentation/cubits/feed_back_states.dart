import 'package:ass1/data/models/feed_back_model.dart';

sealed class FeedBackStates {}

class FeedBackInitial extends FeedBackStates {}

class FeedBackLoading extends FeedBackStates {}

class FeedBackLoaded extends FeedBackStates {
  final List<FeedBackModel> feedBacks;
  FeedBackLoaded({required this.feedBacks});
}

class FeedBackError extends FeedBackStates {
  final String message;
  FeedBackError({required this.message});
}
