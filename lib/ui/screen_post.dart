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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.postList.length,
              itemBuilder: (context, index) {
                final item = state.postList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade200,
                     child: Text(item.id.toString()),
                  ),
                  title: Text(item.email.toString()),
                  subtitle: Text(item.body.toString()),
                );
              },
            );
          case PostStatus.failure:
            return Text(state.message.toString());
        }
      },
    );
  }
}
