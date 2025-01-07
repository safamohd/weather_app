import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

@immutable
class Constants {

  static String apiKey = dotenv.env['APIKEY'].toString();

}
