// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants/shared_preferences_constants.dart';
import '../../../../Model/User.dart';

class MySharedPreferences {
  static setUserData({required User user}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(userIdSPKey, user.userid ?? 0);
      value.setInt(structuretypeSPKey, user.structureType ?? 0);

      value.setString(societynameSPKey, user.societyorbuildingname ?? '');
      value.setString(firstNameSPKey, user.firstName ?? '');
      value.setString(mobileNoSPKey, user.mobileno ?? '');
      value.setString(lastNameSPKey, user.lastName ?? '');
      value.setString(bearerTokenSPKey, user.bearerToken ?? '');
      value.setString(cnicSPKey, user.cnic ?? '');
      value.setString(addressSPKey, user.address ?? '');
      value.setString(roleNameSPKey, user.roleName ?? '');
      value.setString(fcmtokenSPKey, user.fcmtoken ?? '');
      value.setString(imageSPKey, user.image ?? '');
      value.setInt(roleIdSPKey, user.roleId ?? 0);
      value.setInt(societyidSPKey, user.societyid ?? 0);
      value.setInt(superadminidSPKey, user.superadminid ?? 0);
      value.setInt(isMainAdminSPKey, user.isMainAdmin ?? 0);
      if (user.permissions != null) {
        String permissionsJson = jsonEncode(user.permissions);
        value.setString(societyPermissionKey, permissionsJson);
      } else {
        value.remove(societyPermissionKey); // Remove if permissions are null
      }
    });
  }

  static Future<User> getUserData() async {
    User user = User();
    await SharedPreferences.getInstance().then((value) {
      value.getInt(userIdSPKey) ?? value.setInt(userIdSPKey, 0);
      value.getInt(structuretypeSPKey) ?? value.setInt(structuretypeSPKey, 0);
      value.getString(societynameSPKey) ??
          value.setString(societynameSPKey, '');

      value.getString(firstNameSPKey) ?? value.setString(firstNameSPKey, '');

      value.getString(lastNameSPKey) ?? value.setString(lastNameSPKey, '');
      value.getString(mobileNoSPKey) ?? value.setString(mobileNoSPKey, '');
      value.getString(bearerTokenSPKey) ??
          value.setString(bearerTokenSPKey, '');
      value.getString(cnicSPKey) ?? value.setString(cnicSPKey, '');
      value.getString(roleNameSPKey) ?? value.setString(roleNameSPKey, '');
      value.getString(imageSPKey) ?? value.setString(imageSPKey, '');
      value.getString(addressSPKey) ?? value.setString(addressSPKey, '');
      value.getInt(roleIdSPKey) ?? value.setInt(roleIdSPKey, 0);
      value.getInt(societyidSPKey) ?? value.setInt(societyidSPKey, 0);
      value.getInt(superadminidSPKey) ?? value.setInt(superadminidSPKey, 0);
      String? permissionsJson = value.getString(societyPermissionKey);
      Map<String, bool>? permissions;
      if (permissionsJson != null) {
        permissions = Map<String, bool>.from(jsonDecode(permissionsJson));
      }

      user = User(
        structureType: value.getInt(structuretypeSPKey),
        userid: value.getInt(userIdSPKey),
        societyorbuildingname: value.getString(societynameSPKey),
        firstName: value.getString(firstNameSPKey),
        lastName: value.getString(lastNameSPKey),
        bearerToken: value.getString(bearerTokenSPKey),
        cnic: value.getString(cnicSPKey),
        roleId: value.getInt(roleIdSPKey),
        roleName: value.getString(roleNameSPKey),
        image: value.getString(imageSPKey),
        address: value.getString(addressSPKey),
        mobileno: value.getString(mobileNoSPKey),
        societyid: value.getInt(societyidSPKey),
        superadminid: value.getInt(superadminidSPKey),
        isMainAdmin: value.getInt(isMainAdminSPKey),
        permissions: permissions,
      );
    });

    return user;
  }

  static deleteUserData() async {
    User _user = User();

    await SharedPreferences.getInstance().then((value) {
      value.remove(userIdSPKey);
      value.remove(firstNameSPKey);
      value.remove(lastNameSPKey);
      value.remove(bearerTokenSPKey);
      value.remove(cnicSPKey);
      value.remove(roleNameSPKey);
      value.remove(roleIdSPKey);
      value.remove(addressSPKey);
      value.remove(structuretypeSPKey);
      value.remove(superadminidSPKey);
      value.remove(societyidSPKey);
      value.remove(mobileNoSPKey);
      value.remove(imageSPKey);
      value.remove(isMainAdminSPKey);
    });
  }

  // static setSocietyData({required SocietyModel societyModel}) async {
  //   await SharedPreferences.getInstance().then((value) {
  //     value.setInt(societyIdSPKey, societyModel.id ?? 0);
  //     value.setString(countrySPKey, societyModel.country ?? '');
  //     value.setString(stateSPKey, societyModel.state ?? '');
  //     value.setString(citySPKey, societyModel.city ?? '');
  //     value.setString(areaSPKey, societyModel.area ?? '');
  //     value.setString(typeSPKey, societyModel.type ?? '');
  //     value.setString(societyaddressSPKey, societyModel.address ?? '');
  //     value.setString(societynameSPKey, societyModel.name ?? '');
  //     value.setInt(societysuperadminidSPKey, societyModel.superadminid ?? 0);
  //     value.setInt(structuretypeSPKey, societyModel.structuretype ?? 0);
  //   });
  // }
  //
  // static Future<SocietyModel> getSocietyData() async {
  //   SocietyModel societyModel = SocietyModel();
  //   await SharedPreferences.getInstance().then((value) {
  //     value.getInt(societyIdSPKey) ?? value.setInt(societyIdSPKey, 0);
  //     value.getString(countrySPKey) ?? value.setString(countrySPKey, '');
  //     value.getString(stateSPKey) ?? value.setString(stateSPKey, '');
  //     value.getString(citySPKey) ?? value.setString(citySPKey, '');
  //     value.getString(areaSPKey) ?? value.setString(areaSPKey, '');
  //     value.getString(typeSPKey) ?? value.setString(typeSPKey, '');
  //     value.getString(societyaddressSPKey) ??
  //         value.setString(societyaddressSPKey, '');
  //     value.getString(societynameSPKey) ??
  //         value.setString(societynameSPKey, '');
  //
  //     value.getInt(societysuperadminidSPKey) ??
  //         value.setInt(societysuperadminidSPKey, 0);
  //     value.getInt(structuretypeSPKey) ?? value.setInt(structuretypeSPKey, 0);
  //
  //     societyModel = SocietyModel(
  //       area: value.getString(areaSPKey),
  //       city: value.getString(citySPKey),
  //       country: value.getString(countrySPKey),
  //       id: value.getInt(societyIdSPKey),
  //       name: value.getString(societynameSPKey),
  //       state: value.getString(stateSPKey),
  //       structuretype: value.getInt(structuretypeSPKey),
  //       type: value.getString(typeSPKey),
  //       superadminid: value.getInt(societysuperadminidSPKey),
  //     );
  //   });
  //
  //   return societyModel;
  // }
}
