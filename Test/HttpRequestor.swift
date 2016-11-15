import Foundation
import CBGPromise

protocol HTTPRequester {
    func perform(request: NSURLRequest) -> Future<HttpRequestResult>
    func performSend(request: NSURLRequest) -> Future<HttpRequestResult>
}

class HTTPRequesterImpl: HTTPRequester {
    func perform(request: NSURLRequest) -> Future<HttpRequestResult> {
        let promise = Promise<HttpRequestResult>()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            func rejectPromise(reason: String) {
                promise.resolve(.failure((TestError("Failed Request: " + reason))))
            }
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                guard let response = response else { rejectPromise("response was nil"); return }
                guard let data = data else { rejectPromise("data was nil"); return }
                guard let httpResponse = response as? NSHTTPURLResponse else { rejectPromise("response was not a NSHTTPURLResponse"); return }
                guard httpResponse.statusCode == 200 else { rejectPromise("status code was: " + String(httpResponse.statusCode)); return }
                promise.resolve(.success(data: data))
            }
            
            task.resume()
        }
        
        return promise.future
    }
    
    func performSend(request: NSURLRequest) -> Future<HttpRequestResult> {
        let promise = Promise<HttpRequestResult>()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
        
        func rejectPromise(reason: String) {
        promise.resolve(.failure((TestError("Failed Request: " + reason))))
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
        guard let response = response else { rejectPromise("response was nil"); return }
        guard let data = data else { rejectPromise("data was nil"); return }
        guard let httpResponse = response as? NSHTTPURLResponse else { rejectPromise("response was not a NSHTTPURLResponse"); return }
        guard httpResponse.statusCode == 200 else { rejectPromise("status code was: " + String(httpResponse.statusCode)); return }
        promise.resolve(.success(data: data))
        }
        
        task.resume()
        }
        
        return promise.future
        }

}