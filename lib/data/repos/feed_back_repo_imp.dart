import 'package:ass1/core/service/data_base_service.dart';
import 'package:ass1/data/models/feed_back_model.dart';
import 'package:ass1/data/repos/feed_back_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FeedBackRepo)
class FeedBackRepoImp implements FeedBackRepo {
  final DataBaseService _baseService;

  FeedBackRepoImp({required DataBaseService baseService})
    : _baseService = baseService;
  @override
  Future<List<FeedBackModel>> getFeedbacks() {
    return _baseService.getFeedbacks();
  }

  @override
  Future<void> sendFeedBack(FeedBackModel feedBackModel) {
    return _baseService.insertFeedback(feedBackModel);
  }
}
