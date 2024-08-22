import 'package:greengrocer/src/models/cart_items.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/models/product.dart';

Product apple = Product(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/images/fruits/apple.png',
  productName: 'Maçã',
  price: 5.5,
  unit: 'KG',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

Product grape = Product(
  imgUrl: 'assets/images/fruits/grape.png',
  productName: 'Uva',
  price: 7.4,
  unit: 'KG',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

Product guava = Product(
  imgUrl: 'assets/images/fruits/guava.png',
  productName: 'Goiaba',
  price: 11.5,
  unit: 'KG',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

Product kiwi = Product(
  imgUrl: 'assets/images/fruits/kiwi.png',
  productName: 'Kiwi',
  price: 2.5,
  unit: 'UN',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

Product mango = Product(
  imgUrl: 'assets/images/fruits/mango.png',
  productName: 'Manga',
  price: 2.5,
  unit: 'UN',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

Product papaya = Product(
  imgUrl: 'assets/images/fruits/papaya.png',
  productName: 'Mamão papaya',
  price: 8,
  unit: 'KG',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  category: Category(id: 'AHu5fWo4RS', name: 'Frutas'),
);

// Lista de produtos
List<Product> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

// Lista do Carrinho
List<CartItems> cartItems = [
  CartItems(product: apple, quantity: 2),
  CartItems(product: mango, quantity: 1),
  CartItems(product: guava, quantity: 3),
];
