import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/game.dart';
import 'build_grid_items.dart';

Widget buildMainContent(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            !context.read<Game>().endGame
                ? 'Vez do (${context.watch<Game>().player.toUpperCase()}) jogar'
                : context.read<Game>().player == 'Nenhum'
                    ? 'Empate!'
                    : 'O player ${context.watch<Game>().player.toUpperCase()} venceu!',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.height * 0.6,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: pow(context.read<Game>().getArray.length, 2) as int,
              itemBuilder: buildGridItems,
            ),
          ),
          if (context.read<Game>().endGame)
            IconButton(
              onPressed: () => context.read<Game>().resetGame(),
              icon: const Icon(Icons.replay),
              color: Colors.white,
            )
        ],
      ),
    );
