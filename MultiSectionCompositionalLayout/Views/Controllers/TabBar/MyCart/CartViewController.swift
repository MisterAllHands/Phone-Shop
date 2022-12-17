//
//  CartViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 15/12/2022.
//

import UIKit
import SwiftyStepper



class CartViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var checkOut: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var total: UILabel!
    
    
    var basketModels: [Baskets] = []
    var response: CartAddedItems?
         
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavbarItems()
        myTableView.delegate = self
        myTableView.dataSource = self
        fetchLocalStorageForFavorites()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //MARK - Registering cells
        
        myTableView.register(UINib(nibName: "CustomItemsCell", bundle: nil), forCellReuseIdentifier: "CustomItemsCell")
        self.myTableView.register(CustomItemsCell.self, forCellReuseIdentifier: "tableViewCell")
        
        //MARK - Sending notification one the button gets tapped
        
        let nc3 = NotificationCenter.default
        nc3.addObserver(self, selector: #selector(tingTaped(_:)),
                        name: Notification.Name( "updateView"), object: nil)
        
        
        CustomizedView.setViewConstrainsts(with: containerView)
        checkOut.layer.cornerRadius = checkOut.frame.height / 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    //Receiving Updates on item price and updating total price
    
    
    @objc func tingTaped(_ notification: NSNotification){
        let thePrice = notification.userInfo?["itemPrice"] as? String
        
        if let totalPrice = thePrice{
            
            self.total.text = "$\(totalPrice) USD"
        }
    }
    
    //MARK - Showing saved items
    
    private func fetchLocalStorageForFavorites(){
        
        DatapersistantManager.shared.fetchingDataToDataBase {[weak self] result in
            switch result{
            case .success(let baskets):
                self?.basketModels = baskets
                
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK - Creating left & right nav bar buttons
    
    func customNavbarItems(){
        
        let rightButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let leftButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        rightButton.setImage(UIImage(named: "location1"), for: .normal)
        leftButton.setImage(UIImage(named: "something"), for: .normal)
        //add function for button
        rightButton.addTarget(self, action: #selector(fbButtonPressed), for: UIControl.Event.touchUpInside)
        leftButton.addTarget(self, action: #selector(popToPrevious), for: UIControl.Event.touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    //Action for right bar button
    
    @objc private func fbButtonPressed() {
        
        let alert = UIAlertController(title: "Error", message: "Sorry! We couldn't detect your location. Please try again later!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Got it", style: .cancel )
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    //Action for left bar button
    
    @objc private func popToPrevious() {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView Delegate & Datasource Methods


extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomItemsCell", for: indexPath) as! CustomItemsCell
        cell.setUpWith(item: self.basketModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return basketModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            tableView.beginUpdates()
            DatapersistantManager.shared.deleteDataFromDatabase(model: self.basketModels[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            basketModels.remove(at: indexPath.row)
            tableView.endUpdates()
        default:
            break
        }
    }
}
