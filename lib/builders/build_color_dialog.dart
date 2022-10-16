import 'package:flutter/material.dart';
import 'package:jogo_da_velha/provider/theme.dart';
import 'package:provider/provider.dart';

Future<dynamic> buildColorDialog(BuildContext context) {
  final colorTheme = context.read<ThemeProvider>();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, "Close"),
          child: const Text("Close"),
        )
      ],
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.25,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: colorTheme.getColorOptions.length,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(2),
            child: TextButton(
              onPressed: () {
                colorTheme.setPrimaryColor(index);
                Navigator.pop(context);
              },
              child: const Text(""),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      colorTheme.getColorOptions[index]),
                  shape: MaterialStateProperty.all(const CircleBorder())),
            ),
          ),
        ),
      ),
    ),
  );
}
