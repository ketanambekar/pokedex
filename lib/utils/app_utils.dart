class AppUtils {

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String getIdFromUrl(String url) {
    final RegExp regExp = RegExp(r'\/(\d+)\/$');
    final match = regExp.firstMatch(url);
    if (match != null) {
      String id = match.group(1) ?? '';
      if (id.length == 1) {
        return '00$id';
      } else if (id.length == 2) {
        return '0$id';
      } else {
        return id;
      }
    } else {
      return '';
    }
  }

}
