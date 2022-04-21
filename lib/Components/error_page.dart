import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({Key? key, this.message = "Something went wrong"})
      : super(key: key);
  final message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        message == "Something went wrong"
            ? Icon(
                Icons.error,
                color: Colors.black,
                size: 50,
              )
            : Container(),
        Text(
          message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
