import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/auth/model/user_model.dart';

import 'app_assets.dart';

class FireBaseUtils {
 static CollectionReference<UserModel> getUsersCollection() {
   return FirebaseFirestore.instance.collection(UserModel.collectionName)
       .withConverter<UserModel>(
         fromFirestore: (snapshot, options) =>
             UserModel.fromFireStore(snapshot.data() ?? {}),
         toFirestore: (userModel, options) => userModel.toFireStore(),
       );
 }

 static Future<void> updateUserInFirestore(UserModel userModel) async {
   final collectionRef = getUsersCollection();
   final docRef = collectionRef.doc(userModel.id);

   await docRef.update({
     'name': userModel.name,
     'phone': userModel.phone,
     'avatar': AppImages.indexByAvatar(userModel.avatarUrl),
   });
 }

 static Future<void> addMovieToWatchlist({
   required String userId,
   required int movieId,
 }) async {
   final collectionRef = getUsersCollection();
   final docRef = collectionRef.doc(userId);
   await docRef.update({
     'watchlist': FieldValue.arrayUnion([movieId.toString()]),
   });
 }

 static Future<void> addMovieToHistory({
   required String userId,
   required int movieId,
 }) async {
   final collectionRef = getUsersCollection();
   final docRef = collectionRef.doc(userId);
   await docRef.update({
     'history': FieldValue.arrayUnion([movieId.toString()]),
   });
 }

 static Future<void> deleteUserInFirestore(UserModel userModel) async {
   final collectionRef = getUsersCollection();
   final docRef = collectionRef.doc(userModel.id);
   await docRef.delete();
 }

 static Future<UserModel?> getUserFromFirestore(String uid) async {
   final collectionRef = getUsersCollection();
   final doc = await collectionRef.doc(uid).get();
   return doc.exists ? doc.data() : null;
 }

 static Future<void> removeMovieFromWatchlist({
   required int? movieId,
   required String? userId,
 }) async {
   final collectionRef = getUsersCollection();
   final docRef = collectionRef.doc(userId);
   await docRef.update({
     'watchlist': FieldValue.arrayRemove([movieId.toString()]),
   });
 }
}
