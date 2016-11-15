//
//  MainVC.swift
//  Test
//
//  Created by Srikanth Adavalli on 5/15/16.
//  Copyright © 2016 Srikanth Adavalli. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var product: Product!
    var searchSong = Product(items: [])
    var inSearchSong = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationCustomeTitle(UIColor.redColor(), title: "HOME", fontSize: 28.0)
        //        searchBar.delegate = self
        //        searchBar.returnKeyType = UIReturnKeyType.Done
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.backItem?.title = ""
        tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText:String, scope: String = "All")
    {
        searchSong.items = product.items!.filter{ item in
            return item.trackName!.lowercaseString.containsString(searchText.lowercaseString)
            
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""
        {
            return searchSong.items.count
        }
        
        return self.product.items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCellIdentifier",
                                                                     forIndexPath: indexPath) as? ProductTableViewCell else {
                                                                        return UITableViewCell() }
        
        if searchController.active && searchController.searchBar.text != ""
        {
            cell.configure(searchSong.items[indexPath.row])
        }
        else {
            cell.configure(product.items[indexPath.row])
        }
        return cell
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchSong = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            inSearchSong = true
            let searchText = searchBar.text!.lowercaseString
            searchSong.items =  product.items.filter( { $0.artistName!.rangeOfString(searchText) != nil })
            tableView.reloadData()
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

extension MainVC: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}