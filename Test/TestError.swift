import Foundation

class TestError: NSError {
    init(_ message: String) {
        super.init(domain: "Test", code: 0, userInfo: ["message": message])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}