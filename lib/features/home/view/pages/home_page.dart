import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/common/styles/styles.dart';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/home/view/widgets/favourite_widget.dart';
import 'package:my_app_flutter/features/home/view/widgets/food_widget.dart';
import 'package:my_app_flutter/features/home/view/widgets/menu_category_widget.dart';
import 'package:my_app_flutter/features/home/viewmodel/favourite_viewmodel.dart';
import 'package:my_app_flutter/features/home/viewmodel/food_viewmodel.dart';
import 'package:provider/provider.dart';
import '/features/base_page.dart';
class HomePage extends BasePage {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends BaseState<HomePage> {
  late FavouriteViewModel favouriteViewModel;
  late FoodViewModel foodViewModel;
  List<MenuCategory> menuCategories = <MenuCategory>[];
  static List<String> categoryTitle = <String>[
    AppFiles.shared.language("all list", "all list"),
    AppFiles.shared.language("vietnamese list", "vietnamese list"),
    AppFiles.shared.language("korean list", "korean list"),
    AppFiles.shared.language("japanese list", "japanese list"),
  ];
  int _indexTab = 0;
  @override
  void initState() {
    favouriteViewModel = Provider.of<FavouriteViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favouriteViewModel.fetchFavouritesJson();
    });

    foodViewModel = Provider.of<FoodViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      foodViewModel.fetchFoodsJson();
    });
    createMenuCategoryWidgets();
    super.initState();
  }
  @override
  void didUpdateWidget(HomePage oldWidget) {
    // this method IS called when parent widget is rebuilt
    super.didUpdateWidget(oldWidget);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppStyles.preferredSize(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                    children: List.generate(menuCategories.length, 
                                (index)=> MenuCategoryWidget(menuCategories[index], 
                                                            onClicked: (int i) {
                                                              menuSelected(i);
                                                            }, 
                                                            callbackOnClicked: () {  
                                                            },
                                          )
                                    ),
                      ),
          ),
          AppStyles.searchContainer(
              AppFiles.shared.language("search food", "search food")),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: AppStyles.categoryTitle(AppFiles.shared
                        .language("favourite food", "favourite food")),
                  ),
                  Consumer<FavouriteViewModel>(builder: (context, value, child){
                    return FavouriteWidget(value.favourites); 
                  }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: AppStyles.categoryTitle(categoryTitle[_indexTab]),
                  ),
                  Consumer<FoodViewModel>(builder: (context, value, child){
                    return FoodWidget(value.foods); 
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void menuSelected(int index) {
    MenuCategory menuCategory = menuCategories[_indexTab];
    menuCategory.indexSelected = -1;

    menuCategory = menuCategories[index] ;
    menuCategory.indexSelected = index;
    setState(() => _indexTab = index);   
  }
  void createMenuCategoryWidgets(){
    menuCategories.add(MenuCategory(
      index: 0,
      indexSelected: _indexTab,
      name: AppFiles.shared.language("all", "all"),
    ));
    menuCategories.add(MenuCategory(
      index: 1,
      indexSelected: _indexTab,
      name: AppFiles.shared.language("vietnamese", "vietnamese"),
    ));
    menuCategories.add(MenuCategory(
      index: 2,
      indexSelected: _indexTab,
      name: AppFiles.shared.language("korean", "korean"),
    ));
    menuCategories.add(MenuCategory(
      index: 3,
      indexSelected: _indexTab,
      name: AppFiles.shared.language("japanese", "japanese"),
    ));
  }
}
