//
//  CartViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 15/12/2022.
//

import UIKit


class CartViewController: UIViewController, UIGestureRecognizerDelegate {
  
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var checkOut: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var models: CartItem?
    var response: CartAddedItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: "CustomItemsCell", bundle: nil), forCellReuseIdentifier: "CustomItemsCell")
        self.myTableView.register(CustomItemsCell.self, forCellReuseIdentifier: "tableViewCell")
        
        APICaller.shared.getCartItems { resul in
            
        }
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        CustomizedView.setViewConstrainsts(with: containerView)
        customNavbarItems()
        checkOut.layer.cornerRadius = checkOut.frame.height / 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
