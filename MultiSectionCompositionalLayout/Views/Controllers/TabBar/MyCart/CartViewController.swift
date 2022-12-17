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
    
    
    var models: [Basket] = []
    var response: CartAddedItems?
    
         
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavbarItems()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        APICaller.shared.getCartItems { result in
            switch result {
            case .success(let data):
                self.models = data.basket
            case .failure(let failure):
                print(failure)
            }
        }
        
        fetchLocalStorageForFavorites()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //MARK - Registering cells
        
        myTableView.register(UINib(nibName: "CustomItemsCell", bundle: nil), forCellReuseIdentifier: "CustomItemsCell")
        self.myTableView.register(CustomItemsCell.self, forCellReuseIdentifier: "tableViewCell")
        
        //MARK - Sending notification one the button gets tapped
        
        let nc3 = NotificationCenter.default
        nc3.addObserver(self, selector: #selector(tingTaped),
                        name: Notification.Name( "updateView"), object: nil)
        
        CustomizedView.setViewConstrainsts(with: containerView)
        checkOut.layer.cornerRadius = checkOut.frame.height / 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func fetchLocalStorageForFavorites(){
        
        DatapersistantManager.shared.fetchingDataToDataBase {[weak self] result in
            switch result{
            case .success(let baskets):
                self?.models = baskets as! [Basket]
                
                DispatchQueue.main.async {
                    self?.myTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
    
    @objc private func fbButtonPressed() {
        
        let alert = UIAlertController(title: "Error", message: "Sorry! We couldn't detect your location. Please try again later!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Got it", style: .cancel )
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)

    }

}

//MARK: - TableView Delegate & Datasource Methods
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomItemsCell", for: indexPath) as! CustomItemsCell
        cell.setUpWith(item: self.models[indexPath.row])
        
        return cell
    }

    
    
    @objc func tingTaped(){
        
       print("ting")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            tableView.reloadData()
            
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func deletesItem(){
       
        DatapersistantManager.shared.deleteDataFromDatabase(model: models[indexPath.row]) { result in
            switch result{
            case .success():
                print("Successfully deleted Item")
            case .failure():
                print("Error while deleting the item at selected row ")
            }
        }
        
    }
}
