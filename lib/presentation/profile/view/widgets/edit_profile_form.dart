import 'package:flutter/material.dart';
import 'package:dream_app_bloc/utils/extension/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
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
        color: Colors.indigo.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFetchedSuccess) {
            return TextFormField(
              initialValue: state.user.firstName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.white,
              style: context.typo.editProfileStyle(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'First Name',
                hintStyle: context.typo.authHintStyle(),
                errorStyle: context.typo.authErrorStyle(),
              ),
              validator: (value) => null,
              onChanged: (value) {
                print(value);
                // context
                //     .read<RegisterBloc>()
                //     .add(RegisterFirstNameChanged(firstName: value));
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.indigo.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFetchedSuccess) {
            return TextFormField(
              initialValue: state.user.lastName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.white,
              style: context.typo.editProfileStyle(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Last Name',
                hintStyle: context.typo.authHintStyle(),
                errorStyle: context.typo.authErrorStyle(),
              ),
              validator: (value) => null,
              //state.isLastNameNotEmpty ? null : 'Please enter your last name.',
              onChanged: (value) {
                print(value);
                // context
                //     .read<RegisterBloc>()
                //     .add(RegisterLastNameChanged(lastName: value));
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.indigo.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFetchedSuccess) {
            return TextFormField(
              initialValue: state.user.email,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.white,
              style: context.typo.editProfileStyle(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email Address',
                hintStyle: context.typo.authHintStyle(),
                errorStyle: context.typo.authErrorStyle(),
              ),
              validator: (value) => null,
              //EmailValidator.validate(value!) ? null : 'Invalid Email',
              onChanged: (value) {
                print(value);
                //context.read<RegisterBloc>().add(RegisterEmailChanged(email: value));
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
