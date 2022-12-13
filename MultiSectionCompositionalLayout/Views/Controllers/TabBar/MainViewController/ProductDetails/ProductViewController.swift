//
//  ProductViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 10/12/2022.
//

import UIKit
import Gemini
import LZViewPager
import AARatingBar
import Cosmos


class ProductViewController: UIViewController, UIGestureRecognizerDelegate, LZViewPagerDelegate, LZViewPagerDataSource {
    
    
    @IBOutlet weak var collectionView: GeminiCollectionView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var faviritesClicked: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var details: UIButton!
    @IBOutlet weak var featuresButton: UIButton!
    @IBOutlet weak var pagerView: LZViewPager!
    @IBOutlet weak var ratingBar: CosmosView!
    
    private var subControllers:[UIViewController] = []
    var productDetails: ProductDetails?
    var productItems:ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        collectionView.collectionViewLayout = createLayout()
        customizedView()
        fetchProductDetails()
        
            collectionView.gemini
                .scaleAnimation()
                .scale(0.75)
                .scaleEffect(.scaleUp) // or .scaleDown
        viewPager()
        bottomButton.layer.cornerRadius = 20
        customStarBar()
            
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true
        customNavbarItems()
        
    }
    
    func fetchProductDetails() {

        APICaller.shared.getProductDetails(completion: { result in
            switch result{
            case .success(let product):
                self.productDetails = product
                self.productItems = ProductItem(CPU: product.CPU, camera: product.camera, capacity: product.capacity, color: product.color, id: product.id, images: product.images, isFavorites: product.isFavorites, price: product.price, rating: product.rating, sd: product.sd, ssd: product.ssd, title: product.title)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    func customNavbarItems(){
        
        let rightButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let leftButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        rightButton.setImage(UIImage(named: "bagImage3"), for: .normal)
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
        
        print("Share to fb")
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func likedProduct(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func foregroundButton(_ sender: UIButton) {
        
        
    }
    
    func customStarBar() {
        
        ratingBar.settings.updateOnTouch = false
        ratingBar.settings.totalStars = 5
        ratingBar.rating = 0
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            guard  let rating = self.productDetails?.rating else{return}
            self.ratingBar.rating = rating
        }
        ratingBar.settings.fillMode = .precise
    }
}

//MARK: - CollectionView Delegate & DataSource Methods


extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{

        private func createLayout() -> UICollectionViewCompositionalLayout {
            UICollectionViewCompositionalLayout { _,_  in
                    
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 20
                section.contentInsets = .init(top: 20, leading: 10, bottom: 20, trailing: 10)
               
                return section
    
            }
        }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                cell.setUpWith(image: (self.productDetails?.images)!, indexPath: indexPath)
              
            }
       
            self.collectionView.animateCell(cell)
            cell.backgroundColor = .flatWhite()

            return cell
    
        }

        // Call animation function
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.collectionView.animateVisibleCells()
        }

        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if let cell = cell as? ProductCollectionViewCell {
                self.collectionView.animateCell(cell)
            }
        }
}

//MARK: - Customizing Bottom View


extension ProductViewController{

    
    func customizedView(){
        
        let dLayer = detailsView.layer
        
        dLayer.masksToBounds = true
        dLayer.shadowColor = UIColor.black.cgColor
        dLayer.shadowOffset = CGSize(width: 0, height: 0)
       
        dLayer.shadowRadius = 10.0
        dLayer.shadowOpacity = 0.3
        dLayer.borderWidth = 0.1
        dLayer.borderColor = UIColor.flatGrayDark().cgColor
        dLayer.cornerRadius = 40
        dLayer.masksToBounds = false

        dLayer.shadowPath = UIBezierPath(roundedRect: detailsView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: detailsView.layer.frame.width, height: 5)), cornerRadius: dLayer.cornerRadius).cgPath
    }
}
extension ProductViewController{
    
    
    func viewPager(){
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.hostController = self
        
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeaturesViewController")
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeaturesViewController")
        let v3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeaturesViewController")

        subControllers = [vc1, vc2, v3]
        self.pagerView.reload()
    }
    
    func numberOfItems() -> Int {
        subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    func colorForIndicator(at index: Int) -> UIColor {
        return .flatOrange()
    }
    
    func button(at index: Int) -> UIButton {
        switch index{
        case 0:
            return shopButton
        case 1:
            return details
        case 2:
            return featuresButton
        default:
            return shopButton
        }
    }
    
    func heightForIndicator() -> CGFloat {
        return 3
    }
    func heightForHeader() -> CGFloat {
        return 50
    }
    
    @IBAction func generalAction(_ sender: UIButton) {
        
        switch sender.tag{
        case 0:
            shopButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        case 1:
            details.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        case 2:
            featuresButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        default:
            shopButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        }
//        shopButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
//        details.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
//        featuresButton.titleLabel?.font = .systemFont(ofSize: 35, weight: .bold)
        
    

    }
}

