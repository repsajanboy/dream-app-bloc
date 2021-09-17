class DreamRates {
  final String emoji;
  final String rateStr;

  DreamRates({
    required this.emoji,
    required this.rateStr,
  });
}

List<DreamRates> ratings = [
  DreamRates(
    emoji: "",
    rateStr: "",
  ),
  DreamRates(
    emoji: "😭",
    rateStr: "Terrible",
  ),
  DreamRates(
    emoji: "😔",
    rateStr: "Bad",
  ),
  DreamRates(
    emoji: "😀",
    rateStr: "Normal",
  ),
  DreamRates(
    emoji: "😊",
    rateStr: "Good",
  ),
  DreamRates(
    emoji: "🤩",
    rateStr: "Awesome",
  ),
];
