import 'package:flutter/material.dart';
import 'package:flutter_sudoku/logic/generator.dart';
import 'package:flutter_sudoku/models/board.dart';
import 'package:flutter_sudoku/screens/home_screen.dart';
import 'package:flutter_sudoku/screens/you_won_screen.dart';
import 'package:flutter_sudoku/utils/enums.dart';
import 'package:flutter_sudoku/widgets/main_button.dart';
import 'package:flutter_sudoku/widgets/timer_text.dart';

class PlayScreen extends StatefulWidget {
  final GameMode mode;

  const PlayScreen({
    super.key,
    required this.mode,
  });

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  bool isPlaying = true;
  late Board board;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    board = Generator().generateBoard(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.width - 50) / 9;
    return PopScope(
      onPopInvoked: (didPop) async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }),
        );
      },
      child: Scaffold(
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: 30,
                  color: Colors.black.withOpacity(0.5),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                    );
                  },
                ),
              ),
              Center(child: TimerText(isRunning: isPlaying)),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Table(
                  children: getRows(size),
                  border: const TableBorder.symmetric(
                    outside: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    inside: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: 200, 
                  child: MainButton(
                    text: 'Finish',
                    onPressed: () {
                      if (board.isSolutionEmpty()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: SizedBox(
                              child: Text('You have missing fields'),
                            ),
                          ),
                        );
                      } else {
                        if (board.hasRightSolution()) {
                          setState(() {
                            isPlaying = false;
                          });

                          DateTime finishTime = DateTime.now();
                          int seconds = (finishTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch) ~/ 1000;
                          int minutes = seconds ~/ 60;

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return YouWonScreen(
                                seconds: seconds % 60,
                                minutes: minutes,
                                mode: widget.mode,
                              );
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: SizedBox(
                                child: Text('You have incorrect fields'),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customCell(int i, int j, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: (j == 3 || j == 6)
            ? const Border(
                left: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              )
            : null,
      ),
      child: InkWell(
        onTap: board.isSolved[i][j]
            ? null
            : () {
                setState(() {
                  if (board.mySolution[i][j] == 9) {
                    board.mySolution[i][j] = 0;
                  } else {
                    board.mySolution[i][j]++;
                  }
                });
              },
        child: Center(
          child: Text(
            board.isSolved[i][j]
                ? board.data[i][j] == 0
                    ? ''
                    : board.data[i][j].toString()
                : board.mySolution[i][j] == 0
                    ? ''
                    : board.mySolution[i][j].toString(),
            style: TextStyle(
              color: board.isSolved[i][j] ? Colors.blue : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  List<TableCell> getRowCells(int row, double size) {
    return List.generate(
      9,
      (index) => TableCell(
        child: customCell(row, index, size),
      ),
    );
  }

  List<TableRow> getRows(double size) {
    return List.generate(
      9,
      (index) {
        return TableRow(
          children: getRowCells(index, size),
          decoration: BoxDecoration(
              border: (index == 3 || index == 6)
                  ? const Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    )
                  : null),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    isPlaying = false;
  }
}
