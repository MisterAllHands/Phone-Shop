import Foundation
import UIKit
import ChameleonFramework


class TabBarController: UITabBarController {
    
    var customTabBarView = UIView(frame: .zero)
        
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChangeRadiusOfTabbar()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        HandleActionWhenSelectItem(item)
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
           
 

    func HandleActionWhenSelectItem(_ item: UITabBarItem){
        
        switch item{
        case (self.tabBar.items!)[0]:
            print("went to home")
        case (self.tabBar.items!)[1]:
            print("wemt to cart")
        case (self.tabBar.items!)[2]:
            print("wemt to favorites")
        case (self.tabBar.items![3]):
            print("went to profile")
        default:
            print("went home")
        }
    }
}
