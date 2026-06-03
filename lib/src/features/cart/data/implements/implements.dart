
    import 'package:targetshop/src/features/home/data/models/products_model.dart';

import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';

    class CartRepositoryImp implements CartRepository {

        final CartRemoteDataSource remoteDataSource;
        CartRepositoryImp({required this.remoteDataSource});

  @override
  Stream<List<ProductsModel>> streamUserProducts() {
    return remoteDataSource.streamUserProducts();
  }
      
    
    }
    