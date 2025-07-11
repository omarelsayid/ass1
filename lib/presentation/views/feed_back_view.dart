import 'package:ass1/core/service/injectable_service.dart';
import 'package:ass1/presentation/cubits/feed_back_cubit.dart';
import 'package:ass1/presentation/views/widgets/feed_back_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackView extends StatelessWidget {
  const FeedBackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt.get<FeedBackCubit>(),
        child: FeedBackViewBody(),
      ),
    );
  }
}
