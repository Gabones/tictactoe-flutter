import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../builders/build_main_content.dart';
import '../builders/build_color_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: kIsWeb || Platform.isAndroid || Platform.isIOS ? primaryColor : Colors.transparent,
      body: kIsWeb
          ? buildMainContent(context)
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: primaryColor,
                border: Border.all(color: Colors.transparent),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux))
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async => await windowManager.minimize(),
                            child: const Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white38)),
                          ),
                          TextButton(
                            onPressed: () async => {
                              await windowManager.isMaximized() ? windowManager.restore() : windowManager.maximize()
                            },
                            child: const Icon(
                              Icons.maximize,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.white38)),
                          ),
                          TextButton(
                            onPressed: () async => await windowManager.close(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.white38),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(18),
                                  ),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  buildMainContent(context),
                ],
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.settings,
          color: primaryColor,
        ),
        onPressed: () => buildColorDialog(context),
        backgroundColor: Colors.white,
      ),
    );
  }
}
