import 'package:flutter/material.dart';
import 'package:state_managements_in_life/feature/login/viewmodel/login_view_model.dart';
import 'package:state_managements_in_life/product/constant/image_enum.dart';
import 'package:kartal/kartal.dart';
import 'package:state_managements_in_life/product/model/state/user_context.dart';
import 'package:state_managements_in_life/product/padding/page_padding.dart';
import 'package:state_managements_in_life/product/utility/input_decoration.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String _login = "Login";
  final String _name = "Name";
  final String _rememberme = "Remember me";

  final LoginViewModel _loginViewModel = LoginViewModel();
  @override
  void initState() {
    super.initState();
    //_loginViewModel = LoginViewModel();
  }

   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginViewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.read<UserContext?>()?.name ?? ''),
            leading: _loadingWidget(),
          ),
          body: Padding(
            padding: const PagePadding.allLow(),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: context.durationLow,
                  height: context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.2),
                  width: context.dynamicWidth(0.3),
                  child: ImageEnums.door.toImage,
                ),
                Text(
                  _login,
                  style: context.textTheme.headline3,
                ),
                TextField(decoration: ProjectInputs(_name)),
                ElevatedButton(
                    onPressed: _loginViewModel.isLoading
                        ? null
                        : () {
                            _loginViewModel.controlTextValue();
                          },
                    child: Center(child: Text(_login))),
                CheckboxListTile(
                  value: _loginViewModel.isCheckBoxOkay,
                  title: Text(_rememberme),
                  onChanged: (value) {
                    _loginViewModel.checkboxChange(value ?? false);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
    Widget _loadingWidget() {
    return Selector<LoginViewModel, bool>(
      selector: (context, viewModel) {
        return viewModel.isLoading;
      },
      builder: (context, value, child) {
        return value ? const Center(child: CircularProgressIndicator()) : const SizedBox();
      },
    );
    return Consumer<LoginViewModel>(builder: (context, value, child) {
      return value.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox();
    });
  }
}

