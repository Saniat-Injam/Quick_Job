import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchScreenController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxString searchText = ''.obs;
  final RxList<String> recentSearches = <String>[].obs;
  // final RxList<SearchModel> suggestions = <SearchModel>[
  //   const SearchModel(title: 'Cleaning'),
  //   const SearchModel(title: 'Driver & Delivery'),
  //   const SearchModel(title: 'Designer'),
  // ].obs;

  static const String _recentKey = 'recent_searches';

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }

  /// Load recent searches from local storage
  void loadRecentSearches() {
    final List<dynamic>? stored = storage.read<List>(_recentKey);
    if (stored != null) {
      // Convert dynamic list to List<String>
      recentSearches.assignAll(stored.map((e) => e.toString()));
    }
  }

  /// Add a search query
  void addSearch(String query) {
    query = query.trim();
    if (query.isEmpty) return;

    // Remove duplicate if exists
    recentSearches.removeWhere(
      (element) => element.toLowerCase() == query.toLowerCase(),
    );
    // Add to front
    recentSearches.insert(0, query);

    // Limit to 10 items
    if (recentSearches.length > 10) {
      recentSearches.removeRange(10, recentSearches.length);
    }

    // Persist plain List<String> to GetStorage
    storage.write(_recentKey, recentSearches.toList());

    // Update observable
    searchText.value = query;
  }

  /// Clear all recent searches
  void clearRecent() {
    recentSearches.clear();
    storage.remove(_recentKey);
  }

  /// Optional: remove a single search item
  void removeRecent(String query) {
    recentSearches.remove(query);
    storage.write(_recentKey, recentSearches.toList());
  }
}
