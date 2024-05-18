import 'package:intl/intl.dart';

class Helpers{

  formatDate(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  String checkAndAddHttp(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://image.tmdb.org/t/p/w500$url';
    }
    return url;
  }

}