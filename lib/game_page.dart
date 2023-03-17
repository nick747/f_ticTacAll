import 'dart:ui';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String playerX = "X";
  static const String playerO = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = playerX;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""]; //9 empty places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TicTac-All!",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _headerText(),
              const SizedBox(
                height: 20,
              ),
              _gameContainer(),
              const Spacer(),
              _restartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "X",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
              decorationThickness: 4,
              decorationColor:
                  (currentPlayer == "X") ? Colors.black : Colors.white,
            ),
          ),
          Text(
            "O",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
              decorationThickness: 4,
              decorationColor:
                  (currentPlayer == "X") ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        //on click of box
        if (gameEnd || occupied[index].isNotEmpty) {
          //Return if game already ended or box already clicked
          return;
        }

        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xff363636),
              width: 3,
            )),
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  _restartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              initializeGame();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF363636), // Set background color
            shape: RoundedRectangleBorder(
              // Set border radius
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            " R I G I O C A ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }

  changeTurn() {
    if (currentPlayer == playerX) {
      currentPlayer = playerO;
    } else {
      currentPlayer = playerX;
    }
  }

  checkForWinner() {
    //Define winning positions
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          //all equal means player won
          showGameOverMessage("$playerPosition0 ha vinto");
          gameEnd = true;
          return;
        }
      }
    }
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        //at least one is empty not all are filled
        draw = false;
      }
    }

    if (draw) {
      showGameOverMessage("Pareggio");
      gameEnd = true;
    }
  }

  showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: const Color(0xff363636),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          )),
    );
  }
}
