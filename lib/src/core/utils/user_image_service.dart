import 'dart:convert';
import 'dart:typed_data';
import 'dart:io'; // ✅ مهم للـ Windows (قراءة من path)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class UserImageService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static String get uid => _auth.currentUser!.uid;

  /// ✅ Pick image from Windows file explorer
  /// returns bytes for upload
  static Future<Uint8List?> pickImageBytes() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.first;

    // ✅ Prefer bytes if available
    if (file.bytes != null) return file.bytes!;

    // ✅ Fallback to reading from path (Windows)
    if (file.path != null) {
      return await File(file.path!).readAsBytes();
    }

    return null;
  }

  /// ✅ Upload to imgBB using Multipart (more reliable)
  static Future<String> uploadToImgBB({
  required Uint8List bytes,
  required String apiKey,
}) async {
  final uri = Uri.parse('https://api.imgbb.com/1/upload');

  final request = http.MultipartRequest('POST', uri);

  // ✅ key كـ field (حسب docs)
  request.fields['key'] = apiKey.trim();

  // ✅ base64 خام
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


  /// ✅ Save URL in Firestore: users/{uid}.image
  static Future<void> saveUserImageUrl(String imageUrl) async {
    await _db.collection('users').doc(uid).set(
      {'image': imageUrl},
      SetOptions(merge: true),
    );
  }

  /// 🔥 Full flow: Pick → Upload → Save
  static Future<String?> pickUploadAndSave({
    required String imgbbApiKey,
  }) async {
    final bytes = await pickImageBytes();
    if (bytes == null) return null;

    final url = await uploadToImgBB(bytes: bytes, apiKey: imgbbApiKey);
    await saveUserImageUrl(url);
    return url;
  }
}
