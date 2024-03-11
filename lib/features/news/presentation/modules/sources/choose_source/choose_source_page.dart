import 'package:cached_network_image/cached_network_image.dart';
import 'package:fav_grab/extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:headline/headline.dart';
import 'package:news_app/features/news/data/models/news/source_model.dart';

import 'choose_source_controller.dart';

class ChooseSourcesPage extends StatefulWidget {
  const ChooseSourcesPage({super.key});

  @override
  State<ChooseSourcesPage> createState() => _ChooseSourcesPageState();
}

class _ChooseSourcesPageState extends State<ChooseSourcesPage> {
  final ChooseSourcesController _controller =
      Modular.get<ChooseSourcesController>();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                const Header(
                  content: 'Choose your news sources',
                ),
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder<SourcesState>(
          valueListenable: _controller,
          builder: (context, snapshot, child) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: _controller.isNextButtonVisible() ? FloatingActionButton.extended(
                isExtended: true,
                onPressed: () {},
                label: const Text('Next'),
              ) : null,
            );
          }),
      body: ValueListenableBuilder<SourcesState>(
          valueListenable: _controller,
          builder: (context, snapshot, child) {
            bool isLoading = snapshot is LoadingSourcesState;
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot is SuccessSourcesState) {
              List<SourceModel> allSources = snapshot.sources;
              List<SourceModel> filteredSources =
                  _filterSources(allSources, _searchController.text);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: filteredSources.length,
                  itemBuilder: (context, index) {
                    SourceModel sourceModel = filteredSources[index];
                    return FutureBuilder<String?>(
                        future: FaviconExtractor.getFaviconUrl(
                            '${sourceModel.url}'),
                        builder: (context, favIconSnapshot) {
                          return CheckBoxWidget(
                            text: '${sourceModel.name}',
                            isChecked: sourceModel.isChecked,
                            onChecked: (bool value) {
                              setState(() {
                                sourceModel.isChecked = value;
                              });
                            },
                            icon: favIconSnapshot.hasData &&
                                    favIconSnapshot.data != null
                                ? CachedNetworkImage(
                                    imageUrl: '${favIconSnapshot.data}',
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.warning),
                                  )
                                : Container(),
                          );
                        });
                  },
                ),
              );
            }
            if (snapshot is ErrorSourcesState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(snapshot.errorMessage),
              );
            }
            return Container();
          }),
    );
  }

  List<SourceModel> _filterSources(List<SourceModel> allSources, String query) {
    return allSources
        .where((source) =>
            source.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
