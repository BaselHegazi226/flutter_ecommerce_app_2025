import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce_app_2025/core/errors/failure.dart';

import '../../features/07_cart_view/data/model/cart_model.dart';
import '../../features/07_cart_view/data/model/order_model.dart';
import '../errors/catch_error_handle.dart';

class ProductServices {
  ProductServices(this.userId);

  final String userId;

  final CollectionReference _cartCollectionReference = FirebaseFirestore
      .instance
      .collection('cart');

  final CollectionReference _orderCollectionReference = FirebaseFirestore
      .instance
      .collection('orders');

  Future<Either<Failure, Map<String, dynamic>?>>
  getCartListAndTotalFromFirebase() async {
    try {
      final data = await _cartCollectionReference.doc(userId).get();
      if (data.exists) {
        Map<String, dynamic> cartAndTotalAsMap =
            data.data() as Map<String, dynamic>;
        return right(cartAndTotalAsMap);
      }
      return right(null);
    } on FirebaseException catch (e) {
      debugPrint('firebase exception : $e=============.');
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } on Exception catch (e) {
      debugPrint('exception : $e=============.');
      return left(CatchErrorHandle.catchBack(failure: e));
    } catch (e) {
      debugPrint('exceptionnnnnnnnn : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    }
  }

  Future<Either<Failure, void>> addCartToFireBase({
    required List<CartModel> cartModelList,
    required double totalPrice,
  }) async {
    try {
      List<dynamic> cartListToJson = cartModelList
          .map((cart) => cart.toJson())
          .toList();
      final cartListAsMap = {
        'cartList': cartListToJson,
        'addAt': FieldValue.serverTimestamp(),
        'totalPrice': totalPrice,
      };
      _cartCollectionReference.doc(userId).set(cartListAsMap);
      return (right(null));
    } on FirebaseException catch (e) {
      debugPrint('firebase exception : $e=============.');
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } on Exception catch (e) {
      debugPrint('exception : $e=============.');
      return left(CatchErrorHandle.catchBack(failure: e));
    } catch (e) {
      debugPrint('exceptionnnnnnnnn : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    }
  }

  Future<Either<Failure, void>> updateCartInFireBase({
    required List<CartModel> newCartModelList,
    required double newTotalPrice,
  }) async {
    try {
      List<dynamic> cartListToJson = newCartModelList
          .map((cart) => cart.toJson())
          .toList();
      final cartListAsMap = {
        'cartList': cartListToJson,
        'addAt': FieldValue.serverTimestamp(),
        'totalPrice': newTotalPrice,
      };
      _cartCollectionReference
          .doc(userId)
          .set(cartListAsMap, SetOptions(merge: true));
      return (right(null));
    } on FirebaseException catch (e) {
      debugPrint('firebase exception : $e=============.');
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } on Exception catch (e) {
      debugPrint('exception : $e=============.');
      return left(CatchErrorHandle.catchBack(failure: e));
    } catch (e) {
      debugPrint('exceptionnnnnnnnn : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    }
  }

  Future<Either<Failure, void>> deleteCartFromFireBase() async {
    try {
      _cartCollectionReference.doc(userId).delete();
      return (right(null));
    } on FirebaseException catch (e) {
      debugPrint('firebase exception : $e=============.');
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } on Exception catch (e) {
      debugPrint('exception : $e=============.');
      return left(CatchErrorHandle.catchBack(failure: e));
    } catch (e) {
      debugPrint('exceptionnnnnnnnn : $e=============.');
      return CatchErrorHandle.catchBack(failure: e);
    }
  }

  /// get all orders
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final doc = await _orderCollectionReference.doc(userId).get();
      if (!doc.exists) return right([]);

      final data = doc.data() as Map<String, dynamic>;
      final orders = (data['orders'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();

      return right(orders);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  /// add / update orders
  Future<Either<Failure, void>> saveOrders({
    required List<OrderModel> orders,
  }) async {
    try {
      await _orderCollectionReference.doc(userId).set({
        'orders': orders.map((e) => e.toJson()).toList(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }

  /// delete all orders
  Future<Either<Failure, void>> deleteOrders() async {
    try {
      await _orderCollectionReference.doc(userId).delete();
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.fromFirebaseException(exception: e));
    } catch (e) {
      return left(CatchErrorHandle.catchBack(failure: e));
    }
  }
}
