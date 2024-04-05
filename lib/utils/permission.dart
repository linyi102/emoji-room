import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  /// 外部存储管理权限
  static Future<bool> requestManageExternalStorage() async {
    final status = await Permission.manageExternalStorage.status;
    if (status == PermissionStatus.restricted) {
      // Android10没有manageExternalStorage，因此对应的权限状态为restricted，所以应判断storage的权限状态
      return _checkPermissionAndRequest(Permission.storage);
    } else {
      // Android11
      return _checkPermissionAndRequest(Permission.manageExternalStorage);
    }
  }

  static Future<bool> hasManageExternalStorage() async {
    final status = await Permission.manageExternalStorage.status;
    if (status == PermissionStatus.restricted) {
      return _hasPermission(Permission.storage);
    } else {
      return _hasPermission(Permission.manageExternalStorage);
    }
  }

  static Future<bool> _hasPermission(Permission permission) async {
    var status = await permission.status;
    return status == PermissionStatus.granted;
  }

  static Future<bool> _checkPermissionAndRequest(Permission permission) async {
    if (await _hasPermission(permission)) {
      return true;
    }
    // 未授权则发起一次申请
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }
}
