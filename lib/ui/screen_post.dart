import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/bloc/post_bloc.dart';
import 'package:post/bloc/post_event.dart';
import 'package:post/bloc/post_state.dart';
import 'package:post/utils/enums.dart';

class ScreenPost extends StatefulWidget {
  const ScreenPost({super.key});

  @override
  State<ScreenPost> createState() => _ScreenPostState();
}

class _ScreenPostState extends State<ScreenPost> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<PostBloc>().add(FetchPost());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Demo Post Bloc",
          softWrap: true,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: _postScreen(),
    );
  }

  Widget _postScreen() {
    return BlocBuilder<PostBloc, PostStates>(
      builder: (context, state) {
        switch (state.postStatus) {
          case PostStatus.loading:
            return const CircularProgressIndicator();
          case PostStatus.success:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Search with email",
                        border: OutlineInputBorder()),
                    onChanged: (filterKey) {
                      context.read<PostBloc>().add(SearchItem(filterKey));
                    },
                  ),
                ),
                Expanded(
                  child: state.searchMessage.isNotEmpty
                      ? Center(
                          child: Text(state.searchMessage.toString()),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.tempPostList.isEmpty
                              ? state.postList.length
                              : state.tempPostList.length,
                          itemBuilder: (context, index) {
                            if (state.tempPostList.isNotEmpty) {
                              final item = state.tempPostList[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  child: Text(item.id.toString()),
                                ),
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),
                              );
                            } else {
                              final item = state.postList[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  child: Text(item.id.toString()),
                                ),
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),
                              );
                            }
                          },
                        ),
                ),
              ],
            );
          case PostStatus.failure:
            return Text(state.message.toString());
        }
      },
    );
  }
}
