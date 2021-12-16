//
//  AllImagesScreenViewController.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import UIKit
class AllImagesScreenViewController: BaseViewController {
    let viewModel = PhotoViewModel()
    var albumList = [AlbumDetailItem]()
    var currentIndex = 0
    enum Section {
      case albumBody
    }
    static let syncingBadgeKind = "syncing-badge-kind"
    var albumURL: URL?

    convenience init(withPhotosFromDirectory directory: URL) {
      self.init()
      albumURL = directory
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AlbumDetailItem>! = nil
    var imagesCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        albumList = rotLeft(arr: albumList, index: currentIndex)
        DispatchQueue.main.async {
        self.configureCollectionView()
        self.configureDataSource()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func initView() {
        view.backgroundColor = .white
        title = "Unsplash"
        showLoading()
        viewModel.getPhotos({
            data,status in
            self.hideLoading()
            if status {
                data?.filter {
                    print(" Item is \($0)")
                    self.albumList.append(
                        AlbumDetailItem(photoURL: URL(string: $0.urls.raw)!, thumbnailURL: $0.urls.raw, totalLikes: $0.likes, totalDescription:$0.altDescription ?? "--")
                    )
                    return true
                    }
                DispatchQueue.main.async {
                self.configureCollectionView()
                self.configureDataSource()
                }
            }
            print("response on view is \(data)")
        })
    }
    
    
    func configureCollectionView() {
      let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
      view.addSubview(collectionView)
      collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView.backgroundColor = .white
      collectionView.delegate = self
      collectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: PhotoItemCell.reuseIdentifer)
      collectionView.register(SyncingBadgeView.self,
                              forSupplementaryViewOfKind: AllImagesScreenViewController.syncingBadgeKind,
                              withReuseIdentifier: SyncingBadgeView.reuseIdentifier)
        imagesCollectionView = collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
      // I decided to have three row styles
      // Style 1: 'Full'
      // A full width photo
      // Style 2: 'Main with pair'
      // A 2/3 width photo with two 1/3 width photos stacked vertically
      // Style 3: 'Triplet'
      // Three 1/3 width photos stacked horizontally

      // Syncing badge
      let syncingBadgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: -0.3, y: 0.3))
      let syncingBadge = NSCollectionLayoutSupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .absolute(20),
          heightDimension: .absolute(20)),
        elementKind: AllImagesScreenViewController.syncingBadgeKind,
        containerAnchor: syncingBadgeAnchor)

      // Full
      let fullPhotoItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(2/3)),
        supplementaryItems: [syncingBadge])
      fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      // Main with pair
      let mainItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(2/3),
          heightDimension: .fractionalHeight(1.0)))
      mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let pairItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(0.5)))
      pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
      let trailingGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/3),
          heightDimension: .fractionalHeight(1.0)),
        subitem: pairItem,
        count: 2)

      let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(4/9)),
        subitems: [mainItem, trailingGroup])

      // Triplet
      let tripletItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/3),
          heightDimension: .fractionalHeight(1.0)))
      tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let tripletGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(2/9)),
        subitems: [tripletItem, tripletItem, tripletItem])

      // Reversed main with pair
      let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(4/9)),
        subitems: [trailingGroup, mainItem])

      let nestedGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(16/9)),
        subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])

      let section = NSCollectionLayoutSection(group: nestedGroup)
      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }
    
}
extension AllImagesScreenViewController:UICollectionViewDelegate{

    
    func configureDataSource() {
      dataSource = UICollectionViewDiffableDataSource
        <Section, AlbumDetailItem>(collectionView: imagesCollectionView) {
          (collectionView: UICollectionView, indexPath: IndexPath, detailItem: AlbumDetailItem) -> UICollectionViewCell? in
          guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoItemCell.reuseIdentifer,
            for: indexPath) as? PhotoItemCell else { fatalError("Could not create new cell") }
          cell.photoURL = detailItem.thumbnailURL
          return cell
      }

      dataSource.supplementaryViewProvider = {
        (
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath) -> UICollectionReusableView? in

        let hasSyncBadge = indexPath.row % Int.random(in: 1...6) == 0

        if let badgeView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: SyncingBadgeView.reuseIdentifier,
          for: indexPath) as? SyncingBadgeView {

          badgeView.isHidden = !hasSyncBadge
          return badgeView
        } else {
          fatalError("Cannot create new supplementary")
        }
      }

      // load our initial data
      let snapshot = snapshotForCurrentState()
      dataSource.apply(snapshot, animatingDifferences: false)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumDetailItem> {
      var snapshot = NSDiffableDataSourceSnapshot<Section, AlbumDetailItem>()
      snapshot.appendSections([Section.albumBody])
      let items = itemsForAlbum()
      snapshot.appendItems(items)
      return snapshot
    }
    
    
    func itemsForAlbum() -> [AlbumDetailItem] {

        return albumList
    }
  
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        if indexPath.row == 0{
            return CGSize(width: screenSize.width, height: 200)
        }
        if indexPath.row%3 == 0 {
        return CGSize(width: (screenSize.width/2) - 50, height: 100)
        }
        if indexPath.row == 5 {
        return CGSize(width: (screenSize.width/2) - 50, height: 300)
        }
        return CGSize(width: (screenSize.width/2) - 50, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked index is \(indexPath.row)")
        currentIndex = indexPath.row
        let nextVC = ImageDetailViewController()
        nextVC.imageObjectList = albumList
        nextVC.currentIndex = currentIndex
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
     }

    
}
