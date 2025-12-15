// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "btn_loading": MessageLookupByLibrary.simpleMessage("جارٍ المعالجة..."),
    "btn_next": MessageLookupByLibrary.simpleMessage("التالي"),
    "error_auto_verify": MessageLookupByLibrary.simpleMessage(
      "لم نتمكن من التحقق تلقائيًا من رقم هاتفك. يرجى إدخاله يدويًا.",
    ),
    "error_unknown": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير معروف. يرجى المحاولة مرة أخرى.",
    ),
    "error_verify_failed": MessageLookupByLibrary.simpleMessage(
      "فشل التحقق. يرجى المحاولة مرة أخرى.",
    ),
    "login_charges_info": MessageLookupByLibrary.simpleMessage(
      "قد يتم تطبيق رسوم من قبل شركة الاتصالات",
    ),
    "login_field_hint": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "login_subtitle": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رقم هاتفك لتسجيل الدخول إلى WhatsApp",
    ),
    "login_subtitle_link": MessageLookupByLibrary.simpleMessage(
      "ما هو رقم هاتفي؟",
    ),
    "login_title": MessageLookupByLibrary.simpleMessage("أدخل رقم هاتفك"),
    "search_hint": MessageLookupByLibrary.simpleMessage("ابدأ الكتابة للبحث"),
    "search_label": MessageLookupByLibrary.simpleMessage("بحث"),
    "welcome_btn": MessageLookupByLibrary.simpleMessage("الموافقة والمتابعة"),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "مرحبًا بك في Instant WhatsApp",
    ),
  };
}
