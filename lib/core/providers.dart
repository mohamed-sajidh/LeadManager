import 'package:lead_manager/view_models/access_view_model.dart';
import 'package:lead_manager/view_models/login_view_model.dart';
import 'package:lead_manager/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => AccessViewModel()),
  ChangeNotifierProvider(create: (_) => ProfileViewModel()),
];
