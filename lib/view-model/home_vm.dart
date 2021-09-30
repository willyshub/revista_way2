import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revista_way2/exports/my_classes.dart';
import 'package:revista_way2/model/article_model.dart';

class HomeVM extends ChangeNotifier {
  HomeVM() {
    loadAllArticles();
  }

  void changeNotifier() {
    loadAllArticles();
    notifyListeners();
  }

  List<Article> allArticles = [];

  Future<QuerySnapshot> loadAllArticles() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await Future.delayed(const Duration(seconds: 1));

    final QuerySnapshot<Map<String, dynamic>> snapArticles = await _firestore
        .collection('articles_peding')
        .where("isApproved", isEqualTo: true)
        .get();
    debugPrint(snapArticles.toString());
    allArticles = snapArticles.docs
        .map((articleItem) => Article.fromDocument(articleItem))
        .toList();
    notifyListeners();
    return snapArticles;
  }
}
