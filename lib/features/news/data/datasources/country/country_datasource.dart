import 'package:news_app/features/news/data/models/country/country_model.dart';

class CountryDataSource {
  List<CountryModel> getAll(){
    return [
          CountryModel(code: 'AE', name: 'United Arab Emirates'),
          CountryModel(code: 'AR', name: 'Argentina'),
          CountryModel(code: 'AT', name: 'Austria'),
          CountryModel(code: 'AU', name: 'Australia'),
          CountryModel(code: 'BE', name: 'Belgium'),
          CountryModel(code: 'BG', name: 'Bulgaria'),
          CountryModel(code: 'BR', name: 'Brazil'),
          CountryModel(code: 'CA', name: 'Canada'),
          CountryModel(code: 'CH', name: 'Switzerland'),
          CountryModel(code: 'CL', name: 'Chile'),
          CountryModel(code: 'CN', name: 'China'),
          CountryModel(code: 'CO', name: 'Colombia'),
          CountryModel(code: 'CZ', name: 'Czech Republic'),
          CountryModel(code: 'DE', name: 'Germany'),
          CountryModel(code: 'EG', name: 'Egypt'),
          CountryModel(code: 'FR', name: 'France'),
          CountryModel(code: 'GB', name: 'United Kingdom'),
          CountryModel(code: 'GR', name: 'Greece'),
          CountryModel(code: 'HK', name: 'Hong Kong'),
          CountryModel(code: 'HU', name: 'Hungary'),
          CountryModel(code: 'ID', name: 'Indonesia'),
          CountryModel(code: 'IE', name: 'Ireland'),
          CountryModel(code: 'IL', name: 'Israel'),
          CountryModel(code: 'IN', name: 'India'),
          CountryModel(code: 'IT', name: 'Italy'),
          CountryModel(code: 'JP', name: 'Japan'),
          CountryModel(code: 'KR', name: 'South Korea'),
          CountryModel(code: 'LK', name: 'Sri Lanka'), 
    ];
  }
}