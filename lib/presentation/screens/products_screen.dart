import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/data/models/product_category.dart';

import '../blocs/products_bloc/products_bloc.dart';
import '../widgets/drawer_screen.dart';
import '../widgets/products_area.dart';
import '../widgets/products_filter_bottom_sheet.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Column(
              children: [
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('products-categories').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child:  CircularProgressIndicator(),
                      );
                    }

                    if(snapshot.hasError){
                      return Center(
                        child: Text('something went wrong'),
                      );
                    }

                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot
                              .data!
                              .docs
                              .map((e) => ProductCategory.fromSnapshot(e))
                              .toList()
                              .map((e){
                                return GestureDetector(
                                  onTap:(){
                                    context.read<ProductsBloc>().add(
                                        LoadProductsEvent(categoryId: e.id!)
                                    );
                                  },
                                  child: Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                    margin: EdgeInsets.all(8.0),
                                    child: Text(e.name,style: TextStyle(color: ThemeHelper.primaryColor),),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                );
                          }).toList(),
                        )
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value){
                            context.read<ProductsBloc>().add(
                                SearchProductsEvent(query: _searchController.text)
                            );
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: GestureDetector(
                                onTap: (){

                                },
                                child: Icon(Icons.search),
                              )
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        await showModalBottomSheet(
                            context: context,
                            builder: (context) => ProductFilteringBottomSheet()
                        );
                      },
                      child: Text('Filter',style: TextStyle(color: Colors.white),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        endDrawer: DrawerScreen(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/offer.jpg'),
                        fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('this is the offer text',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                            foregroundColor: MaterialStatePropertyAll(Colors.black)
                          ),
                          child: Text('know more'),
                          onPressed: (){

                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                BlocBuilder<ProductsBloc,ProductState>(
                  builder: (context,state){
                    switch(state.status){
                      case ProductsStatus.loading:
                        return Container(
                          alignment: Alignment.center,
                          height: 352,
                          child: CircularProgressIndicator(),
                        );
                      case ProductsStatus.success:
                        return ProductsArea(state: state,);
                      case ProductsStatus.emptySearch:
                        return Container(
                          alignment: Alignment.center,
                          height: 352,
                          child: Text('لم يتم العثور علي شيء',style: TextStyle(
                            fontSize: 30
                          ),),
                        );
                      case ProductsStatus.empty:
                        return Container(
                          alignment: Alignment.center,
                          height: 352,
                            child: Text('لا يوجد منتجات حاليا',style: TextStyle(
                                fontSize: 30
                            ),)
                        );
                      case ProductsStatus.initial:
                        return Container(
                          alignment: Alignment.center,
                          height: 352,
                          child: Text('قم باختيار نوع المنتجات',style: TextStyle(
                            fontSize: 30
                          ),),
                        );
                      case ProductsStatus.error:
                        return Center(
                          child: Text(state.error,style: const TextStyle(fontSize: 30),),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
