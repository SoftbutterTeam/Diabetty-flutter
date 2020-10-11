extension DateTimeExtension on DateTime {
    bool isSameDayAs(DateTime date) {
      if (this.day != date.day) return false;
      if (this.month != date.month) return false;
      if (this.year != date.year) return false;
      return true;
    }
}