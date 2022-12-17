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
    var baskets: [Basket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(addBadgeValue),
                       name: Notification.Name("addValue"), object: nil)
        
        let nc2 = NotificationCenter.default
        nc2.addObserver(self, selector: #selector(removeBadgeValue),
                        name: Notification.Name( "removeValue"), object: nil)
        
        
        APICaller.shared.getCartItems { [self] result in
            switch result {
            case .success(let data):
                self.baskets = data.basket
                DispatchQueue.main.async {[self] in
                    tabBar.items?[1].badgeValue = "\(baskets.count)"
                }
            case .failure(let failure):
                print(failure)
            }
        }
        tabBar.items?[1].badgeValue = "\(baskets.count)"
        ChangeRadiusOfTabbar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
        
    @objc func addBadgeValue() {
            DispatchQueue.main.async {
                self.tabBar.items?[1].badgeValue = "\(self.baskets.count + 1)"
            }
    }
    
    @objc func removeBadgeValue() {
        DispatchQueue.main.async {
            self.tabBar.items?[1].badgeValue = "\(self.baskets.count - 1)"
        }
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
