import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pacman/ghost.dart';
import 'package:pacman/path.dart';
import 'package:pacman/pixel.dart';
import 'package:pacman/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSqaures = numberInRow * 17;
  int player = (numberInRow * 15) + 1;
  int ghost = (numberInRow * 2) - 2;
  int ghost2 = (numberInRow * 16) - 2;
  int ghost3 = (numberInRow * 2) + 2;
  List<int> food = [];
  int score = 0;
  bool startState = true;
  bool preGame = true;
  bool gameOver = false;
  bool win = false;
  String direction = "";
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    98,
    87,
    76,
    65,
    54,
    43,
    32,
    21, //maze starts
    14, 25, 36, 35,
    18, 29, 40, 41,
    168, 157, 146, 145,
    172, 161, 150, 151,
    89, 90, 91,
    97, 96, 95,
    59, 60, 61, 70, 71, 72,
    114, 115, 116, 125, 126, 127
  ];

  void start() {
    preGame = false;
    getFood();
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      moveGhost();
      if (food.contains(player)) {
        food.remove(player);
        score++;
      }
      if (player == ghost || player == ghost2 || player == ghost3) {
        gameOver = true;
      }
      if (food.length == 0) {
        win = false;
      }
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }

  void getFood() {
    for (int i = 0; i < numberOfSqaures; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  moveGhost() {
    Random random = new Random();
    Random random2 = new Random();
    Random random3 = new Random();
    int motion = random.nextInt(4);
    int motion2 = random2.nextInt(4);
    int motion3 = random3.nextInt(4);

    switch (motion) {
      case 0:
        if (!barriers.contains(ghost - 1)) {
          setState(() {
            ghost--;
          });
        }
        break;
      case 1:
        if (!barriers.contains(ghost + 1)) {
          setState(() {
            ghost++;
          });
        }
        break;
      case 2:
        if (!barriers.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
          });
        }
        break;
      case 3:
        if (!barriers.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
          });
        }
        break;
    }
    switch (motion2) {
      case 0:
        if (!barriers.contains(ghost2 - 1)) {
          setState(() {
            ghost2--;
          });
        }
        break;
      case 1:
        if (!barriers.contains(ghost2 + 1)) {
          setState(() {
            ghost2++;
          });
        }
        break;
      case 2:
        if (!barriers.contains(ghost2 - numberInRow)) {
          setState(() {
            ghost2 -= numberInRow;
          });
        }
        break;
      case 3:
        if (!barriers.contains(ghost2 + numberInRow)) {
          setState(() {
            ghost2 += numberInRow;
          });
        }
        break;
    }
    switch (motion3) {
      case 0:
        if (!barriers.contains(ghost3 - 1)) {
          setState(() {
            ghost3--;
          });
        }
        break;
      case 1:
        if (!barriers.contains(ghost3 + 1)) {
          setState(() {
            ghost3++;
          });
        }
        break;
      case 2:
        if (!barriers.contains(ghost3 - numberInRow)) {
          setState(() {
            ghost3 -= numberInRow;
          });
        }
        break;
      case 3:
        if (!barriers.contains(ghost3 + numberInRow)) {
          setState(() {
            ghost3 += numberInRow;
          });
        }
        break;
    }
  }

  void play() {
    player = (numberInRow * 15) + 1;
    ghost = (numberInRow * 2) - 2;
    ghost2 = (numberInRow * 16) - 2;
    ghost3 = (numberInRow * 2) + 2;
    food = [];
    score = 0;
    startState = false;
    preGame = true;
    gameOver = false;
    win = false;
    start();
  }

  @override
  Widget build(BuildContext context) {
    if (startState) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GestureDetector(
            onTap: play,
            child: Text("P L A Y ! !",
                style: TextStyle(fontSize: 50, color: Colors.yellow)),
          ),
        ),
      );
    } else if (gameOver) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: play,
                child: Text("GAME OVER ! !",
                    style: TextStyle(fontSize: 50, color: Colors.yellow)),
              ),
              Text("Score: " + score.toString(),
                  style: TextStyle(fontSize: 50, color: Colors.yellow)),
            ],
          ),
        ),
      );
    } else if (win) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: play,
                child: Text("YOU WON ! !",
                    style: TextStyle(fontSize: 50, color: Colors.yellow)),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0) {
                      direction = "down";
                    } else if (details.delta.dy < 0) {
                      direction = "up";
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0) {
                      direction = "right";
                    } else if (details.delta.dx < 0) {
                      direction = "left";
                    }
                  },
                  child: Container(
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: numberOfSqaures,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: numberInRow),
                          itemBuilder: (BuildContext context, int index) {
                            if (ghost == index ||
                                ghost2 == index ||
                                ghost3 == index) {
                              return Ghost();
                            }
                            if (player == index) {
                              switch (direction) {
                                case "left":
                                  return Transform.rotate(
                                    angle: pi,
                                    child: Player(),
                                  );
                                  break;
                                case "right":
                                  return Player();
                                  break;
                                case "up":
                                  return Transform.rotate(
                                    angle: 3 * pi / 2,
                                    child: Player(),
                                  );
                                  break;
                                case "down":
                                  return Transform.rotate(
                                    angle: pi / 2,
                                    child: Player(),
                                  );
                                  break;
                                default:
                                  return Player();
                              }
                            } else if (barriers.contains(index)) {
                              return MyPixel(
                                innercolor: Colors.blue[800],
                                outercolor: Colors.blue[900],
                                //child: Text(index.toString())
                              );
                            } else if (food.contains(index) || preGame) {
                              return MyPath(
                                innercolor: Colors.yellow,
                                outercolor: Colors.black,
                                //child: Text(index.toString())
                              );
                            } else
                              return MyPath(
                                innercolor: Colors.black,
                                outercolor: Colors.black,
                                //child: Text(index.toString())
                              );
                          })),
                )),
            Expanded(
              child: Container(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Score: " + score.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
