import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managements_in_life/feature/travel/cubit/travel_cubit.dart';
import 'package:state_managements_in_life/feature/travel/model/travel_model.dart';
import 'package:state_managements_in_life/product/padding/page_padding.dart';
import 'package:kartal/kartal.dart';

class TravelView extends StatefulWidget {
  const TravelView({Key? key}) : super(key: key);

  @override
  State<TravelView> createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  final String data = "See all";
  final String data2 = "Popular destinations dear you";
  final String data3 = "Hey John!\nWhere do you want to go today?";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TravelCubit>(
      create: (context) => TravelCubit()..fetchItems(),
      child: BlocConsumer<TravelCubit, TravelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const PagePadding.all(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data3,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  context.emptySizedHeightBoxLow,
                  TextField(
                      onChanged: (value) {
                        context.read<TravelCubit>().searchByItems(value);
                      },
                      decoration: InputDecoration(prefixIcon: Icon(Icons.search), border: OutlineInputBorder())),
                  context.emptySizedHeightBoxLow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data2, style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          context.read<TravelCubit>().seeAllItems();
                        },
                        child: Text(data,
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: context.colorScheme.error)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.26),
                    child: _itemsCastale(context),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

   Widget _itemsCastale(BuildContext context) {
    return BlocSelector<TravelCubit, TravelStates, List<TravelModel>>(
      selector: (state) {
        return state is TravelItemsLoaded ? state.items : context.read<TravelCubit>().allItems;
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              child: SizedBox(
                  width: context.dynamicWidth(0.37), child: Image.asset(TravelModel.mockItems[index].imagePath)),
            );
          },
        );
      },
    );
  }
  }
