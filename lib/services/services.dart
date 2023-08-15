import 'package:flutter_tv/services/dummy_movies_service.dart';
import 'package:flutter_tv/services/dummy_tabs_service.dart';
import 'package:flutter_tv/services/movies_service.dart';
import 'package:flutter_tv/services/tabs_service.dart';

MoviesService getMoviesService() {
  return DummyMoviesService();
}

TabsService getTabService() {
  return DummyTabsService();
}
