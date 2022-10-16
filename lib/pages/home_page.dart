import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../provider/game.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = context.read<Game>().getArray.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () => {
        if(!context.read<Game>().endGame && context.read<Game>().getArray[x][y] == ''){
          context.read<Game>().setValue(x, y, context.read<Game>().player)
        }
      },
      child: GridTile(
        child: Card(
          color: context.read<Game>().color[x][y],
          child: Center(
            child: Text(
              '${context.watch<Game>().getArray[x][y]}',
              style: const TextStyle(fontSize: 40, color: Colors.deepPurple),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildMainContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            !context.read<Game>().endGame ?
            'Vez do (${context.watch<Game>().player.toUpperCase()}) jogar' :
            context.read<Game>().player == 'Nenhum' ?
            'Empate!' :
            'O player ${context.watch<Game>().player.toUpperCase()} venceu!',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.height * 0.6),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child:
            GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: pow(context.read<Game>().getArray.length, 2) as int,
                itemBuilder: _buildGridItems
            ),
          ),
          if(context.read<Game>().endGame)
            IconButton(
              onPressed: () => context.read<Game>().resetGame(),
              icon: const Icon(Icons.replay),
              color: Colors.white,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? Colors.deepPurple : Colors.transparent,
      body: kIsWeb
          ? _buildMainContent(context)
          : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.deepPurple,
                  border: Border.all(color: Colors.transparent),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  if(!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux))
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
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.white38)
                            ),
                          ),
                          TextButton(
                            onPressed: () async => {
                              await windowManager.isMaximized() ? windowManager.restore() : windowManager.maximize()
                            },
                            child: const Icon(
                              Icons.maximize,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.white38)
                            ),
                          ),
                          TextButton(
                            onPressed: () async => await windowManager.close(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.white38),
                              shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(18),
                                      ),
                                  )
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildMainContent(context),
                ],
              )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings, color: Theme.of(context).primaryColor,),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
    );
  }
}
