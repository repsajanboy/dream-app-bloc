import 'package:dream_app_bloc/data/user/user.dart';
import 'package:dream_app_bloc/presentation/profile_setting/profile_setting.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _firstNameField(context),
          const SizedBox(height: 20.0),
          _lastNameField(context),
          const SizedBox(height: 20.0),
          _emailField(context),
        ],
      ),
    );
  }

  Widget _firstNameField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        builder: (context, state) {
          return TextFormField(
            initialValue:
                state.firstName != "" ? state.firstName : user!.firstName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppColors.dreams,
            style: context.typo.editProfileStyle(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'First Name',
              hintStyle: context.typo.editProfileHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) => null,
            onChanged: (value) {
              context
                  .read<ProfileSettingBloc>()
                  .add(const ProfileEditDataChanged(someDataChanged: true));
              context
                  .read<ProfileSettingBloc>()
                  .add(ProfileFirstNameChanged(firstName: value));
            },
          );
        },
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        builder: (context, state) {
          return TextFormField(
            initialValue:
                state.lastName != "" ? state.lastName : user!.lastName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppColors.dreams,
            style: context.typo.editProfileStyle(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Last Name',
              hintStyle: context.typo.editProfileHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) => null,
            //state.isLastNameNotEmpty ? null : 'Please enter your last name.',
            onChanged: (value) {
              context
                  .read<ProfileSettingBloc>()
                  .add(const ProfileEditDataChanged(someDataChanged: true));
              context
                  .read<ProfileSettingBloc>()
                  .add(ProfileLastNameChanged(lastName: value));
            },
          );
        },
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        builder: (context, state) {
          return TextFormField(
            initialValue: state.email != "" ? state.email : user!.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppColors.dreams,
            style: context.typo.editProfileStyle(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Email Address',
              hintStyle: context.typo.editProfileHintStyle(),
              errorStyle: context.typo.authErrorStyle(),
            ),
            validator: (value) => null,
            //EmailValidator.validate(value!) ? null : 'Invalid Email',
            onChanged: (value) {
              context
                  .read<ProfileSettingBloc>()
                  .add(const ProfileEditDataChanged(someDataChanged: true));
              context
                  .read<ProfileSettingBloc>()
                  .add(ProfileEmailChanged(email: value));
            },
          );
        },
      ),
    );
  }
}
