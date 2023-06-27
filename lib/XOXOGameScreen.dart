import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class XOXOGameScreen extends StatefulWidget {
  const XOXOGameScreen({super.key});

  @override
  State<XOXOGameScreen> createState() => _XOXOGameScreenState();
}

class _XOXOGameScreenState extends State<XOXOGameScreen> {
  late List<List<String>> board;
  late bool isPlayer1Turn;
  late String winner;
  late bool gameEnded;
  @override
   void initState() {
    super.initState();
    initializeBoard();
  }
   void initializeBoard() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayer1Turn = true;
    winner = '';
    gameEnded = false;
  }
   void makeMove(int row, int col) {
    if (gameEnded || board[row][col] != '') return;

    setState(() {
      board[row][col] = isPlayer1Turn ? 'X' : 'O';
      isPlayer1Turn = !isPlayer1Turn;
      checkWinner();
    });
  }
  
  void checkWinner() {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] &&
          board[row][0] == board[row][2] &&
          board[row][0] != '') {
        winner = board[row][0];
        gameEnded = true;
        return;
      }
    }
    // Check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] &&
          board[0][col] == board[2][col] &&
          board[0][col] != '') {
        winner = board[0][col];
        gameEnded = true;
        return;
      }
    }
     // Check diagonals
    if (board[0][0] == board[1][1] &&
        board[0][0] == board[2][2] &&
        board[0][0] != '') {
      winner = board[0][0];
      gameEnded = true;
      return;
    }
     if (board[0][2] == board[1][1] &&
        board[0][2] == board[2][0] &&
        board[0][2] != '') {
      winner = board[0][2];
      gameEnded = true;
      return;
    }
    
    // Check for a draw
    bool isBoardFull = true;
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          isBoardFull = false;
          break;
        }
      }
    }

    if (isBoardFull) {
      gameEnded = true;
      winner = 'Draw';
    }
  }
    void resetGame() {
    setState(() {
      initializeBoard();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold();
  }
}