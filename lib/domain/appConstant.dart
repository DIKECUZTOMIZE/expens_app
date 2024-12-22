import 'package:exoenseapp/data/local/model/catModel.dart';

class AppConstant{


  /// Const  dile erros show korw karon : Object creat kora karone Const nahe
  /// aru object creat kora hoi okl runtimer babe aitu karone dynamic buli kua hoi runtime, aru Const compile timer babe
static List<CatModel>mCat=[
   CatModel(idCat:1,title:'fast Food' ,imagePath:'assets/icons/fast-food.png'),
   CatModel(idCat:2,title:'makeup' , imagePath:'assets/icons/makeup-pouch.png'),
   CatModel(idCat:3,title:'wine' ,imagePath:'assets/icons/wine-bottle.png'),
   CatModel(idCat:4,title:'restruant' ,imagePath:'assets/icons/restaurant.png'),
   CatModel(idCat:5,title:'bottel' ,imagePath:'assets/icons/icons_bottel.jpeg'),
   CatModel(idCat:6,title:'transfer' ,imagePath:'assets/icons/mobile-transfer.png'),
   CatModel(idCat:7,title:'travel' ,imagePath:'assets/icons/travel.png'),
   CatModel(idCat:8,title:'watch' ,imagePath:'assets/icons/watch.png'),
   CatModel(idCat:9,title: 'hot-pot' ,imagePath:'assets/icons/hot-pot.png'),
 ];
}