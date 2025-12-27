import 'package:clone_whatsapp_round34/src/core/animation/animation.dart';
import 'package:clone_whatsapp_round34/src/features/auth/presentation/pages/login_page.dart';
import 'package:clone_whatsapp_round34/src/features/auth/presentation/pages/register.dart';
import 'package:clone_whatsapp_round34/src/features/welcome/presentation/pages/welcome_page.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/pages/home_page.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/pages/starred_messages_page.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/pages/chat_page.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/pages/camera_page.dart';
import 'package:clone_whatsapp_round34/src/features/settings/presentation/pages/setting_page.dart';
import 'package:clone_whatsapp_round34/src/features/settings/presentation/pages/linked_devices_page.dart';
import 'package:clone_whatsapp_round34/src/features/profile/presentation/pages/profile_page.dart';
import 'package:clone_whatsapp_round34/src/features/status/presentation/pages/status_page.dart';
import 'package:clone_whatsapp_round34/src/features/status/presentation/pages/status_view_page.dart';
import 'package:clone_whatsapp_round34/src/features/status/presentation/pages/status_create_page.dart';
 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../features/navbar.dart';
import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
 case RoutesName.initial:
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          return CustomPageRoute(page: const HomePage());
        } else {
          return CustomPageRoute(page: const LoginPage());
        }

      case RoutesName.login:
        return CustomPageRoute(page: const LoginPage());
      case RoutesName.MainLayout:
        return CustomPageRoute(page: const MainLayout());

      case RoutesName.home:
        return CustomPageRoute(page: const HomePage());
      case RoutesName.register:
        return CustomPageRoute(page: const Register());
      case RoutesName.chat:
        return CustomPageRoute(page: const ChatPage());
      case RoutesName.camera:
        return CustomPageRoute(page: const CameraPage());
      case RoutesName.settings:
        return CustomPageRoute(page: const SettingPage());
      case RoutesName.linkedDevices:
        return CustomPageRoute(page: const LinkedDevicesPage());
      case RoutesName.profile:
        return CustomPageRoute(page: const ProfilePage());
      case RoutesName.status:
        return CustomPageRoute(page: const StatusPage());
      case RoutesName.statusView:
        return CustomPageRoute(page: const StatusViewPage());
      case RoutesName.statusCreate:
        return CustomPageRoute(page: const StatusCreatePage());
 
      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
