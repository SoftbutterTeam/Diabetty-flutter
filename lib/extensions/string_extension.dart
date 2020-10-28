extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String plurarlUnits(var num) {
    if (num != 1 &&
        this.substring(this.length - 3, this.length).contains("(s)"))
      return this.replaceAll(new RegExp(r'[()]'), '');
    else if (num == 1 &&
        this.substring(this.length - 3, this.length).contains("(s)"))
      return this.replaceRange(this.length - 3, this.length, '');
    return this;
  }
}
