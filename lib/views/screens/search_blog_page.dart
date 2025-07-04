import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/providers/blog_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<PostModel>> _postsFuture;

  final BlogProvider _blogProvider = BlogProvider();
  Timer? _debounce;
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Gọi API hoặc logic search tại đây
      setState(() {
        _postsFuture = _blogProvider.searchPosts(query);
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _postsFuture = _blogProvider.fetchPosts();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // Dummy data
  final List<Map<String, String>> videos = [
    {
      'title': 'The IPO parade continues as Wish files',
      'image':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Insurtech PasarPolis',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Insurtech PasarPolis',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Insurtech PasarPolis',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    },
  ];

  final List<String> news = [
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Hypatos gets \$11.8M for a deep learning approach',
    'The IPO parade continues as Wish files, Bumble targets continues as parade',
    'The IPO parade continues as Wish files, Bumble targets continues as parade',
    'Hypatos gets \$11.8M for a deep learning approach',
    'Hypatos gets \$11.8M for a deep learning approach',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
    'Insurtech startup PasarPolis gets \$54 million — Series B',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF141E28),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: _onSearchChanged,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Videos section
              Row(
                children: [
                  const Text(
                    '13 Videos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: videos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            video['image']!,
                            width: 180,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 12,
                          right: 12,
                          child: Text(
                            video['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 4),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              NewsSection(postsFuture: _postsFuture),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, size: 28),
            Icon(Icons.bookmark_border, size: 28),
            IconButton(
              icon: Icon(Icons.search, size: 28),
              onPressed: null, // Placeholder for add action
            ),
            Icon(Icons.notifications_none, size: 28),
            Icon(Icons.person_outline, size: 28),
          ],
        ),
      ),
    );
  }
}

class NewsSection extends StatelessWidget {
  final Future<List<PostModel>> postsFuture;
  const NewsSection({Key? key, required this.postsFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: postsFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        } else if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
          return Center(child: Text('No news found'));
        }
        final posts = asyncSnapshot.data!;
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '78 News',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {},
                        child: Text(
                          posts[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
