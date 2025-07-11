import 'dart:developer';

import 'package:ass1/data/models/feed_back_model.dart';
import 'package:ass1/presentation/cubits/feed_back_cubit.dart';
import 'package:ass1/presentation/cubits/feed_back_states.dart';
import 'package:ass1/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackViewBody extends StatefulWidget {
  const FeedBackViewBody({super.key});

  @override
  State<FeedBackViewBody> createState() => _FeedBackViewBodyState();
}
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController messageController = TextEditingController();
final _formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
String? selectedRating;

class _FeedBackViewBodyState extends State<FeedBackViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CustomTextFromFiled(
                autovalidateMode: autovalidateMode,
                label: 'Name',
                controller: nameController,
                multiLine: false,
              ),

              CustomTextFromFiled(
                autovalidateMode: autovalidateMode,
                label: 'Email',
                controller: emailController,
                multiLine: false,
              ),

              CustomTextFromFiled(
                autovalidateMode: autovalidateMode,
                label: 'FeedBack Message',
                controller: messageController,
                multiLine: true,
              ),

              DropdownButtonFormField<String>(
                autovalidateMode: autovalidateMode,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a rating';
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                items: List.generate(5, (index) {
                  final value = (index + 1).toString();
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedRating = value;
                  });
                  print('Selected rating: $value');
                },
              ),
              BlocListener<FeedBackCubit, FeedBackStates>(
                listener: (context, state) {
                  if (state is FeedBackError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    log(state.message);
                  } else if (state is FeedBackLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('FeedBack Sent')),
                    );
                    _showAlertDialog(state.feedBacks[0]);
                  } else if (state is FeedBackLoading) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Loading...')));
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FeedBackModel feedBackModel = FeedBackModel(
                        fullName: nameController.text,
                        email: emailController.text,
                        feedBackMessage: messageController.text,
                        rating: selectedRating!,
                      );
                      context.read<FeedBackCubit>().sendFeedBack(feedBackModel);
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAlertDialog(FeedBackModel feedBackModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(child: Text(feedBackModel.fullName)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('email: ${feedBackModel.email}'),
              Text('Message: ${feedBackModel.feedBackMessage}'),
              Text('Rating: ${feedBackModel.rating}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
