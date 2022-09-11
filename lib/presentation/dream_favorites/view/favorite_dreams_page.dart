import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/data/dream/dream_rates.dart';
import 'package:dream_app_bloc/presentation/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream/view/widget/dream_failed_fetch.dart';
import 'package:dream_app_bloc/presentation/dream_favorites/favorite_dreams.dart';
import 'package:dream_app_bloc/presentation/dream_favorites/view/widget/no_favorite_dream.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDreamsPage extends StatelessWidget {
  const FavoriteDreamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: const Text(
                'Saved Dreams',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dreams,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FavoriteDreamBloc, FavoriteDreamState>(
                builder: (context, state) {
                  switch (state.status) {
                    case FavoriteDreamStatus.error:
                      return const DreamFailedFetch();
                    case FavoriteDreamStatus.success:
                      if (state.dreams.isEmpty) {
                        return const NoFavoriteDream();
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.dream,
                                arguments: state.dreams[index],
                              );
                            },
                            child: _favoriteDreamsList(
                                context, state.dreams[index],),
                          );
                        },
                        itemCount: state.dreams.length,
                        separatorBuilder: (
                          BuildContext context,
                          int index,
                        ) =>
                            const Divider(thickness: 3.0),
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _favoriteDreamsList(BuildContext context, Dream dream) {
    return Dismissible(
      key: Key(dream.id),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.indigo,
        child: Row(
          children: const [
            Icon(
              Icons.favorite_border_rounded,
              color: Colors.white60,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Remove from favorite',
              style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        context
            .read<FavoriteDreamBloc>()
            .add(FavoriteDreamChanged(id: dream.id, favorite: false));
        context.read<DreamBloc>().add(const DreamsFetched());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dream.title,
              style: const TextStyle(
                color: AppColors.dreams,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              dream.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  dream.category,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  ratings[dream.rate].rateStr,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  ratings[dream.rate].emoji,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
