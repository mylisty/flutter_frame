import 'package:flutter_frame/Test.dart';

test2FromJson(Test2 data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['outStationEnable'] != null) {
		data.outStationEnable = json['outStationEnable'];
	}
	if (json['motorcadeSecurityEnable'] != null) {
		data.motorcadeSecurityEnable = json['motorcadeSecurityEnable'];
	}
	if (json['source'] != null) {
		data.source = json['source'];
	}
	return data;
}

Map<String, dynamic> test2ToJson(Test2 entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['outStationEnable'] = entity.outStationEnable;
	data['motorcadeSecurityEnable'] = entity.motorcadeSecurityEnable;
	data['source'] = entity.source;
	return data;
}