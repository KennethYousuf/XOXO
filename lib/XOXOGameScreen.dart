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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 68, 174, 255),
      
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                gameEnded
                    ? 'Winner: $winner'
                    : 'Next Turn: ${isPlayer1Turn ? "Player 1 (X)" : "Player 2 (O)"}',
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                final row = index ~/ 3;
                final col = index % 3;
                return GestureDetector(
                  onTap: () {
                    makeMove(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: resetGame,
              child: Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }
}
