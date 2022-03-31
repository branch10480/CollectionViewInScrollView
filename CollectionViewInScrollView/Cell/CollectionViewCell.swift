//
//  CollectionViewCell.swift
//  CollectionViewInScrollView
//
//  Created by Toshiharu Imaeda on 2022/03/31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  private func setup() {
    imageView.contentMode = .scaleAspectFill
  }
  
  func configure(imagePath: String) {
    guard let url = URL(string: imagePath),
          let data = try? Data(contentsOf: url) else { return }
    imageView.image = UIImage(data: data)
  }
  
}
