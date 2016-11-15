//
//  MainVC.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/15/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var product: Product!
    var searchSong: Product!
    var inSearchSong = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationCustomeTitle(UIColor.redColor(), title: "HOME", fontSize: 28.0)
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.backItem?.title = ""
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchSong {
            searchSong.items.count
        }
        return product.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCellIdentifier",forIndexPath: indexPath) as? ProductTableViewCell
        
        if inSearchSong {
            cell?.configure(searchSong.items[indexPath.row])
        }
        else {
            cell!.configure(product.items[indexPath.row])
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if inSearchSong {
            self.performSegueWithIdentifier("showDetail", sender: searchSong.items[indexPath.row])
        }
        else {
            self.performSegueWithIdentifier("showDetail", sender: product.items[indexPath.row])
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "showDetail"?:
            let detailVC = segue.destinationViewController as? DetailVC
            let nxt = sender as? Items
            detailVC?.item = nxt
            
        default:
            break
        }
    }
    
    private func navigationCustomeTitle(color: UIColor, title: String, fontSize: CGFloat) {
        let titleLabel = UILabel()
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(fontSize), NSForegroundColorAttributeName: color, NSKernAttributeName : 5.0]
        titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
}

