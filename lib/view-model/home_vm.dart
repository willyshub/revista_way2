import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revista_way2/exports/my_classes.dart';
import 'package:revista_way2/model/article_model.dart';

class HomeVM extends ChangeNotifier {
  HomeVM() {
    loadAllArticles();
  }

  List<Article> allArticles = [];

  Future<void> loadAllArticles() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final QuerySnapshot<Map<String, dynamic>> snapArticles =
        await _firestore.collection('articles_peding').get();
    debugPrint(snapArticles.toString());
    allArticles = snapArticles.docs
        .map((articleItem) => Article.fromDocument(articleItem))
        .toList();
    notifyListeners();
  }
}
