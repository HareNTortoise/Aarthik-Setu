import 'package:aarthik_setu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../repository/govt_schemes.dart';

class GovernmentSchemesFinder extends StatefulWidget {
  const GovernmentSchemesFinder({super.key});

  @override
  State<GovernmentSchemesFinder> createState() => _GovernmentSchemesFinderState();
}

class _GovernmentSchemesFinderState extends State<GovernmentSchemesFinder> {
  static const _pageSize = 10;

  final PagingController<int, GovernmentScheme> _pagingController = PagingController(firstPageKey: 0);

  final TextEditingController _schemesSearchController = TextEditingController();
  final TextEditingController _genAIController = TextEditingController();

  bool _isUsingGenAI = false;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();

    // Add listener to the paging controller to handle page requests
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, RepositoryProvider.of<GovernmentSchemesRepository>(context));
    });

    // Add listener to the search controller to trigger refresh on search query change
    _schemesSearchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _schemesSearchController.removeListener(_onSearchChanged);
    _schemesSearchController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  // Trigger paging controller refresh on search query change
  void _onSearchChanged() {
    _pagingController.refresh();
  }

  // Fetch page function with filtering based on search query
  Future<void> _fetchPage(int pageKey, GovernmentSchemesRepository governmentSchemesRepository) async {
    try {
      final newItems = await governmentSchemesRepository.getSchemes(page: pageKey, limit: _pageSize);

      // Filter schemes based on the search query
      final filteredItems = newItems.where((scheme) {
        final query = _schemesSearchController.text.toLowerCase();
        return scheme.relatedScheme.toLowerCase().contains(query);
      }).toList();

      final isLastPage = filteredItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(filteredItems);
      } else {
        final nextPageKey = pageKey + filteredItems.length;
        _pagingController.appendPage(filteredItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isUsingGenAI ? 1000 : 800,
            height: _isUsingGenAI ? 275 : 60,
            onEnd: () {
              setState(() {
                _isTransitioning = false;
              });
            },
            child: _isUsingGenAI
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: _isTransitioning ? null : const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Column(
                        children: [
                          TextField(
                            controller: _genAIController,
                            maxLines: _isTransitioning ? 1 : 5,
                            decoration: InputDecoration(
                              hintText: _isTransitioning ? null : 'Search for government schemes using generative AI',
                              hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 20),
                            ),
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                          if (!_isTransitioning)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isUsingGenAI = false;
                                            _isTransitioning = true;
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                                          backgroundColor:
                                              WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: 50,
                                      child: FilledButton.tonal(
                                        onPressed: () async {
                                          final GovernmentSchemesRepository governmentSchemesRepository =
                                              RepositoryProvider.of<GovernmentSchemesRepository>(context);
                                          final String response =
                                              await governmentSchemesRepository.genAiResponse(_genAIController.text);
                                          if (context.mounted) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    child: Container(
                                                      width: 800,
                                                      padding: const EdgeInsets.all(20),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              'AI Response',
                                                              style: GoogleFonts.poppins(fontSize: 24),
                                                            ),
                                                            const SizedBox(height: 20),
                                                            Text(
                                                              response,
                                                              style: GoogleFonts.poppins(fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                          backgroundColor:
                                              WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.8)),
                                        ),
                                        child: Text(
                                          'Search',
                                          style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  )
                : SearchBar(
                    controller: _schemesSearchController,
                    textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20)),
                    leading: const Icon(Icons.search),
                    padding: WidgetStateProperty.all(const EdgeInsets.only(left: 20)),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    trailing: [
                      if (!_isUsingGenAI)
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              _isUsingGenAI = true;
                              _isTransitioning = true;
                            });
                          },
                          fillColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child: SvgPicture.asset(
                            "lib/assets/gemini.svg",
                            width: 25,
                          ),
                        )
                      else
                        RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child: SvgPicture.asset(
                            "lib/assets/google.svg",
                            width: 25,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 60),
        Container(
          height: 800,
          width: 1300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: PagedListView<int, GovernmentScheme>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<GovernmentScheme>(
              itemBuilder: (context, item, index) => Container(
                margin: const EdgeInsets.all(30),
                child: FilledButton.tonal(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.3)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.relatedScheme,
                          style: GoogleFonts.jost(fontSize: 36),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item.description,
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
