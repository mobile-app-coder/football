// To parse this JSON data, do
//
//     final playerDetailModel = playerDetailModelFromJson(jsonString);

import 'dart:convert';

PlayerDetailModel playerDetailModelFromJson(String str) => PlayerDetailModel.fromJson(json.decode(str));

String playerDetailModelToJson(PlayerDetailModel data) => json.encode(data.toJson());

class PlayerDetailModel {
  PlayerDetail? player;
  List<Statistic>? statistics;

  PlayerDetailModel({
    this.player,
    this.statistics,
  });

  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) => PlayerDetailModel(
    player: json["player"] == null ? null : PlayerDetail.fromJson(json["player"]),
    statistics: json["statistics"] == null ? [] : List<Statistic>.from(json["statistics"]!.map((x) => Statistic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "player": player?.toJson(),
    "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
  };
}

class PlayerDetail {
  int? id;
  String? name;
  String? position;
  int? playerNumber;
  String? clubName;
  double? price;
  int? currentScore;
  int? totalScore;
  double? selectionRate;
  String? jersey;
  String? playerKey;

  PlayerDetail({
    this.id,
    this.name,
    this.position,
    this.playerNumber,
    this.clubName,
    this.price,
    this.currentScore,
    this.totalScore,
    this.selectionRate,
    this.jersey,
    this.playerKey,
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) => PlayerDetail(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    playerNumber: json["playerNumber"],
    clubName: json["clubName"],
    price: json["price"]?.toDouble(),
    currentScore: json["currentScore"],
    totalScore: json["totalScore"],
    selectionRate: json["selectionRate"]?.toDouble(),
    jersey: json["jersey"],
    playerKey: json["playerKey"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "playerNumber": playerNumber,
    "clubName": clubName,
    "price": price,
    "currentScore": currentScore,
    "totalScore": totalScore,
    "selectionRate": selectionRate,
    "jersey": jersey,
    "playerKey": playerKey,
  };
}

class Statistic {
  int? matchWeekId;
  int? totalScore;
  ScoreDetails? scoreDetails;

  Statistic({
    this.matchWeekId,
    this.totalScore,
    this.scoreDetails,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
    matchWeekId: json["matchWeekId"],
    totalScore: json["totalScore"],
    scoreDetails: json["scoreDetails"] == null ? null : ScoreDetails.fromJson(json["scoreDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "matchWeekId": matchWeekId,
    "totalScore": totalScore,
    "scoreDetails": scoreDetails?.toJson(),
  };
}

class ScoreDetails {
  int? red;
  int? assist;
  int? halfTime;
  int? yellow;
  int? goal;

  ScoreDetails({
    this.red,
    this.assist,
    this.halfTime,
    this.yellow,
    this.goal,
  });

  factory ScoreDetails.fromJson(Map<String, dynamic> json) => ScoreDetails(
    red: json["RED"],
    assist: json["ASSIST"],
    halfTime: json["HALF_TIME"],
    yellow: json["YELLOW"],
    goal: json["GOAL"],
  );

  Map<String, dynamic> toJson() => {
    "RED": red,
    "ASSIST": assist,
    "HALF_TIME": halfTime,
    "YELLOW": yellow,
    "GOAL": goal,
  };
}
