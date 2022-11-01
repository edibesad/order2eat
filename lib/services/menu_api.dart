import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/models/menu_model.dart';
import 'package:order2eat/providers/all_providers.dart';

class MenuApi {
  static Future<List<MenuModel>> getMenus() async {
    List<MenuModel> menus = [];
    // ignore: prefer_typing_uninitialized_variables
    try {
      var formData = FormData.fromMap({
        "email": "",
        "password": "",
        "api_key": ""
      });
      var response =
          await Dio().post('', data: formData);
      for (var element in response.data["data"]) {
        menus.add(MenuModel.fromJson(element));
      }
      return menus;
    } catch (e) {
      debugPrint("hata : $e");
    }
    return [];
  }

  static Future<List<MenuModel>> getMenusFromFirebase(WidgetRef ref) async {
    List<MenuModel> dbAllMenus = [];
    var formData = FormData.fromMap({
      "email": ref.read(userProvider.state).state.user!.email,
      "password": ref.read(passwordProvider.state).state,
      "api_key": "22dkjer3==(734dv_*mncd))(("
    });
    bool control = false;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('menus');

    QuerySnapshot querySnapshot = await collectionRef.get();

    var fbAllMenus = querySnapshot.docs
        .map((doc) => MenuModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    //Tüm menüleri yaz
    // FirebaseFirestore.instance
    //     .collection("subMenus")
    //     .doc("UGDtwwbLi2TRTLGbfTDc")
    //     .set({
    //   "all_sub_menus": [
    //     for (var menuModel in fbAllMenus)
    //       for (var menu in menuModel.menus!) menu.toJson()
    //   ]
    // });

    var response =
        await Dio().post('https://order2eat.dk/api/getMenus', data: formData);

    // ref.read(filteredMenusProvider.state).state =
    //     ref.read(allMenusProvider.state).state;
    for (var element in response.data["data"]) {
      dbAllMenus.add(MenuModel.fromJson(element));
    }
    for (MenuModel dbElement in dbAllMenus) {
      for (MenuModel fbElement in fbAllMenus) {
        if (dbElement.id == fbElement.id) {
          for (var dbMenu in dbElement.menus!) {
            for (var fbMenu in fbElement.menus!) {
              if (fbMenu.id == dbMenu.id) {
                if (haveSameMenus(dbMenu.options, fbMenu.options) ||
                    dbMenu.description != fbMenu.description ||
                    dbMenu.image != fbMenu.image ||
                    dbMenu.imageThumb != fbMenu.imageThumb ||
                    dbMenu.name != fbMenu.name ||
                    isEqual(dbMenu.options, fbMenu.options) ||
                    dbMenu.price != fbMenu.price) {
                  for (var doc in querySnapshot.docs) {
                    if (doc["id"] == fbElement.id) {
                      control = true;
                      collectionRef.doc(doc.id).update({
                        "menus": [
                          for (var element in dbElement.menus!) element.toJson()
                        ]
                      });
                      for (int i = 0;
                          i < ref.read(allMenusProvider.state).state.length;
                          i++) {
                        if (ref.read(allMenusProvider.state).state[i].id ==
                            dbMenu.id) {
                          ref.read(allMenusProvider.state).state[i] = dbMenu;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    if (control) {
      QuerySnapshot querySnapshot = await collectionRef.get();
      fbAllMenus = querySnapshot.docs
          .map((doc) => MenuModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      FirebaseFirestore.instance
          .collection("subMenus")
          .doc("UGDtwwbLi2TRTLGbfTDc")
          .update({
        "all_sub_menus": [
          for (var menuModel in dbAllMenus)
            for (var menu in menuModel.menus!) menu.toJson()
        ]
      });
      var subMenusFuture =
          FirebaseFirestore.instance.collection("subMenus").get();
      subMenusFuture.then((value) {
        ref.read(allMenusProvider.state).state = [
          for (var element in value.docs[0].data()["all_sub_menus"])
            Menus.fromJson(element),
        ];
      });
      return querySnapshot.docs
          .map((doc) => MenuModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    }
    var subMenusFuture =
        FirebaseFirestore.instance.collection("subMenus").get();
    subMenusFuture.then((value) {
      ref.read(allMenusProvider.state).state = [
        for (var element in value.docs[0].data()["all_sub_menus"])
          Menus.fromJson(element),
      ];
    });
    //TODO güncellenmiş menüler yollanacak

    return fbAllMenus;
  }
}

bool haveSameMenus(List<MenuOptions>? dbOptions, List<MenuOptions>? fbOptions) {
  bool control = false;

  for (var dbOption in dbOptions!) {
    for (var fbOption in fbOptions!) {
      if (dbOption.id == fbOption.id) {
        control = true;
        break;
      }
    }
    if (!control) return true;
  }

  return false;
}

bool isEqual(List<MenuOptions>? dbOptions, List<MenuOptions>? fbOptions) {
  if (dbOptions!.isEmpty && fbOptions!.isNotEmpty) {
    return true;
  }
  if (dbOptions.isNotEmpty && fbOptions!.isEmpty) {
    return true;
  }
  if (dbOptions.length != fbOptions!.length) return true;
  for (var dbElement in dbOptions) {
    for (var fbElement in fbOptions) {
      if (dbElement.id == fbElement.id) {
        if (dbElement.name != fbElement.name ||
            dbElement.subitems != fbElement.subitems ||
            dbElement.type != dbElement.type) {
          return true;
        }
      }
    }
  }
  return false;
}
