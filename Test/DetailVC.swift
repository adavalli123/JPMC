//
//  DetailVC.swift
//  Test
//
//  Created by Srikanth Adavalli on 6/11/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit
class DetailVC : UIViewController {
    
    @IBOutlet weak var prodTitle: UILabel!
    @IBOutlet weak var prodColor: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var fullImage: UIImageView!
    
    var item: Items!
    var lyric: Lyric!
    var itemName: String?
    
    override func viewDidLoad() {
        config(item)
        navigationCustomeTitle(UIColor.redColor(), title: "DETAIL", fontSize: 28.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    private func config(item: Items) {
        prodTitle.text = item.trackName
        prodColor.text = item.artistName
        prodPrice.text = item.collectionName
        fullImage.image = item.stringToImage("\(item.artworkUrl100!)")
    }
    
    private func navigationCustomeTitle(color: UIColor, title: String, fontSize: CGFloat) {
        let titleLabel = UILabel()
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(fontSize), NSForegroundColorAttributeName: color, NSKernAttributeName : 5.0]
        titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
//    func parserDidStartDocument(parser: NSXMLParser) {
//        items = []
//    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item" {
            itemName = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        itemName?.appendContentsOf(string)
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            lyric.lyric = itemName
            itemName = nil
        }
    }
}

struct Lyric {
    var lyric: String?
    init(lyric: String) {
        self.lyric = lyric
    }
}
