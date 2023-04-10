import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  late SharedPreferences prefs;
  late Future<WebtoonDetailModel> webtoon;
  List<String> likedToons = [];
  bool hasLikeList = false;

  Future checkPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final newlikedToons = prefs.getStringList('likedToons');
    if (newlikedToons != null) {
      setState(() {
        hasLikeList = true;
        likedToons.addAll(newlikedToons);
      });
    } else {
      print('책 없음');
    }
  }

  @override
  void initState() {
    super.initState();
    checkPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "내 서재",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: hasLikeList
            ? Column(
                children: [for (var likedToon in likedToons) Text(likedToon)],
              )
            : const Text('책이 없음'));
  }
}

// 해야 할 것
// likeToons list에서 받아온 id를 가지고 webtoons 자료를 가져와서
// 뿌리기