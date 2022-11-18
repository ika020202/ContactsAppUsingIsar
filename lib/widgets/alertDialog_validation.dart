import 'package:flutter/material.dart';

class AlertDialogValidation extends StatelessWidget {
  const AlertDialogValidation({Key? key, required this.messsage})
      : super(key: key);
  final String messsage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Validation Error'),
      content: Text(messsage),
      actions: <Widget>[
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
