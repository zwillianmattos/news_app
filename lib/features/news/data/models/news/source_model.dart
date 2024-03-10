import 'package:news_app/features/news/domain/entities/source.dart';

class SourceModel extends Source {

  bool isChecked = false;
  String? faviconUrl = '';

  SourceModel(this.isChecked, 
      {id,
      name,
      description,
      url,
      category,
      language,
      country});

  SourceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['url'] = url;
    data['category'] = category;
    data['language'] = language;
    data['country'] = country;
    return data;
  }
  
}
