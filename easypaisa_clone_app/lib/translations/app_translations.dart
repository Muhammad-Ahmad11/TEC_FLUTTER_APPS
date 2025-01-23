import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'send_money': 'Send Money',
          'bill_payments': 'Bill Payments',
        },
        'ur': {
          'send_money': 'رقم بھیجیں',
          'bill_payments': 'بل کی ادائیگی',
        },
      };
}
