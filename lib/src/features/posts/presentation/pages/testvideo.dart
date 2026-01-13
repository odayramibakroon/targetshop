import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ✅ مهم: لازم تولد هذا الملف عبر FlutterFire CLI
// flutterfire configure
 
 

 

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _sub;

  bool _showAd = false;
  String _videoUrl = '';
  String _adId = '';

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  DocumentReference<Map<String, dynamic>> get _adDoc => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('ui_flags')
      .doc('video_ad');

  @override
  void initState() {
    super.initState();
    _listenToMyAd();
  }

  void _listenToMyAd() {
    _sub = _adDoc.snapshots().listen((snap) {
      if (!snap.exists) return;

      final d = snap.data()!;
      final show = d['show'] == true;
      final url = (d['videoUrl'] ?? '').toString();
      final adId = (d['adId'] ?? '').toString();

      if (show && url.isNotEmpty) {
        setState(() {
          _showAd = true;
          _videoUrl = url;
          _adId = adId;
        });
      }
    });
  }

  Future<void> triggerAdForMe() async {
    // ضع رابط فيديو عندك (يفضل WebM للشفافية على الويب)
    const demoUrl =
        'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.webm';
    const demoUrl2 =
        'https://upload.wikimedia.org/wikipedia/commons/e/e4/Yokohama_fireworks.webm';

    await _adDoc.set({
      'show': true,
      'videoUrl': demoUrl,
      'adId': DateTime.now().millisecondsSinceEpoch.toString(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> _markAdDone() async {
    // حتى ما يعيد التشغيل
    await _adDoc.set({'show': false}, SetOptions(merge: true));
  }

  Future<void> _onAdFinished() async {
    setState(() => _showAd = false);
    await _markAdDone();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ المنيو الطبيعي
        Scaffold(
          appBar: AppBar(
            title: const Text('Menu'),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    'UID: ${uid.substring(0, 6)}…',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('المنيو شغّالة طبيعي'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: triggerAdForMe,
                  child: const Text('شغّل الإعلان لي (Firestore)'),
                ),
                const SizedBox(height: 8),
                Text(
                  'عند الضغط: يكتب show=true في users/{uid}/ui_flags/video_ad\n'
                  'والـ Listener يعرض الفيديو فقط لهذا المستخدم.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),

        // ✅ Overlay الفيديو فوق نفس الواجهة (المنيو يظل ظاهر)
        if (_showAd)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true, // خليها false لو بدك تمنع تفاعل المستخدم مع المنيو أثناء الإعلان
              child: VideoOverlay(
                url: _videoUrl,
                onFinished: _onAdFinished,
                debugAdId: _adId,
              ),
            ),
          ),
      ],
    );
  }
}

class VideoOverlay extends StatefulWidget {
  final String url;
  final Future<void> Function() onFinished;
  final String debugAdId;

  const VideoOverlay({
    super.key,
    required this.url,
    required this.onFinished,
    required this.debugAdId,
  });

  @override
  State<VideoOverlay> createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {
  VideoPlayerController? _controller;
  bool _finishedCalled = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller = c;

    await c.initialize();
    c.setLooping(false);
    c.setVolume(0); // غالبًا الإعلانات على الويب لازم تبدأ صامتة لتشتغل AutoPlay
    await c.play();

    c.addListener(() async {
      final v = c.value;
      if (!v.isInitialized) return;

      final done = v.position >= v.duration && v.duration.inMilliseconds > 0;
      if (done && !_finishedCalled) {
        _finishedCalled = true;
        await widget.onFinished();
      }
    });

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    if (c == null || !c.value.isInitialized) {
      return const SizedBox.shrink();
    }

    // ✅ Overlay بدون خلفية (إذا الفيديو يدعم alpha) فوق المنيو
    return Center(
      child: AspectRatio(
        aspectRatio: c.value.aspectRatio,
        child: VideoPlayer(c),
      ),
    );
  }
}