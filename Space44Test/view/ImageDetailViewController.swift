//
//  ImageDetailViewController.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 15/12/2021.
//

import UIKit
import Kingfisher
class ImageDetailViewController: BaseViewController {
    
    let imagesCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
        let imagesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 20), collectionViewLayout: flowLayout)
        imagesCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 20)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .horizontal
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        imagesCollectionView.backgroundColor = .white
        imagesCollectionView.heightAnchor.constraint(equalToConstant: 105).isActive = true
       
        return imagesCollectionView
    }()
    
    var imageObjectList:[AlbumDetailItem]!
    var currentIndex = 0
    lazy var totalLikes:UILabel = {
        let totalLikes = labelRegular(text: "Total Likes", textSize: 14, textColor: .gray)
        totalLikes.textAlignment = .center
        return totalLikes
    }()
    lazy var totalLikesValue:UILabel = {
        let totalLikesValue = labelBold(text: "365", textSize: 14, textColor: .black)
        totalLikesValue.textAlignment = .center
        return totalLikesValue
    }()
    lazy var totalLikesStackV:UIStackView = {
        let totalLikesStackV = generateStackView(axis: .vertical)
        totalLikesStackV.distribution = .fillEqually
        totalLikesStackV.addArrangedSubview(totalLikesValue)
        totalLikesStackV.addArrangedSubview(totalLikes)
        totalLikesStackV.alignment = .center
        return totalLikesStackV
    }()
    
    lazy var descriptionLbl:UILabel = {
        let descriptionLbl = labelRegular(text: "Description", textSize: 14, textColor: .gray)
        descriptionLbl.textAlignment = .center
        return descriptionLbl
    }()
    lazy var descriptionValue:UILabel = {
        let descriptionValue = labelBold(text: "Description value", textSize: 14, textColor: .black)
        descriptionValue.numberOfLines = 1
        descriptionValue.textAlignment = .center
        return descriptionValue
    }()
    lazy var descriptionStackV:UIStackView = {
        let descriptionStackV = generateStackView(axis: .vertical)
        descriptionStackV.distribution = .fillEqually
        descriptionStackV.addArrangedSubview(descriptionValue)
        descriptionStackV.addArrangedSubview(descriptionLbl)
        descriptionStackV.alignment = .center
        return descriptionStackV
    }()
    lazy var generalStackV:UIStackView = {
        let generalStackV = generateStackView(axis: .horizontal)
        generalStackV.addArrangedSubview(totalLikesStackV)
        generalStackV.addArrangedSubview(descriptionStackV)
        generalStackV.distribution = .fillEqually
        return generalStackV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageObjectList = rotLeft(arr: imageObjectList, index: currentIndex)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.reloadData()
    }
    override func initView() {
        view.backgroundColor = .white
        view.addSubview(imagesCollectionView)
        imagesCollectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 200, left: 20, bottom: 20, right: 20))
        view.addSubview(generalStackV)
        generalStackV.anchor(top: nil, leading: view.leadingAnchor, bottom: imagesCollectionView.topAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
        totalLikesValue.text = String(imageObjectList[currentIndex].totalLikes)
        descriptionValue.text = imageObjectList[currentIndex].totalDescription
    }



}
extension ImageDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return imageObjectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell collection seen")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(data: imageObjectList[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in imagesCollectionView.visibleCells {
            let indexPath = imagesCollectionView.indexPath(for: cell)
            print(indexPath!.row)
            totalLikesValue.text = String(imageObjectList[indexPath!.row].totalLikes)
            descriptionValue.text = imageObjectList[indexPath!.row].totalDescription
        
        }
    }


    
}
