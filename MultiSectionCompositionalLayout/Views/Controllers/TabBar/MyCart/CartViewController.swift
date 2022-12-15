//
//  CartViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 15/12/2022.
//

import UIKit

class CartViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        CustomizedView.setViewConstrainsts(with: containerView)
        customNavbarItems()
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
