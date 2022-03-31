//
//  ViewController.swift
//  CollectionViewInScrollView
//
//  Created by Toshiharu Imaeda on 2022/03/31.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

  private let imagePaths: [String] = [
    "https://thumb.photo-ac.com/2a/2a8499417089b23915439df16f9660bb_t.jpeg",
    "https://thumb.photo-ac.com/9c/9cbd711d6eb991d84a83c1aa892b3ae0_t.jpeg",
    "https://thumb.photo-ac.com/b5/b5ef361c546a68432e38f0a7237d7c33_t.jpeg",
    "https://thumb.photo-ac.com/1f/1fa125e870098a0f2f363672bb0518c6_t.jpeg",
    "https://thumb.photo-ac.com/35/35b887c7a21e250c34c2c0b786b01b1b_t.jpeg",
    "https://thumb.photo-ac.com/95/95442d3c6a52b24818f9f9532d0bb29b_t.jpeg",
  ]
  
  private enum CellName {
    static let cell = "defaultCell"
  }
  
  private let minimumLineSpacing: CGFloat = 10.0
  private let sideDisplayWidth: CGFloat = 64.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    collectionView.reloadData()
  }
  
  private func setup() {
    collectionViewHeight.constant = cellSize().height
    collectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CellName.cell)
    
    let layout = CollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = cellSize()
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 10
    layout.sectionInset = .zero
    collectionView.collectionViewLayout = layout
    
    collectionView.dataSource = self
  }
  
  private func cellSize() -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let width = screenWidth - 2 * minimumLineSpacing - 2 * sideDisplayWidth
    let height = width * 9 / 16
    return .init(width: width, height: height)
  }
  
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    imagePaths.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellName.cell, for: indexPath) as! CollectionViewCell
    return cell
  }
}

