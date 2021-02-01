//
//  GetProductsTableViewController.swift
//  A2_FA_ios_Baljeet_782220
//
//  Created by Mac on 01/02/21.
//

import UIKit
import CoreData

class ProviderProductViewController: UITableViewController {
    var selectedProvider : Providers?
    var products : [Products] = []
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = selectedProvider{
            let req : NSFetchRequest<Products> =  Products.fetchRequest()
            products = try! context.fetch(req)
            products = products.filter({$0.provider?.provider_name == selectedProvider?.provider_name})
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text =
            products[indexPath.row].product_name
        cell.detailTextLabel?.text = products[indexPath.row].provider?.provider_name

        return cell
    }
    

}
