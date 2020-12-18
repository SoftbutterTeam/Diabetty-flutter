extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String capitalizeBegins() {
    return this
        .split(" ")
        .map((e) => e.capitalize())
        .reduce((value, element) => value += " " + element)
        .trimLeft();
  }

  String plurarlUnits(int num) {
    if (num != 1 &&
        this.substring(this.length - 3, this.length).contains("(s)"))
      return this.replaceAll(new RegExp(r'[()]'), '');
    else if (num == 1 &&
        this.substring(this.length - 3, this.length).contains("(s)"))
      return this.replaceRange(this.length - 3, this.length, '');
    return this;
  }

  bool isNotEmpty() {
    return this != "" && this != null;
  }
}
