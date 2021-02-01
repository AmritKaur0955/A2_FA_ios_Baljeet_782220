//
//  MainViewController.swift
//  A2_FA_ios_Baljeet_782220
//
//  Created by Mac on 01/02/21.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    var productArray : [Products] = []
    var providerArray : [Providers] = []
    var isProductSelected = true
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProducts()
    }
    
    func getAllProducts(){
        productArray = []
        productArray = try! context.fetch(Products.fetchRequest())
        put10Products()
        tableView.reloadData()
    }
    func put10Products(){
        let provider = Providers(context: context)
        let provider2 = Providers(context: context)
        
        if productArray.isEmpty{
            for i in 1...10{
                let product  = Products(context: context)
                product.product_desc = "drinking \(i)"
                product.product_id = "\(i)"
                
                product.product_price = "\(i)000"
                
                if i%2 == 0 {
                    provider.provider_name = "RedBull"
                    product.product_name = "Bull \(i)"
                    product.provider = provider
                }
                else{
                    provider2.provider_name = "MonsterDrink"
                    product.product_name = "Monster \(i)"
                    product.provider = provider2
                }
                
                
            }
            try! context.save()
            getAllProducts()
        }
       
    }
    
    @IBAction func addButton(_ sender: Any) {
        
    }
    @IBAction func switchPressed(_ sender: UIButton) {
        if sender.title(for: .normal) == "Products"{
            isProductSelected = true
        }
        else{
            isProductSelected = false
        }
    }
}
extension MainViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "product_name contains[c] '\(searchText)' || product_desc contains[c] '\(searchText)'")
            let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
            fetchRequest.predicate = predicate
            do {
                productArray = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
        }
        else{
            getAllProducts()
            
        }
        tableView.reloadData()
    }
    
}
extension MainViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isProductSelected{
            return productArray.count
        }
        else{
            return providerArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =
            productArray[indexPath.row].product_name
        cell.detailTextLabel?.text = productArray[indexPath.row].provider?.provider_name
        return cell
    }
    
    
}
