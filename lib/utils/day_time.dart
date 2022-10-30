class DayTime {
  String gettheCorrentImageDependOnCurrentTime() {
    final currentTime = DateTime.now();
    if (currentTime.hour > 8 && currentTime.hour < 20) {
      return "assets/images/days/sun.png";
    }
    return "assets/images/days/moon.png";
  }
}
