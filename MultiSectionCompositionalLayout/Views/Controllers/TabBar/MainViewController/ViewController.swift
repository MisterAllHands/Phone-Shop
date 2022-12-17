//
//  ViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 7.12.22
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    let images = ["1","2","3","4","5"]
    let highlightedImages = ["phone2","laptop2","heart2","books2","tools3"]
    let labels = ["Phones", "Computer", "Health","Books","Tools"]

    var models = [HomeStore]()
    var apiResponse: APIresponse?
    
    private let sections = MockData.shared.pageData
    
    var itemIsSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
        fetchMainScreen()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchMainScreen() {

        APICaller.shared.getPhones { result in

            switch result {
            case .success(let home_store):
                self.apiResponse = home_store
                self.models = home_store.home_store.compactMap({HomeStore(
                    title: $0.title,
                    subtitle: $0.subtitle,
                    urlToImage: URL(string: $0.picture))
                })

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        
        presentBottomSheet()
        
    }
    //MARK: - Creating Collections
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            
            switch section {
            case .category:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.2)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90), heightDimension: .absolute(100)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 10, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
                
            case .hotSales:
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 25
                section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
               
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                
                return section
                
            case .bestSeller:
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
                item.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.6)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = -5
                
                section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            }
        }
    }
    
    //MARK: - Creating Header for Cells
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
//MARK: - CollectionView Delegate & DataSource Methods

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
        case .category:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
                
            cell.setup(with: images[indexPath.row], title: labels[indexPath.row])
            

            return cell
            
        case .hotSales:
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                cell.setup(item: (self.apiResponse?.home_store[indexPath.row])!)
            }
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.height / 8

            return cell
            
        case .bestSeller:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandscapeCollectionViewCell", for: indexPath) as! LandscapeCollectionViewCell
            cell.likedItem.layer.cornerRadius = cell.likedItem.frame.size.height / 2
            cell.likedItem.backgroundColor = .white
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                cell.setup(item: (self.apiResponse?.best_seller[indexPath.row])!)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        switch sections[indexPath.section]{
         
        case .category:
            
            if let cell = collectionView.cellForItem(at: indexPath) as? StoryCollectionViewCell{
                cell.cellImageView.image = UIImage(named: highlightedImages[indexPath.row])
                cell.showImage()
            }
            
            if indexPath.row == 2 {
                collectionView.scrollToItem(at: IndexPath(row: 4, section: 0), at: .right, animated: true)
            }
        case .hotSales:
            self.performSegue(withIdentifier: "goToProductDetails", sender: self)
        case .bestSeller:
            self.performSegue(withIdentifier: "goToProductDetails", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StoryCollectionViewCell{
            cell.hideImage()
            cell.cellImageView.image = UIImage(named: images[indexPath.row])
            cell.showImage()
        }
    }
    
    //MARK - Setting up the header for each section
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableView", for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(title: sections[indexPath.section].title, secondTitle: sections[indexPath.section].title2)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
//MARK: - Presenting the bottom Sheet


extension ViewController: UIViewControllerTransitioningDelegate{
    
    func presentBottomSheet(){
        let bottomSheet = SheetViewController()
        bottomSheet.modalPresentationStyle = .pageSheet
        bottomSheet.sheetPresentationController?.detents = [.medium(), .large()]
        bottomSheet.sheetPresentationController?.preferredCornerRadius = 35
        self.present(bottomSheet, animated: true)
    }
}
