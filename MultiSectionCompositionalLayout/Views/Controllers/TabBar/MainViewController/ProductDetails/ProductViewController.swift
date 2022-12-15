//
//  ProductViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 10/12/2022.
//

import UIKit
import Gemini
import LZViewPager
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
    @IBOutlet weak var firstOptionButton: UIButton!
    @IBOutlet weak var secondOptionButton: UIButton!
    @IBOutlet weak var firstColor: UIButton!
    @IBOutlet weak var secondColor: UIButton!
    
    
    private var subControllers:[UIViewController] = []
    var productDetails: ProductDetails?
    var productItems:ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        collectionView.collectionViewLayout = createLayout()
        CustomizedView.setViewConstrainsts(with: detailsView)
        fetchProductDetails()
        
//        collectionView.gemini
//            .scaleAnimation()
//            .scale(0.75)
//            .scaleEffect(.scaleUp) // or .scaleDown
        viewPager()
        loadCustomView()
        customStarBar()
        customizingButton()
        
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
                self.productItems = ProductItem(CPU: product.CPU, camera: product.camera, capacity: product.capacity, color: product.color, images: product.images, isFavorites: product.isFavorites, price: product.price, rating: product.rating, sd: product.sd, ssd: product.ssd, title: product.title)
                
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
        self.performSegue(withIdentifier: "goToCart", sender: self)
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func likedProduct(_ sender: UIButton) {
        
    }
    
    
    @IBAction func foregroundButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCart", sender: self)
    }
    
    func customStarBar() {
        
        ratingBar.settings.updateOnTouch = false
        ratingBar.settings.totalStars = 5
        ratingBar.rating = 0
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            guard  let rating = self.productDetails?.rating else{return}
            self.ratingBar.rating = rating
        }
        ratingBar.settings.fillMode = .precise
    }
    func loadCustomView(){
        
    }
}

//MARK: - CollectionView Delegate & DataSource Methods


extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _,_  in
            
            let item = Compositionallayout.createitem(with: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
            let group = Compositionallayout.createGroup(alighment: .horizontal, with: .fractionalWidth(0.7), height: .fractionalHeight(1), item: [item])
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
        cell.productImage.sd_setImage(with: URL(string: productItems?.images[indexPath.row] ?? ""),
                                      placeholderImage: UIImage(named: "photo"),
                                      options: .continueInBackground,
                                      completed: nil)
        
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
    
    func viewPager(){
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.hostController = self
        
        //Setting how many views should be displayed in the pager view
        
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController")
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController")
        let v3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController")
        
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
    
    //Showing button
    
    func button(at index: Int) -> UIButton {
        
        switch index{
        case 0:
            shopButton.setTitleColor(UIColor.flatGray(), for: .normal)
            return shopButton
        case 1:
            details.setTitleColor(UIColor.flatGray(), for: .normal)
            return details
        case 2:
            featuresButton.setTitleColor(UIColor.flatGray(), for: .normal)
            return featuresButton
        default:
            return UIButton()
        }
    }
    
    //Indicatore hight
    
    func heightForIndicator() -> CGFloat {
        return 3
    }
    
    //Spacing between button and indicator
    
    func heightForHeader() -> CGFloat {
        return 50
    }
    
    //MARK - Changing Font size of buttons when they get selected
    
    @IBAction func generalAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            shopButton.setTitleColor(UIColor.flatBlack(), for: .selected)
            shopButton.titleLabel?.font = .systemFont(ofSize: 23, weight: .medium)
            details.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            featuresButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            
        case 1:
            
            details.setTitleColor(UIColor.flatBlack(), for: .selected)
            details.titleLabel?.font = .systemFont(ofSize: 23, weight: .medium)
            featuresButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            shopButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            
        case 2:
            
            featuresButton.setTitleColor(UIColor.flatBlack(), for: .selected)
            featuresButton.titleLabel?.font = .systemFont(ofSize: 23, weight: .medium)
            details.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            shopButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
            
        default:
            return
        }
    }
    
    
    //MARK -Changing button background color & cornder radious
    
    func customizingButton(){
        
        bottomButton.layer.cornerRadius = 10
        firstOptionButton.layer.cornerRadius = 10
        firstOptionButton.backgroundColor = UIColor.orange
        firstOptionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        firstOptionButton.setTitleColor(UIColor.flatWhite(), for: .normal)
        secondOptionButton.setTitleColor(UIColor.flatGray(), for: .normal)
        secondOptionButton.layer.cornerRadius = 10
        firstColor.layer.cornerRadius = firstColor.frame.height / 2
        secondColor.layer.cornerRadius = secondColor.frame.height / 2
        secondColor.setImage(UIImage(named: "done"), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4){
            self.firstColor.backgroundColor = UIColor(hexString: (self.productDetails?.color.first)!)
            self.secondColor.backgroundColor = UIColor(hexString: (self.productDetails?.color.last)!)
        }
    }
    
    //MARK - Action for changing background of memory size buttons
    
    @IBAction func backgrundChanged(_ sender: UIButton){
        
        switch sender.tag{
        case 0:
            firstOptionButton.setTitleColor(UIColor.white, for: .normal)
            firstOptionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            firstOptionButton.backgroundColor = UIColor.orange
            secondOptionButton.backgroundColor = UIColor.clear
            secondOptionButton.setTitleColor(UIColor.flatGray(), for: .normal)
            secondOptionButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        case 1:
            secondOptionButton.setTitleColor(UIColor.white, for: .normal)
            secondOptionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            secondOptionButton.backgroundColor = UIColor.orange
            firstOptionButton.backgroundColor = UIColor.clear
            firstOptionButton.setTitleColor(UIColor.flatGray(), for: .normal)
            firstOptionButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        default:
            return
        }
    }
    
    //MARK - Actions for color selector
    
    @IBAction func colorPicked(_ sender: UIButton){
        switch sender.tag{
        case 0:
            firstColor.setImage(UIImage(named: "done"), for: .normal)
            secondColor.setImage(nil, for: .normal)
        case 1:
            secondColor.setImage(UIImage(named: "done"), for: .normal)
            firstColor.setImage(nil, for: .normal)
        default:
            return
        }
    }
}

