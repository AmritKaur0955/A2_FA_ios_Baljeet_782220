////
////  AddProviderViewController.swift
////  A2_FA_ios_Baljeet_782220
////
////  Created by Mac on 01/02/21.
////
//
//import UIKit
//import CoreData
//
//class AddProviderViewController: UIViewController {
//    let context =
//            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    @IBOutlet weak var textProvider: UITextField!
//    var selectedProvider : Providers?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let pro = selectedProvider{
//            textProvider.text = pro.provider
//        }
//
//    }
//    
//    @IBAction func save(_ sender: Any) {
//        if let pro = selectedProvider{
//            pro.provider = textProvider.text
//        }
//        else{
//            let req : NSFetchRequest<Providers> = Provider.fetchRequest()
//            req.predicate = NSPredicate(format: "provider = '\(textProvider.text!)'")
//            let storeProvider = try! context.fetch(req)
//            if storeProvider.count == 0{
//                let provider = Providers(context: context)
//                provider.provider = textProvider.text
//                
//                textProvider.text = nil
//            }
//        }
//        
//        try! context.save()
//    }
//   
//}
