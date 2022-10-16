import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/game.dart';

Widget buildGridItems(BuildContext context, int index) {
  int gridStateLength = context.read<Game>().getArray.length;
  int x, y = 0;
  x = (index / gridStateLength).floor();
  y = (index % gridStateLength);
  return GestureDetector(
    onTap: () => {
      if (!context.read<Game>().endGame &&
          context.read<Game>().getArray[x][y] == '')
        {context.read<Game>().setValue(x, y, context.read<Game>().player)}
    },
    child: GridTile(
      child: Card(
        color: context.read<Game>().color[x][y],
        child: Center(
          child: Text(
            '${context.watch<Game>().getArray[x][y]}',
            style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    ),
  );
}
