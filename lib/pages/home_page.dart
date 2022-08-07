import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.deepPurple, border: Border.all(color: Colors.transparent)),
        height: 600,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
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
      )
    );
  }
}
