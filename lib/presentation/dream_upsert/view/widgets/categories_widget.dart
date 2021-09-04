import 'package:dream_app_bloc/repositories/dream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../upsert_dream.dart';

class CategoriesWidget extends StatelessWidget {
  final bool isEditing;
  const CategoriesWidget({Key? key, required this.isEditing}) : super(key: key);

  static const _categoriesString = [
    "Fiction",
    "Fantasy",
    "Horror",
    "Love",
    "Sex",
    "Drama",
    "Suspense",
    "Action"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Text('Categories:'),
        const SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            shrinkWrap: true,
            itemCount: _categoriesString.length,
            itemBuilder: (context, index) {
              return BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                builder: (context, state) {
                  final selectedIndex = isEditing
                      ? _categoriesString.indexOf(state.category)
                      : state.categoriesIndex;
                  return InkWell(
                    onTap: () {
                      context.read<UpsertDreamBloc>().add(
                          UpsertCategoriesIndexChanged(categoriesIndex: index));
                      context.read<UpsertDreamBloc>().add(UpsertCategoryChanged(
                          category: _categoriesString[index]));
                    },
                    child: Card(
                      shape: selectedIndex == index
                          ? RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0))
                          : RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0)),
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.ac_unit),
                          const Text('Cusom icon '),
                          const SizedBox(height: 8.0),
                          Text(_categoriesString[index])
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
