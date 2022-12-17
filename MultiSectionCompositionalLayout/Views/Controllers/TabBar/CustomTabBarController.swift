

import Foundation
import UIKit
import ChameleonFramework

protocol badgeQuantityUpdate {
    func removeItem()
    func add()
}


class TabBarController: UITabBarController {
    
    var customTabBarView = UIView(frame: .zero)
        
    // MARK: View lifecycle
    var initialValue: Int = 0
    var baskets: [Baskets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(addBadgeValue),
                       name: Notification.Name("addValue"), object: nil)
        
        let nc2 = NotificationCenter.default
        nc2.addObserver(self, selector: #selector(removeBadgeValue),
                        name: Notification.Name( "removeValue"), object: nil)
        

                DispatchQueue.main.async {[self] in
                    initialValue = baskets.count
                    tabBar.items?[1].badgeValue = "\(initialValue)"
                }

        ChangeRadiusOfTabbar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
        
    @objc func addBadgeValue(_ notification: NSNotification) {
            let changedValue = initialValue + 1
                DispatchQueue.main.async {
                    self.tabBar.items?[1].badgeValue = "\(changedValue)"
                }
            initialValue = changedValue
        
    }
    
    @objc func removeBadgeValue(_ notification: NSNotification) {
            let changedValue = initialValue - 1
            DispatchQueue.main.async {
                self.tabBar.items?[1].badgeValue = "\(changedValue)"
            }
            initialValue = changedValue
        }
    
    func ChangeRadiusOfTabbar(){
        
            self.tabBar.layer.masksToBounds = true
            self.tabBar.isTranslucent = true
            self.tabBar.layer.cornerRadius = 30
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.tabBar.tintColor = FlatWhite()
        
        //Change background color
        
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .flatBlueDark()

            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SimpleAnnimationWhenSelectItem(item)
    }
    
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
            let timeInterval: TimeInterval = 0.5
            let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
                barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
            }
            propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
            propertyAnimator.startAnimation()
        
    }
}
