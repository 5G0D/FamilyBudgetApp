import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';

Future<String?> loadingDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SizedBox(height: 60, child: Center(child: CircularProgressIndicator(color: Color(0xff5537a1)),),),
      );
    },
  );
}
