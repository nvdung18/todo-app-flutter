import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/providers/blog_provider.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late Future<List<PostModel>> _postsFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _postsFuture = BlogProvider().fetchPosts();
  }

  // Danh sách featured news
  final List<Map<String, String>> featuredNews = [
    {
      'category': 'TECHNOLOGY',
      'title':
          'Microsoft launches a deepfake detector tool ahead of US election',
      'time': '3 min ago',
      'image':
          'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/News_z5vgv3',
    },
    {
      'category': 'BUSINESS',
      'title': 'Apple announces new MacBook Pro with M3 chip',
      'time': '5 min ago',
      'image':
          'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_2_n2gdwi',
    },
    {
      'category': 'SCIENCE',
      'title': 'NASA successfully launches new Mars rover mission',
      'time': '10 min ago',
      'image':
          'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_1_nwfxdx',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder(
        future: _postsFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${asyncSnapshot.error}',
                    style: TextStyle(color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No friends found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          final posts = asyncSnapshot.data!;
          return SafeArea(
            child: Stack(
              // Thay Column thành Stack
              children: [
                // Main content
                Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          16,
                          16,
                          100,
                        ), // Thêm bottom padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeaturedNewsSlider(posts.take(3).toList()),
                            const SizedBox(height: 24),
                            _buildLatestNewsSection(),
                            const SizedBox(height: 16),
                            _buildNewsList(posts),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Floating bottom navigation
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: _buildBottomNavigation(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Menu button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),

          const Spacer(),

          // App Title
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'News',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'App',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Voice button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.mic_none, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedNewsSlider(List<PostModel> posts) {
    return Column(
      children: [
        // Carousel Slider
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemCount: posts.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(featuredNews[index]['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category and time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            posts[index].tags.join(', ').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          featuredNews[index]['time']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Title
                    Text(
                      posts[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        _buildActionButton(Icons.chat_bubble_outline),
                        const SizedBox(width: 16),
                        _buildActionButton(Icons.bookmark_border),
                        const Spacer(),
                        _buildActionButton(Icons.share),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // Dots indicator with tap functionality
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            featuredNews.length,
            (index) => GestureDetector(
              onTap: () {
                _carouselController.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.blue
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildLatestNewsSection() {
    return Row(
      children: [
        const Text(
          'Latest News',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Icon(Icons.more_horiz, color: Colors.grey[600]),
      ],
    );
  }

  Widget _buildNewsList(List<PostModel> posts) {
    // final List<Map<String, String>> newsList = [
    //   {
    //     'category': 'TECHNOLOGY',
    //     'title': 'Insurtech startup PasarPolis gets \$54 million — Series B',
    //     'image':
    //         'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_2_n2gdwi',
    //   },
    //   {
    //     'category': 'TECHNOLOGY',
    //     'title': 'The IPO parade continues as Wish files, Bumble targets',
    //     'image':
    //         'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_1_nwfxdx',
    //   },
    //   {
    //     'category': 'TECHNOLOGY',
    //     'title': 'Hypatos gets \$11.8M for a deep learning',
    //     'image':
    //         'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_w6rgq5',
    //   },
    // ];

    return Column(children: posts.map((post) => _buildNewsItem(post)).toList());
  }

  Widget _buildNewsItem(PostModel post) {
    // Example: If you want a list of image URLs, use List<String>
    final List<String> listImage = [
      'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_2_n2gdwi',
      'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_1_nwfxdx',
      'https://res.cloudinary.com/dwbgxpb0o/image/upload/f_auto,q_auto/v1/aaaa/Image_w6rgq5',
    ];

    // Lấy random image
    final randomIndex = Random().nextInt(listImage.length);
    final randomImage = listImage[randomIndex];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // News image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(randomImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // News content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Text(
                  post.tags.join(', ').toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                // Title
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.all(16), // Margin để navbar nổi lên
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25), // Bo tròn
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, true),
            _buildNavItem(Icons.bookmark_border, false),
            _buildNavItem(Icons.search, false),
            _buildNavItem(Icons.notifications_none, false),
            _buildNavItem(Icons.settings, false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey[400],
        size: 22,
      ),
    );
  }
}
