import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brik/common/helpers/enum.dart';
import 'package:brik/features/user/presentation/provider/get_list_user_activity_notifier.dart';

class UserActivityPage extends StatefulWidget {
  static const route = '/user-activity';
  const UserActivityPage({super.key});

  @override
  State<UserActivityPage> createState() => UserActivityPageState();
}

class UserActivityPageState extends State<UserActivityPage> {

  late GetListUserActivityNotifier userActivityNotifier;

  Future<void> getData() async {
    if(!mounted) return;
      await userActivityNotifier.getUserActivity();

  }

  @override 
  void initState() {
    super.initState();

    userActivityNotifier = context.read<GetListUserActivityNotifier>();

    Future.microtask(() => getData());
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return Future.sync(() {

          });
        },
        child: Consumer<GetListUserActivityNotifier>(
          builder: (__, notifier, _) {

            return CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
            
                SliverAppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: const SizedBox(),
                ),

                if(notifier.state == ProviderState.loading)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                 if(notifier.state == ProviderState.error)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(notifier.message)
                    ),
                  ),
            
                SliverList.builder(
                  itemCount: notifier.usersActivityItem.length,
                  itemBuilder: (BuildContext context, int i) {
                    final user = notifier.usersActivityItem[i];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(user.fullname),
                          subtitle: Text(user.isOnline 
                          ? "Sedang Online"
                          : user.lastActive,
                            style: const TextStyle(
                              fontSize: 10.0
                            ),
                          ),
                          trailing: user.isOnline
                          ? const Icon(
                              Icons.circle, 
                              color: Colors.green, 
                              size: 12.0
                            )
                          : const Icon(
                            Icons.circle, 
                            color: Colors.grey, 
                            size: 12.0
                          ),
                        ),

                        const Divider(),

                      ],
                    );
                  },
                )
            
              ],
            );
          },
        )
      )
    );
  }
}