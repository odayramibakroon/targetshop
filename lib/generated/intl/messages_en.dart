// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "btn_loading": MessageLookupByLibrary.simpleMessage("Processing..."),
    "btn_next": MessageLookupByLibrary.simpleMessage("Next"),
    "error_auto_verify": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t automatically verify your phone number. Please enter it manually.",
    ),
    "error_unknown": MessageLookupByLibrary.simpleMessage(
      "An unknown error occurred. Please try again.",
    ),
    "error_verify_failed": MessageLookupByLibrary.simpleMessage(
      "Verification failed. Please try again.",
    ),
    "login_charges_info": MessageLookupByLibrary.simpleMessage(
      "Carrier charges may apply",
    ),
    "login_field_hint": MessageLookupByLibrary.simpleMessage("Phone number"),
    "login_subtitle": MessageLookupByLibrary.simpleMessage(
      "WhatsApp will need to verify your number",
    ),
    "login_subtitle_link": MessageLookupByLibrary.simpleMessage(
      "What\'s my number?",
    ),
    "login_title": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "search_hint": MessageLookupByLibrary.simpleMessage(
      "Start typing to search",
    ),
    "search_label": MessageLookupByLibrary.simpleMessage("Search"),
    "welcome_btn": MessageLookupByLibrary.simpleMessage("Agree and Continue"),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Welcome to Instant WhatsApp",
    ),
  };
}
