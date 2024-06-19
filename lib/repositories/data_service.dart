import 'dart:io';

import 'package:healthy_minder/models/conversation.dart';
import 'package:healthy_minder/models/get_goals_diseases_response.dart';
import 'package:healthy_minder/models/login_response_model.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/models/notification.dart';
import 'package:healthy_minder/models/plan.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/models/profile.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/models/select_plan.dart';
import 'package:healthy_minder/models/timeline_event.dart';
import 'package:healthy_minder/repositories/essential_methods.dart';
import 'package:healthy_minder/utils/constances.dart';

class DataService with EssentialMethod {
  static final DataService _singleton = DataService._internal(debugMode: true);
  late final String baseUrl;

  factory DataService() {
    return _singleton;
  }

  DataService._internal({debugMode = false}) {
    baseUrl = debugMode ? "http://${Constance.hostName}:8000" : "";
  }

  Future<ReturnType<LoginResponse?>?> login(
      String email, String password) async {
    String route = "/api/login";
    Uri uri = Uri.parse("$baseUrl$route");
    ReturnType<LoginResponse?>? response =
        await createPostRequest<LoginResponse>(
      uri: uri,
      body: {
        "email": email,
        "password": password,
      },
      fromJson: (json) => LoginResponse.fromJson(json),
      key: "data",
    );
    return response;
  }

  Future<ReturnType<LoginResponse?>?> register(
      Map<String, dynamic> sendData) async {
    String route = "/api/register";
    Uri uri = Uri.parse("$baseUrl$route");
    return await createPostRequest(
      uri: uri,
      body: sendData,
      fromJson: (json) => LoginResponse.fromJson(json),
      key: "data",
    );
  }

  Future<ReturnType<PremiumStatus?>?> myPremiumStatus(String token) async {
    String route = "/api/is-premium";
    ReturnType<PremiumStatus?>? response =
        await createGetRequest<PremiumStatus>(
      url: "$baseUrl$route",
      fromJson: (json) => PremiumStatus.fromValue(json),
      key: "status",
      headers: createAuthHeader(token),
    );
    return response;
  }

  Future<ReturnType<GetGoalsAndDiseasesResponse?>?>
      getGoalsAndDiseasesResponse() async {
    String route = "/api/goals-diseases";
    ReturnType<GetGoalsAndDiseasesResponse?>? response =
        await createGetRequest<GetGoalsAndDiseasesResponse>(
      url: "$baseUrl$route",
      fromJson: (json) => GetGoalsAndDiseasesResponse.fromJson(json),
      key: "gd",
    );
    return response;
  }

  Future<ReturnType<Profile?>?> getProfile(String token) async {
    String route = "/api/profile";
    return await createGetRequest(
      url: "$baseUrl$route",
      fromJson: (json) => Profile.fromJson(json),
      key: "profile",
      headers: createAuthHeader(token),
    );
  }

  Future<void> sendNewMessage(
    String token,
    int channelId,
    String message,
  ) async {
    String route = "/api/send-new-message";
    Uri uri = Uri.parse("$baseUrl$route");
    createPostRequest(
      fromJson: null,
      headers: createAuthHeader(token),
      uri: uri,
      body: {
        "message": message,
        "conversation": channelId.toString(),
      },
    );
  }

  Future<ReturnType<List<Message>?>?> getConversationOldMessages(
      String token, int conversationId) async {
    String route = "/api/load-conversation-old-message/";
    return await createGetRequest<List<Message>?>(
      fromJson: (json) =>
          (json as List).map((message) => Message.fromJson(message)).toList(),
      key: "messages",
      headers: createAuthHeader(token),
      url: "$baseUrl$route$conversationId",
    );
  }

  Future<ReturnType<List<SelectPlan>?>?> getPlanOfGoalsAndDiseases(
      String token, Map data) async {
    String route = "/api/get-plan-of-goals-diseases/";
    return await createGetRequest<List<SelectPlan>>(
      headers: createAuthHeader(token),
      url: "$baseUrl$route",
      params: data,
      key: "plans",
      fromJson: (j) => SelectPlan.fromListJson(j),
    );
  }

  Future<ReturnType<dynamic>?> selectPlanTimeline(String token, int id) async {
    String route = "/api/select-plan-timeline";
    Uri uri = Uri.parse("$baseUrl$route");
    return await createPostRequest(
      uri: uri,
      body: {
        "id": id.toString(),
      },
      headers: createAuthHeader(token),
    );
  }

  Future<ReturnType<List<Notification>?>?> loadMyNotifications(
      String token) async {
    String route = "/api/all-notifications";
    return await createGetRequest(
      headers: createAuthHeader(token),
      url: "$baseUrl$route",
      key: "notifications",
      fromJson: (json) => Notification.listFromJson(json),
    );
  }

  Future<ReturnType<List<Notification>?>?> loadMyUnreadNotifications(
      String token) async {
    String route = "/api/unread-notifications";
    return await createGetRequest(
      headers: createAuthHeader(token),
      url: "$baseUrl$route",
      key: "notifications",
      fromJson: (json) => Notification.listFromJson(json),
    );
  }

  Future<ReturnType<SavedUser?>?> updateProfileAvatar(
      String token, File compressedFile) async {
    String route = "/api/update-profile-avatar";
    Uri uri = Uri.parse("$baseUrl$route");
    return await createPostWithFileRequest(
      uri: uri,
      files: [compressedFile],
      headers: createAuthHeader(token),
      key: "user",
      fromJson: (json) => SavedUser.fromJson(json),
    );
  }

  Future<ReturnType<String?>?> sendPremiumRequest(
      String token, String code) async {
    String route = "/api/send-premium-request";
    Uri uri = Uri.parse("$baseUrl$route");
    return await createPostRequest(
      uri: uri,
      headers: createAuthHeader(token),
      body: {
        "code": code,
      },
    );
  }

  Future<ReturnType<SavedUser?>?> me(String token) async {
    String route = "/api/me";
    return await createGetRequest(
      url: "$baseUrl$route",
      headers: createAuthHeader(token),
      key: "user",
      fromJson: (json) => SavedUser.fromJson(json),
    );
  }

  sendNotificationSeen(String token, String notId) async {
    String route = "/api/send-notification-seen";
    Uri uri = Uri.parse("$baseUrl$route");
    return await createPostRequest(
      uri: uri,
      headers: createAuthHeader(token),
      body: {
        "id": notId,
      },
    );
  }

  Future<ReturnType<Conversation?>?> getCoachConversationWithMe(
      String token) async {
    String route = "/api/get-coach-conversation-with-me";
    return await createGetRequest(
      url: "$baseUrl$route",
      headers: createAuthHeader(token),
      key: "conversation",
      fromJson: (json) => Conversation.fromJson(json),
    );
  }

  Future<ReturnType<List<TimelineEvent>?>?> getTodayEvents(String token) async {
    String route = "/api/timeline/today-events";
    return await createGetRequest(
      url: "$baseUrl$route",
      headers: createAuthHeader(token),
      key: "events",
      fromJson: (json) =>
          (json as List).map((j) => TimelineEvent.fromJson(j)).toList(),
    );
  }

  Future<ReturnType<List<TimelineEvent>?>?> getTimelineEvents(
      String token) async {
    String route = "/api/timeline/events";
    return await createGetRequest(
      url: "$baseUrl$route",
      headers: createAuthHeader(token),
      key: "events",
      fromJson: (json) =>
          (json as List).map((j) => TimelineEvent.fromJson(j)).toList(),
    );
  }
}
