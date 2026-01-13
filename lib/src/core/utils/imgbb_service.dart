import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImgBBService {
  // ✅ حط مفتاحك هنا (نفس اللي عندك)
  static const String apiKey = 'e83fe0aadc3559783d52a821deff056c';

  static Future<String> uploadBytes(Uint8List bytes) async {
    final uri = Uri.parse('https://api.imgbb.com/1/upload');

    final request = http.MultipartRequest('POST', uri);

    // ✅ حسب docs
    request.fields['key'] = apiKey.trim();

    // ✅ base64 raw
    request.fields['image'] = base64Encode(bytes);

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode != 200) {
      throw Exception('imgBB error ${res.statusCode}: ${res.body}');
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;

    final url = (data['url'] ?? data['display_url']) as String?;
    if (url == null || url.isEmpty) {
      throw Exception('imgBB response missing url: ${res.body}');
    }
    return url;
  }
}
