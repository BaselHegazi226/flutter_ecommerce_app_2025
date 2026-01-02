import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/cart_model.dart';
import '../cart_repo/cart_repo.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, GetCartResult>> call() {
    return repository.getCart();
  }
}

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, AddToCartResult>> call(CartModel model) {
    return repository.addToCart(model);
  }
}

class UpdateProductCountUseCase {
  final CartRepository repository;

  UpdateProductCountUseCase(this.repository);

  Future<Either<Failure, GetCartResult>> call(int productId, int newCount) {
    return repository.updateProductCount(productId, newCount);
  }
}

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.clearCart();
  }
}

class RemoveProductCartById {
  final CartRepository cartRepository;
  RemoveProductCartById(this.cartRepository);
  Future<Either<Failure, void>> call(int productId) {
    return cartRepository.clearProductCartById(id: productId);
  }
}
