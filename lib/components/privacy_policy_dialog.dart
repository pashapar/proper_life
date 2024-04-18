import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:proper_life/theme/theme.dart';

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({super.key, required this.mdFileName});
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 150))
                      .then((value) {
                    return rootBundle
                        .loadString('assets/privacy_policy/$mdFileName');
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(data: snapshot.data.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    );
                  })),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(theme.primaryColor),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))))),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              alignment: Alignment.center,
              height: 50,
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
