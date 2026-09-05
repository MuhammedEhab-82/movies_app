import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/home/profile_tab/model/user_profile.dart';
import 'app_assets.dart';

class FireBaseUtils {
  static CollectionReference<UserProfile> getUsersCollection (){
    return FirebaseFirestore.instance.collection(UserProfile.collectionName)
        .withConverter<UserProfile>(
        fromFirestore: (snapshot, options) => UserProfile.fromFireStore(snapshot.data()!),
        toFirestore: (userProfile, options) => userProfile.toFireStore(),
    );
  }

  static Future<void> updateUserInFirestore(UserProfile userProfile) async {
    CollectionReference<UserProfile> collectionRef = getUsersCollection();

    DocumentReference<UserProfile> docRef =
    collectionRef.doc(userProfile.id);

    await docRef.update({
      'name': userProfile.name,
      'phone': userProfile.phone,
      'avatar': AppImages.indexByAvatar(userProfile.avatarUrl),
    });
  }

  static Future <void> deleteUserInFirestore (UserProfile userProfile) async{
    //todo: 1- collection
    CollectionReference<UserProfile> collectionRef= getUsersCollection();
    // todo: 2-document
    DocumentReference<UserProfile> docRef = collectionRef.doc(userProfile.id);
    //todo : 3-update user
    await docRef.delete();
  }

  static Future<UserProfile?> getUserFromFirestore(String uid) async {
    final collectionRef = getUsersCollection();
    final doc = await collectionRef.doc(uid).get();
    return doc.exists ? doc.data() : null;
  }


}