//
//  ProductViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 10/12/2022.
//

import UIKit

class ProductViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailsView: UIView!
    
    var productDetails: ProductDetails?
    var productItems:ProductItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        collectionView.collectionViewLayout = createLayout()
        fetchProductDetails()
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
}

//MARK: - CollectionView Delegate & DataSource Methods


extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{

        private func createLayout() -> UICollectionViewCompositionalLayout {
            UICollectionViewCompositionalLayout { _,_  in
                    
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    
    
                return section
    
            }
        }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
    //        cell.setUpWith(image: productDetails.images[indexPath.row])
            cell.backgroundColor = .flatBlue()
            return cell
    
        }
}
