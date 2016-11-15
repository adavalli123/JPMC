
//Swinject supports automatic dependency injection to view controllers instantiated by SwinjectStoryboard

/* Link: https://bitbucket.org/tillsterdev/bk-native-app/src/0d6f1002d95bc30247081532e178613a3ed2b1d8/BKO/SwinjectStoryboard+Setup.swift?at=master&fileviewer=file-view-default */

import Swinject

extension SwinjectStoryboard {
    class func setup() {
        
//        To register dependencies of a view controller, use registerForStoryboard method.
        defaultContainer.registerForStoryboard(LoadingVC.self) { resolver, controller in
            controller.shoppingService = resolver.resolve(ShoppingItemService.self)
            controller.mainThreadExecuter = resolver.resolve(MainThreadExecuter.self)
            controller.product = resolver.resolve(Product.self)
//
        }
        
        defaultContainer.registerForStoryboard(MainVC.self) { resolver, controller in
            controller.product = resolver.resolve(Product.self)
        }
        
        defaultContainer.registerForStoryboard(DetailVC.self) { resolver, controller in
        }
        
        // Services
        defaultContainer.register(ShoppingItemService.self) { resolver in
            ShoppingItemServiceImpl(
                product: resolver.resolve(Product.self)!,
                requestProvider: resolver.resolve(RequestProvider.self)!,
                httpRequester: resolver.resolve(HTTPRequester.self)!,
                shoppingParser: resolver.resolve(ShoppingParser.self)!
            )
        }
        
        // MARK: Utilities
        defaultContainer.register(RequestProvider.self) { resolver in
            RequestProviderImpl()
        }
        
        defaultContainer.register(ShoppingParser.self) { resolver in
            ShoppingParser(product: resolver.resolve(Product.self)!)
        }
        
        defaultContainer.register(HTTPRequester.self) { resolver in
            HTTPRequesterImpl()
        }
        
        // MARK: Singletons
        defaultContainer.register(Product.self) { resolver in
            Product(items: [])
            }.inObjectScope(.Container)
        
        defaultContainer.register(MainThreadExecuter.self) { resolver in
            MainThreadExecuterImpl()
            }.inObjectScope(.Container)
    }
}