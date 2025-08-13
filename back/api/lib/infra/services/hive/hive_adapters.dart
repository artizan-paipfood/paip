import 'package:hive_ce/hive.dart';
import 'package:api/domain/dtos/mapbox_sessiontoken.dart';

@GenerateAdapters([AdapterSpec<MapboxSessiontoken>()])
part 'hive_adapters.g.dart';
