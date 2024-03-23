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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<SourcesState>(
          valueListenable: _controller,
          builder: (context, snapshot, child) {
            return _controller.isNextButtonVisible()
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
          }),
      body: SafeArea(
        child: ValueListenableBuilder<SourcesState>(
          valueListenable: _controller,
          builder: (context, state, child) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(SourcesState state) {
    List<Widget> widgets = [];

    if (state is LoadingSourcesState) {
      widgets.add(const Center(child: CircularProgressIndicator()));
    } else if (state is SuccessSourcesState) {
      widgets.addAll(_buildSuccessLayout(state.sources));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  List<Widget> _buildSuccessLayout(List<SourceModel> sources) {
    List<SourceModel> filteredSources =
        _filterSources(sources, _searchController.text);

    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {},
              child: Text('All'),
            ),
          ),
        ],
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Header(
          content: 'Choose your news sources',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: filteredSources.length,
            itemBuilder: (context, index) {
              SourceModel sourceModel = filteredSources[index];
              return FutureBuilder<String?>(
                  future: FaviconExtractor.getFaviconUrl('${sourceModel.url}'),
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
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.warning);
                              },
                              fit: BoxFit.fitHeight,
                            )
                          : const SizedBox.shrink(),
                    );
                  });
            },
          ),
        ),
      ),
    ];
  }

  List<SourceModel> _filterSources(List<SourceModel> allSources, String query) {
    return allSources
        .where((source) =>
            source.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
