import UIKit

class Items: NSObject {
    var trackName:String?
    var artistName: String?
    var collectionName:String?
    var artworkUrl100:String?
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    func stringToImage(string : String) -> UIImage? {
        let imageURL = NSURL.init(string: string)
        let data = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: data!)
        return image!
    }
}
