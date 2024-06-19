import 'package:flutter/material.dart';
import 'package:flutter_sudoku/screens/play_screen.dart';
import 'package:flutter_sudoku/utils/enums.dart';
import 'package:flutter_sudoku/widgets/main_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Flutter Sudoku',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              width: 200, 
              child: MainButton(
                text: 'Easy',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const PlayScreen(
                        mode: GameMode.easy,
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
                text: 'Normal',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const PlayScreen(
                        mode: GameMode.normal,
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
                text: 'Hard',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const PlayScreen(
                        mode: GameMode.hard,
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
