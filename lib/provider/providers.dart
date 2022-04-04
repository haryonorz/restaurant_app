import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/models/models.dart';

import '../common/style.dart';
import '../data/api/api_service.dart';
import '../data/preferences/preferences_helper.dart';
import '../data/response/responses.dart';
import '../utils/utils.dart';

part 'restaurants_provider.dart';
part 'search_restaurants_provider.dart';
part 'detail_restaurant_provider.dart';
part 'preferences_provider.dart';
part 'state.dart';
part 'database_provider.dart';
part 'scheduling_provider.dart';
