extension IntShortener on int {
  String toShortenedString() {
    if (this >= 1000000000000000) {
      final double v = this / 1000000000000000;
      return '${v.toStringAsFixed(2)} Q';
    } else if (this >= 1000000000000) {
      final double v = this / 1000000000000;
      return '${v.toStringAsFixed(2)} T';
    } else if (this >= 1000000000) {
      final double v = this / 1000000000;
      return '${v.toStringAsFixed(2)} B';
    } else if (this >= 1000000) {
      final double v = this / 1000000;
      return '${v.toStringAsFixed(2)} MLN';
    } else if (this >= 100000) {
      final double v = this / 1000;
      return '${v.toStringAsFixed(1)} K';
    } else {
      return toString();
    }
  }
}
