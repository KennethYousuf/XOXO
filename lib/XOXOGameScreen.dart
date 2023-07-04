import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xoxo/constants/colors.dart';

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
  int oScore = 0;
  int xScore = 0;

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
        if (winner == 'O') {
          oScore++; // Increment score for player O
        } else {
          xScore++; // Increment score for player X
        }
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
        if (winner == 'O') {
          oScore++; // Increment score for player O
        } else {
          xScore++; // Increment score for player X
        }
        return;
      }
    }
    // Check diagonals
    if (board[0][0] == board[1][1] &&
        board[0][0] == board[2][2] &&
        board[0][0] != '') {
      winner = board[0][0];
      gameEnded = true;
      if (winner == 'O') {
        oScore++; // Increment score for player O
      } else {
        xScore++; // Increment score for player X
      }
      return;
    }
    if (board[0][2] == board[1][1] &&
        board[0][2] == board[2][0] &&
        board[0][2] != '') {
      winner = board[0][2];
      gameEnded = true;
      if (winner == 'O') {
        oScore++; // Increment score for player O
      } else {
        xScore++; // Increment score for player X
      }
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
      oScore = 0; // Reset score for player O
      xScore = 0; // Reset score for player X
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.priColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  gameEnded
                      ? 'Winner: $winner'
                      : 'Turn: ${isPlayer1Turn ? "Player X" : "Player O"}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  bool isWinnerCell = false;

                  if (winner != '') {
                    if (board[row][col] == winner) {
                      if (board[row][0] == board[row][1] &&
                          board[row][0] == board[row][2]) {
                        isWinnerCell =
                            true; // Current cell is part of the winning row
                      } else if (board[0][col] == board[1][col] &&
                          board[0][col] == board[2][col]) {
                        isWinnerCell =
                            true; // Current cell is part of the winning column
                      } else if ((row == 0 &&
                              col == 0 &&
                              board[0][0] == board[1][1] &&
                              board[0][0] == board[2][2]) ||
                          (row == 0 &&
                              col == 2 &&
                              board[0][2] == board[1][1] &&
                              board[0][2] == board[2][0]) ||
                          (row == 1 &&
                              col == 1 &&
                              board[0][0] == board[1][1] &&
                              board[0][0] == board[2][2]) ||
                          (row == 1 &&
                              col == 1 &&
                              board[0][2] == board[1][1] &&
                              board[0][2] == board[2][0]) ||
                          (row == 2 &&
                              col == 2 &&
                              board[0][0] == board[1][1] &&
                              board[0][0] == board[2][2]) ||
                          (row == 2 &&
                              col == 0 &&
                              board[0][2] == board[1][1] &&
                              board[0][2] == board[2][0])) {
                        isWinnerCell =
                            true; // Current cell is part of the winning diagonal
                      }
                    }
                  }
                  return GestureDetector(
                    onTap: () {
                      makeMove(row, col);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 5,
                            color: MainColors.priColor,
                          ),
                          color: isWinnerCell
                              ? MainColors.winColor
                              : MainColors.secColor),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                  fontSize: 64,
                                  color: isWinnerCell
                                      ? MainColors.terColor
                                      : MainColors.priColor)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if(gameEnded)
            ElevatedButton.icon(
                onPressed: () {
                  resetGame();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                icon: Icon(
                  Icons.play_circle,
                  color: MainColors.priColor,
                ),
                label: Text(
                  "Play Again!",
                  style: GoogleFonts.bebasNeue(
                      color: MainColors.priColor, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
