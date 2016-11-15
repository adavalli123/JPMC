import Foundation

import CBGPromise

protocol ShoppingItemService {
    func updateList() -> Future<ParserResult<Product>>
    func updateLyric(item: Items) -> Future<ParserResult<Product>>
}

class ShoppingItemServiceImpl: ShoppingItemService {
    let product: Product
    let requestProvider: RequestProvider
    let httpRequester: HTTPRequester
    let shoppingParser: ShoppingParser
    
    init(product: Product, requestProvider: RequestProvider, httpRequester: HTTPRequester,  shoppingParser: ShoppingParser) {
        self.product = product
        self.requestProvider = requestProvider
        self.httpRequester = httpRequester
        self.shoppingParser = shoppingParser
    }
    
    func updateList() -> Future<ParserResult<Product>> {
        let shoppingPromise = Promise<ParserResult<Product>>()
        
        httpRequester.perform(requestProvider.getShoppingItemsRequest()!)
            .then { httpResult in
                switch httpResult {
                case .success(let data):
                    shoppingPromise.resolve(self.shoppingParser.requestMethod(data))
                case .failure(let error):
                    shoppingPromise.resolve(.failure(error))
                }
        }
        return shoppingPromise.future
    }
    
    func updateLyric(item: Items) -> Future<ParserResult<Product>> {
        let shoppingPromise = Promise<ParserResult<Product>>()
        
        httpRequester.performSend(requestProvider.createURLWithComponents(item)!)
            .then { httpResult in
                switch httpResult {
                case .success(let data):
                    shoppingPromise.resolve(self.shoppingParser.requestLyric(data))
                case .failure(let error):
                    shoppingPromise.resolve(.failure(error))
                }
        }
        return shoppingPromise.future
    }

}