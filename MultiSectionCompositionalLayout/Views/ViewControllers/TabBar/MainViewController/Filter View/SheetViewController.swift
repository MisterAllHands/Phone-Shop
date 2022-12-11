//
//  SheetViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 08/12/2022.
//

import UIKit
import DropDown

class SheetViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceViewLabel: UILabel!
    
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var sizeViewLabel: UILabel!
    
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!

    
    let brandArray = ["Samsung","Xiaomi", "Iphone"]
    let priceArray = ["250-400","$500-$1000", "$1000-1500"]
    let sizeArray = ["4.5 to 5.5 inches", "6.0 to 6.5 inches"]
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        brandView.tag = 0
        priceView.tag = 1
        sizeView.tag = 2
        
        slideIdicator.layer.cornerRadius = 5
        brandView.layer.cornerRadius = 10
        priceView.layer.cornerRadius = 10
        sizeView.layer.cornerRadius = 10
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    //MARK: - Setting Tap Gesture Recognizer
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Implementing DropDown Menu
        
    func showViews(with tag: Int){
        
        switch tag{
        case 0:
            dropDown.dataSource = brandArray
            setlectedItem(items: brandArray, label: brandLabel)
            dropDown.direction = .bottom
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!-45)
        case 1:
            dropDown.dataSource = priceArray
            setlectedItem(items: priceArray, label: priceViewLabel)
            dropDown.direction = .bottom
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!+80)
        case 2:
            dropDown.dataSource = sizeArray
            setlectedItem(items: sizeArray, label: sizeViewLabel)
            dropDown.direction = .top
            dropDown.topOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 190)
        default:
            return
        }
        
        func setlectedItem(items: [String], label: UILabel){
            
            dropDown.anchorView = brandView
            dropDown.selectionAction = {(index: Int, item: String) in
                label.text = items[index]
            }
            
            //MARK - Customizing DropDown
            dropDown.cellHeight = 50
            
            if #available(iOS 16.0, *) {
                dropDown.textFont = .systemFont(ofSize: 20, weight: .regular, width: .standard)
                dropDown.cornerRadius = 10
            } else {
                // Fallback on earlier versions
            }
        }
        dropDown.show()
    }
    
    //MARK: - Presenting DropDownMenu
    
    @IBAction func presentDropDown(_ sender: AnyObject){
        
        guard let button = sender as? UIButton else {return}
        switch button.tag{
        case 0:
            showViews(with: 0)
        case 1:
            showViews(with: 1)
        case 2:
            showViews(with: 2)
        default:
            return
        }
        dropDown.show()
    }
}
