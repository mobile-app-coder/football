import 'package:flutter/cupertino.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';

import '../../models/team_model.dart';
import '../../utils/constants/constants.dart';

getTeamPLayers(List<Player> players, bool isTransferPage) {
  List<Player> primaryTeam = List.generate(
    16,
    (index) => Player(),
  );

  Map<String, int> tactic = {
    "MIDFIELDER": 0,
    "GOALKEEPER": 0,
    "DEFENDER": 0,
    "FORWARD": 0,
  };

  List<Player> list = List.generate(
    16,
    (index) => Player(),
  );

  for (var i = 0; i < players.length; i++) {
    if (isTransferPage) {
      switch (players[i].position) {
        case "MIDFIELDER":
          tactic["MIDFIELDER"] = tactic["MIDFIELDER"]! + 1;
          break;
        case "GOALKEEPER":
          tactic["GOALKEEPER"] = tactic["GOALKEEPER"]! + 1;
          break;
        case "DEFENDER":
          tactic["DEFENDER"] = tactic["DEFENDER"]! + 1;
          break;
        case "FORWARD":
          tactic["FORWARD"] = tactic["FORWARD"]! + 1;
          break;
      }
    } else {
      if (players[i].isPrimary ?? false) {
        switch (players[i].position) {
          case "MIDFIELDER":
            tactic["MIDFIELDER"] = tactic["MIDFIELDER"]! + 1;
            break;
          case "GOALKEEPER":
            tactic["GOALKEEPER"] = tactic["GOALKEEPER"]! + 1;
            break;
          case "DEFENDER":
            tactic["DEFENDER"] = tactic["DEFENDER"]! + 1;
            break;
          case "FORWARD":
            tactic["FORWARD"] = tactic["FORWARD"]! + 1;
            break;
        }
      }
    }
  }

  int goalkeeper = 0;
  int midfielder = 0;
  int defender = 0;
  int forward = 0;

  for (var player in players) {
    if (isTransferPage) {
      switch (player.position) {
        case "MIDFIELDER":
          primaryTeam[tactic["DEFENDER"]! +
              tactic["GOALKEEPER"]! +
              midfielder] = player;
          midfielder++;
          break;
        case "GOALKEEPER":
          primaryTeam[goalkeeper] = player;
          goalkeeper++;
          break;
        case "DEFENDER":
          primaryTeam[tactic["GOALKEEPER"]! + defender] = player;
          defender++;
          break;
        case "FORWARD":
          primaryTeam[tactic["MIDFIELDER"]! +
              tactic["DEFENDER"]! +
              tactic["GOALKEEPER"]! +
              forward] = player;
          forward++;
          break;
      }
    } else {
      if (player.isPrimary ?? false) {
        switch (player.position) {
          case "MIDFIELDER":
            primaryTeam[tactic["DEFENDER"]! +
                tactic["GOALKEEPER"]! +
                midfielder] = player;
            midfielder++;
            break;
          case "GOALKEEPER":
            primaryTeam[0] = player;
            break;
          case "DEFENDER":
            primaryTeam[tactic["GOALKEEPER"]! + defender] = player;
            defender++;
            break;
          case "FORWARD":
            primaryTeam[tactic["MIDFIELDER"]! +
                tactic["DEFENDER"]! +
                tactic["GOALKEEPER"]! +
                forward] = player;
            forward++;
            break;
        }
      }
    }
  }

  return [
    [
      tactic["GOALKEEPER"],
      tactic["DEFENDER"],
      tactic["MIDFIELDER"],
      tactic["FORWARD"]
    ],
    primaryTeam
  ];
}

class ChangePlayerFootballField extends StatelessWidget {
  const ChangePlayerFootballField({super.key, required this.controller});

  final MyTeamController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2400,
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/team/football_field.png"),
            fit: BoxFit.fitWidth,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buildList(),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(controller.team.players!, false);
    controller.primaryTeam = players[1];

    List<Widget> list = [];
    int goalKeeper = players[0][0];
    list.add(buildRow(goalKeeper, 0));

    int defender = tactics[controller.tacticsIndex][1];
    list.add(buildRow(defender, goalKeeper));

    var midfielder = tactics[controller.tacticsIndex][2];
    list.add(buildRow(midfielder, defender + goalKeeper));

    var forward = tactics[controller.tacticsIndex][3];
    list.add(buildRow(forward, defender + midfielder + goalKeeper));

    return list;
  }

  buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
        (i) => GestureDetector(
          onTap: () {
            var player = controller.primaryTeam[index + i];
            controller.selectPlayer(player);
            print(player.name);
            print((index + i).toString());
          },
          child:
              PlayerSelectionWidget(player: controller.primaryTeam[index + i]),
        ),
      ),
    );
  }
}

class TransferFootballField extends StatelessWidget {
  const TransferFootballField({super.key, required this.controller});

  final TransferPageController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1501 / 2400,
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/team/football_field.png"),
            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildList(),
            ),
          )
        ],
      ),
    );
  }

  buildList() {
    var players = getTeamPLayers(controller.primaryTeam, true);
    controller.primaryTeam = players[1];

    List<Widget> list = [];

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        2,
        (i) => PlayerTransferWidget(
          player: controller.primaryTeam[0 + i],
          isExpanded: controller.isExpandedList[0 + i],
          key: UniqueKey(),
        ),
      ),
    ));

    list.add(buildRow(5, 2));

    list.add(buildRow(5, 7));

    list.add(buildRow(3, 12));

    return list;
  }

  buildRow(int playerNumber, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        playerNumber,
        (i) => PlayerTransferWidget(
          player: controller.primaryTeam[index + i],
          isExpanded: controller.isExpandedList[index + i],
          key: UniqueKey(),
        ),
      ),
    );
  }
}
