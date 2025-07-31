import 'package:hive_ce/hive.dart';
import 'package:api/dtos/mapbox_sessiontoken.dart';

@GenerateAdapters([AdapterSpec<MapboxSessiontoken>()])
part 'hive_adapters.g.dart';
