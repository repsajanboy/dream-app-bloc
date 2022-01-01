import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/data/dream/dream_rates.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../dream.dart';
import 'dream_failed_fetch.dart';
import 'dream_list_empty.dart';

class DreamList extends StatelessWidget {
  const DreamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamBloc, DreamState>(
      builder: (context, state) {
        switch (state.status) {
          case DreamStatus.error:
            return const DreamFailedFetch();
          case DreamStatus.success:
            if (state.dreams.isEmpty) {
              return const DreamListEmpty();
            }
            return ListView.builder(
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
                  child: _dreamBody(context, state.dreams[index]),
                );
              },
              itemCount: state.dreams.length,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _dreamBody(BuildContext context, Dream dream) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                DateFormat.d().format(dream.inputDate),
                style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dreams),
              ),
              Text(
                DateFormat.MMM().format(dream.inputDate).toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                DateFormat.y().format(dream.inputDate),
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120.0,
            width: MediaQuery.of(context).size.width * .75,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  bottomLeft: Radius.circular(18.0),
                ),
              ),
              color: Colors.white,
              elevation: 15.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        ratings[dream.rate].emoji,
                        style: TextStyle(
                            fontSize: 48.0,
                            color: Colors.grey.withOpacity(0.4)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dream.title,
                          style: const TextStyle(
                              color: AppColors.dreams,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          dream.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4.0),
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
                            Icon(
                              dream.favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              color: dream.favorite ? Colors.red.withOpacity(0.8) : Colors.black45,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
