import Foundation

enum HttpRequestResult: Equatable {
    case success(data: NSData)
    case failure(TestError)
}

func ==(lhs: HttpRequestResult, rhs: HttpRequestResult) -> Bool {
    switch (lhs, rhs) {
    case (.success(let lhsData), .success(let rhsData)) where lhsData == rhsData: return true
    case (.failure(let lhsError), .failure(let rhsError)) where lhsError == rhsError: return true
    default: return false
    }
}