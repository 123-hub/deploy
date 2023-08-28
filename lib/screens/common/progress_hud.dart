import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProgressHud extends StatelessWidget {
  const ProgressHud({
    super.key,
    required this.inAsyncCall,
    required this.child,
  });

  final bool inAsyncCall;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: primeryRed,
      ),
      blur: 2,
      inAsyncCall: inAsyncCall,
      child: child,
    );
  }
}
