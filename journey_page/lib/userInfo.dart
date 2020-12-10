// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    UserInfo({
        this.dotsAmount,
        this.dots,
    });

    int dotsAmount;
    List<Dot> dots;

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        dotsAmount: json["dots_amount"],
        dots: List<Dot>.from(json["dots"].map((x) => Dot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dots_amount": dotsAmount,
        "dots": List<dynamic>.from(dots.map((x) => x.toJson())),
    };
}

class Dot {
    Dot({
        this.dotType,
        this.status,
        this.reward,
        this.day,
        this.reps,
        this.future,
        this.body,
        this.goalsPerWeek,
        this.rewardedDays,
        this.nextWeekStartOn,
        // Customised property, not from json file
        this.sequenceNum,
        this.isDummy,
    });

    Type dotType;
    Status status;
    List<Reward> reward;
    DateTime day;
    int reps;
    bool future;
    String body;
    int goalsPerWeek;
    int rewardedDays;
    DateTime nextWeekStartOn;
    // Customised property, not from json file
    int sequenceNum;
    bool isDummy;

    void addSequenceNum(int seq){
      sequenceNum = seq;
    }

    factory Dot.fromJson(Map<String, dynamic> json) => Dot(
        dotType: typeValues.map[json["dot_type"]],
        status: statusValues.map[json["status"]],
        reward: List<Reward>.from(json["reward"].map((x) => Reward.fromJson(x))),
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        reps: json["reps"] == null ? null : json["reps"],
        future: json["future"],
        body: json["body"] == null ? null : json["body"],
        goalsPerWeek: json["goals_per_week"] == null ? null : json["goals_per_week"],
        rewardedDays: json["rewarded_days"] == null ? null : json["rewarded_days"],
        nextWeekStartOn: json["next_week_start_on"] == null ? null : DateTime.parse(json["next_week_start_on"]),
    );

    Map<String, dynamic> toJson() => {
        "dot_type": typeValues.reverse[dotType],
        "status": statusValues.reverse[status],
        "reward": List<dynamic>.from(reward.map((x) => x.toJson())),
        "day": day == null ? null : "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "reps": reps == null ? null : reps,
        "future": future,
        "body": body == null ? null : body,
        "goals_per_week": goalsPerWeek == null ? null : goalsPerWeek,
        "rewarded_days": rewardedDays == null ? null : rewardedDays,
        "next_week_start_on": nextWeekStartOn == null ? null : "${nextWeekStartOn.year.toString().padLeft(4, '0')}-${nextWeekStartOn.month.toString().padLeft(2, '0')}-${nextWeekStartOn.day.toString().padLeft(2, '0')}",
    };
}

enum Type { DAILY, WEEKLY, TIER, }

final typeValues = EnumValues({
    "daily": Type.DAILY,
    "tier": Type.TIER,
    "weekly": Type.WEEKLY
});

class Reward {
    Reward({
        this.rewardType,
        this.amount,
    });

    Type rewardType;
    String amount;

    factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        rewardType: typeValues.map[json["reward_type"]],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "reward_type": typeValues.reverse[rewardType],
        "amount": amount,
    };
}

enum Status { TICK, CURRENT_LOCK, LOCK, FAIL }

final statusValues = EnumValues({
    "current_lock": Status.CURRENT_LOCK,
    "lock": Status.LOCK,
    "tick": Status.TICK,
    "fail": Status.FAIL,
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
