import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, required this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text('Something Went Wrong!', style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),
          Text(
            "We seem to be having some issues right now, but our team is on the case! Please try again.",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (error != null) Text(error!, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
