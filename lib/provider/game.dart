import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Game with ChangeNotifier, DiagnosticableTreeMixin {
  List<List<String>> _list = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

  int _playCount = 0;

  String _player = 'X';

  bool _endGame = false;

  List<List<Color>> _color = [
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white]
  ];

  List get getArray => _list;

  String get player => _player;

  List get color => _color;

  bool get endGame => _endGame;

  void setValue(int x, int y, String valor) {
    _playCount++;
    _list[x][y] = valor;
    Map<String, int> result = checkWinner();
    if (result.containsKey('nada')) {
      if(_playCount == 9) {
        _player = 'Nenhum';
      } else {
        changePlayer();
      }
    } else {
      if (result.containsKey('linha')) {
        int l = result['linha'] as int;
        _color[l] = _player == 'X' ? [Colors.red, Colors.red, Colors.red] : [Colors.blue, Colors.blue, Colors.blue];
      } else if (result.containsKey('coluna')){
        int c = result['coluna'] as int;
        for(int l = 0; l <= 2; l++){
          _color[l][c] = _player == 'X' ? Colors.red : Colors.blue;
        }
      } else if (result.containsKey('diag1')){
        for(int d = 0; d <= 2; d++){
          _color[d][d] = _player == 'X' ? Colors.red : Colors.blue;
        }
      } else {
        for(int d = 0; d <= 2; d++){
          _color[2-d][d] = _player == 'X' ? Colors.red : Colors.blue;
        }
      }
    }

    notifyListeners();
  }

  void changePlayer() {
    _player = _player == 'X' ? 'O' : 'X';
  }

  void resetGame() {
    _player = 'X';
    _playCount = 0;
    _list = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ];
    _color = [
      [Colors.white, Colors.white, Colors.white],
      [Colors.white, Colors.white, Colors.white],
      [Colors.white, Colors.white, Colors.white]
    ];
    _endGame = false;
    notifyListeners();
  }

  Map<String, int> checkWinner() {
    if(_playCount == 9){
      _endGame = true;
    }
    bool _result = false;
    var _arrCol = [], _arrDiag = [], _arrRDiag = [];

    //Loop Colunas
    for (int y = 0; y <= 2; y++) {
      _arrCol = [];
      //Loop Linhas
      for (int x = 0; x <= 2; x++) {
        _result = _list[x].every((element) => element == _player);
        if (_result) {
          _endGame = true;
          return {'linha': x};
        }

        //array de colunas
        _arrCol.add(_list[x][y]);
        if(_arrCol.length == 3){
          _result = _arrCol.every((element) => element == _player);
          if(_result) {
            _endGame = true;
            return {'coluna': y};
          }
        }

        //array de diagonal
        if(x == y){
          _arrDiag.add(_list[x][y]);
          if(_arrDiag.length == 3){
            _result = _arrDiag.every((element) => element == _player);
            if(_result) {
              _endGame = true;
              return { 'diag1': 1 };
            }
          }
        }

        //array de diagonal inversa
        if(x+y == 2){
          _arrRDiag.add(_list[x][y]);
          if(_arrRDiag.length == 3){
            _result = _arrRDiag.every((element) => element == _player);
            if(_result) {
              _endGame = true;
              return { 'diag2' : 1 };
            }
          }
        }

      }
    }
    return {'nada': 0};
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('array', _list));
  }
}
