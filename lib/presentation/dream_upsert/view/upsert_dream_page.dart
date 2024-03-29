import 'package:dream_app_bloc/data/dream/dream.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/upsert_dream.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/view/widgets/categories_widget.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/view/widgets/content_widget.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/view/widgets/rating_widget.dart';
import 'package:dream_app_bloc/presentation/dream_upsert/view/widgets/title_save_widget.dart';
import 'package:dream_app_bloc/routing/app_router_names.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/extension/string_extension.dart';
import 'package:dream_app_bloc/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UpsertDreamPage extends StatelessWidget {
  UpsertDreamPage({Key? key, required this.isEditing, this.dream})
      : super(key: key);
  final bool isEditing;
  final Dream? dream;

  final _pageController = PageController();
  //int _currPage = 0;
  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      context.read<UpsertDreamBloc>().add(UpsertToEdit(postDream: dream!));
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<UpsertDreamBloc, UpsertDreamState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmitting) {
            context.loaderOverlay.show();
          } else if (formStatus is SubmissionSuccess) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.menu,
              arguments: 0,
            );
          } else if (formStatus is SubmissionFailed) {
            Fluttertoast.showToast(
              msg: formStatus.error!.errorMessage(),
              gravity: ToastGravity.TOP,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        child: LoaderOverlay(
          overlayOpacity: 0.8,
          child: ColoredBox(
            color: AppColors.background,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                SizedBox(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.dreams,
                        ),
                        tooltip: 'Back',
                        onPressed: () {
                          if (_pageController.page == 0) {
                            Navigator.of(context).pop();
                          } else {
                            _pageController.previousPage(
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 200),
                            );
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 200),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.dreams,
                          ),
                        ),
                        child: BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                          builder: (context, state) {
                            if (state.pageViewIndex == 3) {
                              return Container();
                            } else {
                              return const Text('Next');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (value) {
                        context.read<UpsertDreamBloc>().add(
                              UpsertPageViewIndexChanged(pageViewIndex: value),
                            );
                      },
                      children: [
                        ContentFormWidget(
                          isEditing: isEditing,
                          content: isEditing ? dream!.content : '',
                        ),
                        CategoriesWidget(isEditing: isEditing),
                        RatingWidget(isEditing: isEditing),
                        TitleSaveWidget(isEditing: isEditing),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
