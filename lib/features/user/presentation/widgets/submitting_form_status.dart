import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class SubmittingFormStatus extends StatelessWidget {
  final String labelText;
  const SubmittingFormStatus({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      } else {
        return Text(
          labelText,
          style: const TextStyle(color: Colors.white),
        );
      }
    });
  }
}
