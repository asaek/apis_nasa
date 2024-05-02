import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String? nasaDbKey = dotenv.env['NASA_API_KEY'];
}
