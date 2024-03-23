import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:headline/headline.dart';
import 'package:news_app/features/news/data/models/country/country_model.dart';
import 'package:news_app/features/news/presentation/modules/country/choose_country/choose_country_controller.dart';

class ChooseYourCountryPage extends StatefulWidget {
  const ChooseYourCountryPage({super.key});

  @override
  State<ChooseYourCountryPage> createState() => _ChooseYourCountryPageState();
}

class _ChooseYourCountryPageState extends State<ChooseYourCountryPage> {
  final ChooseCountryController controller =
      Modular.get<ChooseCountryController>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<ChooseCountryState>(
        valueListenable: controller,
        builder: (context, snapshot, child) {
          return controller.isNextButtonVisible()
              ? Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFFFF2950),
                    elevation: 0,
                    isExtended: true,
                    onPressed: () {},
                    label: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      body: SafeArea(
        child: ValueListenableBuilder<ChooseCountryState>(
          valueListenable: controller,
          builder: (context, state, child) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(ChooseCountryState state) {
    List<Widget> widgets = [];
    if (state is LoadingChooseCountryState) {
      widgets.add(const Center(child: CircularProgressIndicator()));
    } else if (state is SuccessChooseCountryState) {
      widgets.addAll(_buildSuccessLayout(state.country));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  List<Widget> _buildSuccessLayout(List<CountryModel> countries) {
    List<CountryModel> filteredCountries =
        _filterCountries(countries, _searchController.text);

    return [
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Header(
          content: 'What is your country?',
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SearchBarWidget(
          controller: _searchController,
          label: "Search...",
          onChanged: (v) {
            setState(() {});
          },
        ),
      ),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredCountries.length,
          itemBuilder: (_, index) {
            return _buildCountryItem(filteredCountries[index], countries);
          },
        ),
      ),
    ];
  }

  Widget _buildCountryItem(
      CountryModel currentCountry, List<CountryModel> countries) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (var country in countries) {
            country.isChecked = false;
          }
          currentCountry.isChecked = true;
          int originalIndex = countries.indexOf(currentCountry);
          if (originalIndex != -1) {
            countries[originalIndex].isChecked = true;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: currentCountry.isChecked ? const Color(0xFF192e51) : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(
            currentCountry.name,
            style: TextStyle(
              color: currentCountry.isChecked ? Colors.white : Colors.black,
            ),
          ),
          trailing: currentCountry.isChecked
              ? Checkbox(
                  value: true,
                  onChanged: (v) {},
                )
              : null,
          leading: SizedBox(
            width: 60,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    'https://flagcdn.com/h80/${currentCountry.code.toLowerCase()}.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<CountryModel> _filterCountries(
      List<CountryModel> allSources, String query) {
    return allSources
        .where(
            (source) => source.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
