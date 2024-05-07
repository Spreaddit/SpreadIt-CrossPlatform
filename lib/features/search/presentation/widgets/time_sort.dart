/// A function that takes a list of posts and filters them according to a passed time period

List<Map<String, dynamic>> sortByTime(List<Map<String, dynamic>> posts,String timePeriod) {
    posts.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    final filteredPosts = posts.where((post) {
      final createdAt = DateTime.parse(post['createdAt']);
      switch (timePeriod) {
        case 'Past hour':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(hours: 1)));
        case 'Today':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 1)));
        case 'Past week':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 7)));
        case 'Past month':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)));
        case 'Past year':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 365)));
        default:
          return true; 
      }
    }).toList();

    return filteredPosts;
  }