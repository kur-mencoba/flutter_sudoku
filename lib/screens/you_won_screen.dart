import 'package:flutter/material.dart';
import 'package:flutter_sudoku/screens/play_screen.dart';
import 'package:flutter_sudoku/screens/home_screen.dart';
import 'package:flutter_sudoku/utils/enums.dart';
import 'package:flutter_sudoku/widgets/main_button.dart';

class YouWonScreen extends StatelessWidget {
  final int minutes;
  final int seconds;
  final GameMode mode;

  const YouWonScreen({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Congratulation\n$minutes minutes and $seconds seconds',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 150),
              SizedBox(
                width: 200, 
                child: MainButton(
                  text: 'Play again',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return PlayScreen(
                          mode: mode,
                        );
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 200, 
                child: MainButton(
                  text: 'Go home',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
