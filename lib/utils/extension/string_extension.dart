extension StringExtension on String {
  String errorMessage() {
    if (this == "") return "";
    return replaceAll('Exception:', '');
  }
}
