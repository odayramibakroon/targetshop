import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// عدّل المسارات حسب مشروعك
import 'package:targetshop/src/features/home/presentation/widgets/shimmeruser.dart';
import 'package:targetshop/src/features/users/cubit/user_cubit.dart';

/// =======================
/// Firebase Helpers (GLOBAL FEED)
/// =======================
class Fb {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get db => FirebaseFirestore.instance;

  static String get uid => auth.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>> get posts => db.collection('posts');
  static DocumentReference<Map<String, dynamic>> postDoc(String postId) => posts.doc(postId);

  static DocumentReference<Map<String, dynamic>> userDoc(String uid) =>
      db.collection('users').doc(uid);

  static Stream<DocumentSnapshot<Map<String, dynamic>>> userStream(String uid) =>
      userDoc(uid).snapshots();

  /// Create post in GLOBAL posts collection
  /// ✅ نخزن authorUid فقط (حتى بيانات المؤلف تتحدّث تلقائياً)
  static Future<void> createPost({
    required String text,
    String? imageUrl,
  }) async {
    final postId = posts.doc().id;

    final postData = <String, dynamic>{
      'id': postId,
      'ownerUid': uid,
      'authorUid': uid, // ✅ مهم
      'text': text,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'likeCount': 0,
      'commentCount': 0,
    };

    await posts.doc(postId).set(postData);

    // ✅ (اختياري) نسخة تحت user
    await db.collection('users').doc(uid).collection('posts').doc(postId).set(postData);
  }

  /// ✅ Like: نخزن uid فقط + الوقت
  static Future<void> toggleLike({required String postId}) async {
    final postRef = postDoc(postId);
    final likeRef = postRef.collection('likes').doc(uid);

    await db.runTransaction((tx) async {
      final likeSnap = await tx.get(likeRef);

      if (likeSnap.exists) {
        tx.delete(likeRef);
        tx.update(postRef, {'likeCount': FieldValue.increment(-1)});
      } else {
        tx.set(likeRef, {
          'uid': uid,
          'likedAt': FieldValue.serverTimestamp(),
        });
        tx.update(postRef, {'likeCount': FieldValue.increment(1)});
      }
    });
  }

