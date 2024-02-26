import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository {
  CollectionReference<CategoryModel> categoryRef =
      FirebaseService.db.collection("categories").withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) {
              return CategoryModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>> getCategory(String categoryId) async {
    try {
      print(categoryId);
      final response = await categoryRef.doc(categoryId).get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  List<CategoryModel> makeCategory() {
    return [
      CategoryModel(
          categoryName: "off-shoulders",
          status: "active",
          imageUrl:
              "https://th.bing.com/th/id/R.7f427d5ff81feb5722540b0d9e2e2ab1?rik=P62UMAT68Z%2bIyQ&pid=ImgRaw&r=0"),
      CategoryModel(
          categoryName: "slit",
          status: "active",
          imageUrl:
              "https://th.bing.com/th/id/OIP.YvCJpblPFHO2ZJhSt_wGagHaJQ?rs=1&pid=ImgDetMain"),
      CategoryModel(
          categoryName: "non-slit",
          status: "active",
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/9277/products/04-30-18_ID62441_Red_0326_760x.JPG?v=1529565296"),
      CategoryModel(
          categoryName: "short",
          status: "active",
          imageUrl:
              "https://th.bing.com/th/id/OIP.MNILYuqwWhf2BqDLB63QagHaLH?rs=1&pid=ImgDetMain"),
      CategoryModel(
          categoryName: "long",
          status: "active",
          imageUrl:
              "https://th.bing.com/th/id/OIP._GfKLy9zSoXjov4K8Q0U7AHaLH?rs=1&pid=ImgDetMain"),
      CategoryModel(
          categoryName: "full sleeves",
          status: "active",
          imageUrl:
          "https://www.lulus.com/images/product/w_560/2881210_562182.jpg"),
      CategoryModel(
          categoryName: "sling",
          status: "active",
          imageUrl:
          "https://th.bing.com/th/id/OIP.BhKkwgyVj-LQ3EGWZfzMKQHaLH?w=750&h=1125&rs=1&pid=ImgDetMain"),
      CategoryModel(
          categoryName: "backless",
          status: "active",
          imageUrl:
          "https://th.bing.com/th/id/OIP._af8oOkDhEJ4q01HaGOXGgHaKp?w=460&h=661&rs=1&pid=ImgDetMain"),
      CategoryModel(
          categoryName: "ruched",
          status: "active",
          imageUrl:
          "https://th.bing.com/th/id/R.6dfb655eb36e8ff5b57a69fa1212e1b8?rik=8gael2n84a%2fWtA&pid=ImgRaw&r=0"),
      CategoryModel(
          categoryName: "bodycon",
          status: "active",
          imageUrl:
          "https://cdn.shopify.com/s/files/1/0033/4476/0879/products/sage-high-neck-ruched-side-bodycon-mini-dress-tasmin-882306_1920x.jpg?v=1584113497"),
    ];
  }
}
