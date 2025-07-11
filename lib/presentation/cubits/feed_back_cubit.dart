import 'package:ass1/data/models/feed_back_model.dart';
import 'package:ass1/data/repos/feed_back_repo.dart';
import 'package:ass1/presentation/cubits/feed_back_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FeedBackCubit extends Cubit<FeedBackStates> {
  final FeedBackRepo _feedBackRepo;
  FeedBackCubit(FeedBackRepo feedBackRepo)
    : _feedBackRepo = feedBackRepo,
      super(FeedBackInitial());

  Future<void> sendFeedBack(FeedBackModel feedBackModel) async {
    try {
      emit(FeedBackLoading());
      await _feedBackRepo.sendFeedBack(feedBackModel);
      List<FeedBackModel> feedBacks = await _feedBackRepo.getFeedbacks();
      emit(FeedBackLoaded(feedBacks: feedBacks));
    } catch (e) {
      emit(FeedBackError(message: e.toString()));
    }
  }
}