  /// ✅ Comment: نخزن uid فقط + النص + الوقت
  static Future<void> addComment({
    required String postId,
    required String text,
  }) async {
    final postRef = postDoc(postId);

    await postRef.collection('comments').add({
      'uid': uid,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await postRef.update({'commentCount': FieldValue.increment(1)});
  }
}

/// =======================
/// Widget: Live user data from users/{uid}
/// =======================
class UserTileLive extends StatelessWidget {
  final String uid;
  final Widget Function({
    required String name,
    required String image,
    required bool verifiedaccount,
  }) builder;

  const UserTileLive({super.key, required this.uid, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (uid.isEmpty) {
      return builder(
        name: 'User',
        image:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
        verifiedaccount: false,
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: Fb.userStream(uid),
      builder: (context, snap) {
        final data = snap.data?.data();

        // Fallback values
        String name = 'User';
        String image =
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200';
        bool verifiedaccount = false;

        if (data != null) {
          final firstname = (data['firstname'] ?? '').toString();
          final lastname = (data['lastname'] ?? '').toString();
          final full = ('$firstname $lastname').trim();
          if (full.isNotEmpty) name = full;

          final img = (data['image'] ?? '').toString().trim();
          if (img.isNotEmpty) image = img;

          verifiedaccount = (data['verifiedaccount'] ?? false) as bool;
        }

        return builder(name: name, image: image, verifiedaccount: verifiedaccount);
      },
    );
  }
}

/// =======================
/// Posts Page (GLOBAL FEED)
/// =======================
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> _postsStream() {
    return Fb.posts.orderBy('createdAt', descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) return const SkeletonListuser();
        if (state is! UserLoaded) return const SizedBox.shrink();

        final cs = Theme.of(context).colorScheme;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color(0xFFF2F3F5),
            appBar: AppBar(
              title: const Text('Posts'),
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PostComposerScreen()),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _ComposerBar(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PostComposerScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _postsStream(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final docs = snap.data?.docs ?? [];
                    if (docs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('لا يوجد منشورات بعد.'),
                      );
                    }

                    return Column(
                      children: docs.map((d) {
                        return PostCardFirebase(
                          postId: d.id,
                          data: d.data(),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ComposerBar extends StatelessWidget {
  final VoidCallback onTap;

  const _ComposerBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return UserTileLive(
      uid: Fb.uid,
      builder: ({required name, required image, required verifiedaccount}) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Color(0x14000000),
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 18, backgroundImage: NetworkImage(image)),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F5),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('بماذا تفكر؟'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.home_filled, color: cs.primary),
            ],
          ),
        );
      },
    );
  }
}

/// =======================
/// Post Card (GLOBAL)
/// =======================
class PostCardFirebase extends StatelessWidget {
  final String postId;
  final Map<String, dynamic> data;

  const PostCardFirebase({
    super.key,
    required this.postId,
    required this.data,
  });

  String _timeAgo(Timestamp? ts) {
    if (ts == null) return 'الآن';
    final dt = ts.toDate();
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 365) return 'عام';
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _likeDocStream() {
    return Fb.postDoc(postId).collection('likes').doc(Fb.uid).snapshots();
  }

  /// Top 3 likes docs (each has uid only)
  Stream<QuerySnapshot<Map<String, dynamic>>> _topLikesStream() {
    return Fb.postDoc(postId)
        .collection('likes')
        .orderBy('likedAt', descending: true)
        .limit(3)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // ✅ authorUid (new)
    final authorUid = (data['authorUid'] ?? data['ownerUid'] ?? '').toString();

    // fallback old author map if exists
    final authorOld = (data['author'] as Map?)?.cast<String, dynamic>() ?? {};
    final oldName = (authorOld['name'] ?? '').toString();
    final oldImage = (authorOld['image'] ?? '').toString();
    final oldVerified = (authorOld['verifiedaccount'] ?? false) as bool;

    final text = (data['text'] ?? '').toString();
    final imageUrl = (data['imageUrl'] as String?)?.trim();
    final likeCount = (data['likeCount'] ?? 0) as int;
    final commentCount = (data['commentCount'] ?? 0) as int;
    final createdAt = data['createdAt'] as Timestamp?;

    Widget headerBuilder({
      required String name,
      required String image,
      required bool verifiedaccount,
    }) {
      // use old data if user doc not ready and old exists
      final finalName = name == 'User' && oldName.isNotEmpty ? oldName : name;
      final finalImage = (image.contains('unsplash') && oldImage.isNotEmpty)
          ? oldImage
          : image;
      final finalVerified = verifiedaccount || oldVerified;

      return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: NetworkImage(finalImage)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(finalName,
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(width: 6),
                      if (finalVerified)
                        const Icon(Icons.verified,
                            size: 16, color: Color(0xFF4A82FF)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        _timeAgo(createdAt),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.public,
                          size: 14, color: Colors.black45),
                    ],
                  )
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostDetailsScreen(postId: postId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x14000000),
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header (live from users)
            UserTileLive(
              uid: authorUid,
              builder: ({required name, required image, required verifiedaccount}) =>
                  headerBuilder(name: name, image: image, verifiedaccount: verifiedaccount),
            ),

            // Text
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),

            const SizedBox(height: 10),

            if (imageUrl != null && imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, height: 220, fit: BoxFit.cover),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Row(
                children: [
                  // ✅ Top likes avatars fetched from users
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _topLikesStream(),
                    builder: (context, snap) {
                      final docs = snap.data?.docs ?? [];
                      final uids = docs
                          .map((d) => (d.data()['uid'] ?? '').toString())
                          .where((s) => s.isNotEmpty)
                          .toList();

                      return _TopLikeAvatarsFromUsers(uids: uids);
                    },
                  ),
                  const SizedBox(width: 8),

                  // tap likes count -> who liked
                  GestureDetector(
                    onTap: () {
                      if (likeCount <= 0) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LikesListScreen(postId: postId),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text('$likeCount',
                            style: const TextStyle(color: Colors.black54)),
                        if (likeCount > 3)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F3F5),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                '+${likeCount - 3}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  Text('تعليق $commentCount',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),

            const Divider(height: 1),

            // Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: _likeDocStream(),
                      builder: (context, snap) {
                        final isLiked = snap.data?.exists ?? false;
                        return TextButton.icon(
                          onPressed: () async {
                            await Fb.toggleLike(postId: postId);
                          },
                          icon: Icon(
                            isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined,
                            color: isLiked ? cs.primary : Colors.black54,
                          ),
                          label: Text(
                            'أعجبني',
                            style: TextStyle(
                              color: isLiked ? cs.primary : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostDetailsScreen(postId: postId),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline,
                          color: Colors.black54),
                      label: const Text('تعليق',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                    Expanded(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.reply, color: Colors.black54),
                      label: Text('مشاركة',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Top likes avatars (3) by reading users docs (live)
class _TopLikeAvatarsFromUsers extends StatelessWidget {
  final List<String> uids;
  const _TopLikeAvatarsFromUsers({required this.uids});

  @override
  Widget build(BuildContext context) {
    if (uids.isEmpty) return const SizedBox.shrink();

    // build stacked avatars with nested streams (only 3, ok)
    return SizedBox(
      width: uids.length * 16.0 + 20,
      height: 22,
      child: Stack(
        children: [
          for (int i = 0; i < uids.length; i++)
            Positioned(
              right: i * 16.0,
              child: UserTileLive(
                uid: uids[i],
                builder: ({required name, required image, required verifiedaccount}) {
                  return Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// =======================
/// Post Composer Screen
/// =======================
class PostComposerScreen extends StatefulWidget {
  const PostComposerScreen({super.key});

  @override
  State<PostComposerScreen> createState() => _PostComposerScreenState();
}

class _PostComposerScreenState extends State<PostComposerScreen> {
  final controller = TextEditingController();
  Uint8List? imageBytes;
  bool isUploading = false;

  bool get canPost => controller.text.trim().isNotEmpty || imageBytes != null;

  Future<void> _pickImageFromComputer() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (file.bytes != null) {
      setState(() => imageBytes = file.bytes);
      return;
    }

    if (file.path != null) {
      final bytes = await File(file.path!).readAsBytes();
      setState(() => imageBytes = bytes);
    }
  }

  Future<void> _submit() async {
    if (!canPost || isUploading) return;

    setState(() => isUploading = true);
    try {
      String? imageUrl;

      // TODO: upload image to storage then set imageUrl
      // if (imageBytes != null) imageUrl = await Fb.uploadPostImage(...);

      await Fb.createPost(
        text: controller.text.trim(),
        imageUrl: imageUrl,
      );

      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('منشور جديد'),
          actions: [
            TextButton(
              onPressed: canPost ? _submit : null,
              child: isUploading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      'نشر',
                      style: TextStyle(
                        color: canPost ? cs.primary : Colors.black38,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            UserTileLive(
              uid: Fb.uid,
              builder: ({required name, required image, required verifiedaccount}) {
                return Row(
                  children: [
                    CircleAvatar(radius: 18, backgroundImage: NetworkImage(image)),
                    const SizedBox(width: 10),
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(width: 6),
                    if (verifiedaccount)
                      const Icon(Icons.verified, size: 16, color: Color(0xFF4A82FF)),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'اكتب شيئًا...',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickImageFromComputer,
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('اختيار صورة من الكمبيوتر'),
                  ),
                ),
                const SizedBox(width: 10),
                if (imageBytes != null)
                  IconButton(
                    onPressed: () => setState(() => imageBytes = null),
                    icon: const Icon(Icons.close),
                    tooltip: 'إزالة الصورة',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (imageBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.memory(imageBytes!, height: 240, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// Post Details Screen (comments + add comment)
/// =======================
class PostDetailsScreen extends StatelessWidget {
  final String postId;

  const PostDetailsScreen({super.key, required this.postId});

  DocumentReference<Map<String, dynamic>> get _postRef => Fb.postDoc(postId);
  Stream<DocumentSnapshot<Map<String, dynamic>>> get _postStream => _postRef.snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get _commentsStream =>
      _postRef.collection('comments').orderBy('createdAt', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تفاصيل المنشور')),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: _postStream,
                builder: (context, snap) {
                  if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                  final data = snap.data!.data() ?? {};

                  final authorUid = (data['authorUid'] ?? data['ownerUid'] ?? '').toString();
                  final text = (data['text'] ?? '').toString();
                  final imageUrl = (data['imageUrl'] as String?)?.trim();

                  return ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      UserTileLive(
                        uid: authorUid,
                        builder: ({required name, required image, required verifiedaccount}) {
                          return Row(
                            children: [
                              CircleAvatar(radius: 18, backgroundImage: NetworkImage(image)),
                              const SizedBox(width: 10),
                              Text(name,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              const SizedBox(width: 6),
                              if (verifiedaccount)
                                const Icon(Icons.verified, size: 16, color: Color(0xFF4A82FF)),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      if (text.isNotEmpty)
                        Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      if (imageUrl != null && imageUrl.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(imageUrl, height: 260, fit: BoxFit.cover),
                        ),
                      ],
                      const SizedBox(height: 12),
                      const Divider(),
                      const Text('التعليقات', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),

                      // ✅ comments list (uid -> users doc)
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: _commentsStream,
                        builder: (context, csnap) {
                          if (!csnap.hasData) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final comments = csnap.data!.docs;
                          if (comments.isEmpty) return const Text('لا يوجد تعليقات بعد.');

                          return Column(
                            children: comments.map((d) {
                              final c = d.data();
                              final uid = (c['uid'] ?? '').toString();
                              final txt = (c['text'] ?? '').toString();

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: UserTileLive(
                                  uid: uid,
                                  builder: ({required name, required image, required verifiedaccount}) {
                                    return Row(
                                      children: [
                                        CircleAvatar(radius: 16, backgroundImage: NetworkImage(image)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2F3F5),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                style: DefaultTextStyle.of(context).style,
                                                children: [
                                                  TextSpan(
                                                    text: '$name  ',
                                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                                  ),
                                                  if (verifiedaccount)
                                                    const WidgetSpan(
                                                      alignment: PlaceholderAlignment.middle,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 6),
                                                        child: Icon(
                                                          Icons.verified,
                                                          size: 14,
                                                          color: Color(0xFF4A82FF),
                                                        ),
                                                      ),
                                                    ),
                                                  TextSpan(text: txt),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),

            // ✅ add comment
            _CommentInputBar(
              onSend: (txt) => Fb.addComment(postId: postId, text: txt),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentInputBar extends StatefulWidget {
  final Future<void> Function(String text) onSend;
  const _CommentInputBar({required this.onSend});

  @override
  State<_CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<_CommentInputBar> {
  final controller = TextEditingController();
  bool sending = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Color(0x14000000), offset: Offset(0, -2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'اكتب تعليق...',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: sending
                  ? null
                  : () async {
                      final txt = controller.text.trim();
                      if (txt.isEmpty) return;
                      setState(() => sending = true);
                      try {
                        await widget.onSend(txt);
                        controller.clear();
                      } finally {
                        if (mounted) setState(() => sending = false);
                      }
                    },
              icon: sending
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// Likes List Screen (who liked) - pulls user info from users/{uid}
/// =======================
class LikesListScreen extends StatelessWidget {
  final String postId;
  const LikesListScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final likesRef =
        Fb.postDoc(postId).collection('likes').orderBy('likedAt', descending: true);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الأشخاص الذين أعجبهم')),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: likesRef.snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            final docs = snap.data!.docs;
            if (docs.isEmpty) return const Center(child: Text('لا يوجد لايكات بعد.'));

            return ListView.separated(
              itemCount: docs.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final like = docs[i].data();
                final uid = (like['uid'] ?? '').toString();
                if (uid.isEmpty) return const SizedBox.shrink();

                return UserTileLive(
                  uid: uid,
                  builder: ({required name, required image, required verifiedaccount}) {
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(image)),
                      title: Row(
                        children: [
                          Expanded(child: Text(name)),
                          if (verifiedaccount)
                            const Icon(Icons.verified, size: 16, color: Color(0xFF4A82FF)),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
