import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/model/cart.dart';
import 'package:pet_life_gh/model/featured_products_model.dart';
import 'package:pet_life_gh/model/product.dart';
import 'package:pet_life_gh/model/user.dart';
import 'package:pet_life_gh/model/veterinarian.dart';
import 'package:pet_life_gh/screens/My%20Cart/component/body.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

List<dynamic> allVets = [];
List<dynamic> allUsersAdmini = [];
List<dynamic> allUsers = [];
List<dynamic> allProducts = [];
List<dynamic> allFavourites = [];
List<dynamic> allCart = [];
int petFoodCount = 0;
int petAccessoriesCount = 0;
int petClothingCount = 0;
List vetNames = [];

class ReadData {
  Future getUser() async {
    allUsers.clear();

    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('User ID', isEqualTo: loggedInUserId)
        .get();
    final userDocID = document.docs.single.id;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userDocID)
        .get();

    final documentData = querySnapshot.data()!;
    final user = UserData(
      name: documentData['Name'],
      email: documentData['Email'],
      userID: documentData['User ID'],
    );
    allUsers.add(user);
  }

  Future allUsersAdmin() async {
    allUsersAdmini.clear();

    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isNotEqualTo: 'admin@admin.com')
        .get();
    if (document.docs.isNotEmpty) {
      for (var doc in document.docs) {
        final userDocID = doc.id;
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userDocID)
            .get();

        final documentData = querySnapshot.data()!;
        final user = UserData(
          name: documentData['Name'],
          email: documentData['Email'],
          userID: documentData['User ID'],
        );
        allUsersAdmini.add(user);
      }
    }
  }

  Future getAllFeaturedProducts() async {
    featuredProdNames.clear();
    featuredProductLocation.clear();
    featuredProductPrice.clear();
    featuredProductAge.clear();
    featuredProductGender.clear();
    featuredProdPics.clear();

    final querySnapshot =
        await FirebaseFirestore.instance.collection('Featured Products').get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        final docID = document.id;
        final snapshot = await FirebaseFirestore.instance
            .collection('Featured Products')
            .doc(docID)
            .get();
        final documentData = snapshot.data()!;
        final featuredProductsData = FeaturedProductModel(
          pic: documentData['Image'],
          id: documentData['Product ID'],
          name: documentData['Name'],
          age: documentData['Age'],
          gender: documentData['Gender'],
          location: documentData['Location'],
          price: documentData['Price'],
        );
        featuredProdNames.add(featuredProductsData.name);
        featuredProductAge.add(featuredProductsData.age);
        featuredProductGender.add(featuredProductsData.gender);
        featuredProductLocation.add(featuredProductsData.location);
        featuredProductPrice.add(featuredProductsData.price);
        // featuredProdPics.add(featuredProductsData.pic);
      }
    }
  }

  Future getAllNewArrivals() async {
    newArrivalNames.clear();
    NewArrivalLocation.clear();
    NewArrivalPrice.clear();
    NewArrivalAge.clear();
    NewArrivalGender.clear();
    newArrivalPics.clear();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('New Arrival Products')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        final docID = document.id;
        final snapshot = await FirebaseFirestore.instance
            .collection('New Arrival Products')
            .doc(docID)
            .get();
        final documentData = snapshot.data()!;
        final featuredProductsData = FeaturedProductModel(
          pic: documentData['Image'],
          id: documentData['Product ID'],
          name: documentData['Name'],
          age: documentData['Age'],
          gender: documentData['Gender'],
          location: documentData['Location'],
          price: documentData['Price'],
        );
        newArrivalNames.add(featuredProductsData.name);
        NewArrivalAge.add(featuredProductsData.age);
        NewArrivalGender.add(featuredProductsData.gender);
        NewArrivalLocation.add(featuredProductsData.location);
        NewArrivalPrice.add(featuredProductsData.price.toString());
        // newArrivalsPics.add(featuredProductsData.pic);
      }
    }
  }

  Future getAllVets() async {
    allVets.clear();
    vetNames.clear();
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Veterinarian').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var document in querySnapshot.docs) {
          final docID = document.id;
          final snapshot = await FirebaseFirestore.instance
              .collection('Veterinarian')
              .doc(docID)
              .get();
          final documentData = snapshot.data()!;
          final vetData = VetData(
            pic: documentData['Image'],
            vetID: documentData['Vet ID'],
            name: documentData['Name'],
            number: documentData['Contact Number'],
            experience: documentData['Experience'],
            location: documentData['Location'],
            region: documentData['Region'],
            starsRating: documentData['Stars Rating'],
            experienceNumber: documentData['Experience'] == 'Expert (9+ Years)'
                ? '9+'
                : documentData['Experience'] == 'Professional (4-7)Years'
                    ? '(4-7)'
                    : documentData['Experience'] == 'Amateur (3-4)Years'
                        ? '(3-4)'
                        : '(1-3)',
          );
          allVets.add(vetData);
          vetNames.add(vetData.name);
        }
      }
    } on FirebaseException catch (err) {
      print(err.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllProducts() async {
    allProducts.clear();

    final querySnapshot =
        await FirebaseFirestore.instance.collection('All Products').get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        final documentData = document.data();
        print(documentData['Description']);
        final product = ProductData(
          image: documentData['Image'],
          productID: documentData['Product ID'],
          title: documentData['Title'],
          price: documentData['Price'],
          size: documentData['Size'],
          details: documentData['Details'],
          description: documentData['Description'],
          category: documentData['Category'],
        );
        print(allProducts[0].price);
        allProducts.add(product);
        print(allProducts);
      }
    }
  }

  Future getSelectedProducts(String tabName) async {
    allProducts.clear();

    if (tabName != 'Pet Products') {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('All Products')
          .where('Category', isEqualTo: tabName)
          // .where('User ID', isNotEqualTo: loggedInUserId)
          .get();

      print(querySnapshot.docs.length);

      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = [];
        bool isFavourited = false;
        final faveDocs = await FirebaseFirestore.instance
            .collection('Favourites')
            .where('User ID', isEqualTo: loggedInUserId)
            .get();

        if (faveDocs.docs.isNotEmpty) {
          prodIDs = faveDocs.docs.single.get('Product IDs');
        }
        for (var document in querySnapshot.docs) {
          final documentData = document.data();
          if (prodIDs.contains(documentData['Product ID'])) {
            isFavourited = true;
          } else {
            isFavourited = false;
          }
          final products = ProductData(
            title: documentData['Title'],
            category: documentData['Category'],
            details: documentData['Detail'],
            price: documentData['Price'],
            size: documentData['Size'],
            description: documentData['Description'],
            image: documentData['Image'],
            productID: documentData['Product ID'],
            favourite: isFavourited,
          );

          allProducts.add(products);
        }
      }
    } else {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('All Products')
          // .where('User ID', isNotEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = [];
        bool isFavourited = false;
        final faveDocs = await FirebaseFirestore.instance
            .collection('Favourites')
            .where('User ID', isEqualTo: loggedInUserId)
            .get();

        if (faveDocs.docs.isNotEmpty) {
          prodIDs = faveDocs.docs.single.get('Product IDs');
        }

        for (var document in querySnapshot.docs) {
          final documentData = document.data();
          if (prodIDs.contains(documentData['Product ID'])) {
            isFavourited = true;
          } else {
            isFavourited = false;
          }

          final products = ProductData(
            title: documentData['Title'],
            category: documentData['Category'],
            details: documentData['Detail'],
            price: documentData['Price'],
            size: documentData['Size'],
            description: documentData['Description'],
            image: documentData['Image'],
            productID: documentData['Product ID'],
            favourite: isFavourited,
          );

          allProducts.add(products);
        }
      }
    }
    print(allProducts);
  }

  Future getAllCartItems() async {
    allCart.clear();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final document = await FirebaseFirestore.instance
            .collection('Cart')
            .doc(loggedInUserId)
            .get();

        List cart = document.get('Cart');
        final cartLength = cart.length;
        print(cartLength);
        final documentData = document.data()!;

        for (int i = 0; i < cartLength; i++) {
          final cartData = CartData(
            userID: documentData['User ID'],
            productID: documentData['Cart'][i]['Product ID'],
            title: documentData['Cart'][i]['Title'],
            quantity: documentData['Cart'][i]['Number of Items'],
            image: documentData['Cart'][i]['Image'],
            size: documentData['Cart'][i]['Size'],
            price: documentData['Cart'][i]['Price'],
          );
          allCart.add(cartData);
        }
        print('DOne');
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future addFavourites(int index) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = querySnapshot.docs.single.get('Product IDs');
        if (!prodIDs.contains(allProducts[index].productID)) {
          prodIDs.add(allProducts[index].productID);
        } else {
          throw Exception(
              '${allProducts[index].title} has already been added to favourites.');
        }

        await FirebaseFirestore.instance
            .collection('Favourites')
            .doc(loggedInUserId)
            .update({'Product IDs': prodIDs});
      } else {
        await FirebaseFirestore.instance
            .collection('Favourites')
            .doc(loggedInUserId)
            .set({
          'Product IDs': [allProducts[index].productID],
          'User ID': loggedInUserId,
        });
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeFavourite(int index) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = querySnapshot.docs.single.get('Product IDs');
        if (prodIDs.contains(allProducts[index].productID)) {
          prodIDs.remove(allProducts[index].productID);
          await FirebaseFirestore.instance
              .collection('Favourites')
              .doc(loggedInUserId)
              .update({'Product IDs': prodIDs});
        }
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getFavourites() async {
    allProducts.clear();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = querySnapshot.docs.single.get('Product IDs');
        for (var docID in prodIDs) {
          final document = await FirebaseFirestore.instance
              .collection('All Products')
              .doc(docID)
              .get();
          final documentData = document.data()!;

          final product = ProductData(
            image: documentData['Image'],
            productID: documentData['Product ID'],
            title: documentData['Title'],
            price: documentData['Price'],
            size: documentData['Size'],
            details: documentData['Detail'],
            description: documentData['Description'],
            category: documentData['Category'],
            favourite: true,
          );

          allProducts.add(product);
          print(allProducts.length);
        }
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
