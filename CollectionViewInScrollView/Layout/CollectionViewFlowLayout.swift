//
//  CollectionViewFlowLayout.swift
//  CollectionViewInScrollView
//
//  Created by Toshiharu Imaeda on 2022/03/31.
//

import UIKit

// Inspired by this post.
// https://techlife.cookpad.com/entry/2019/08/16/090000

final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
  // ユーザーが画面をスクロールして指を離した後に呼ばれる
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return proposedContentOffset }
    
    let expandedMargin = sectionInset.left + sectionInset.right
    let expandedVisibleRect = CGRect(
      x: collectionView.contentOffset.x,
      y: 0,
      width: collectionView.bounds.width + expandedMargin * 2,
      height: collectionView.bounds.height
    )
    
    // 表示領域の layoutAttributes を取得し、X座標でソートする
    guard let targetAttributes = layoutAttributesForElements(in: expandedVisibleRect)?.sorted(by: { $0.frame.minX < $1.frame.minX}) else {
      return proposedContentOffset
    }
    
    let nextAttributes: UICollectionViewLayoutAttributes?
    if velocity.x == 0 {
      // スワイプせずに離した場合、画面中央から一番近い要素を選ぶ
      nextAttributes = layoutAttributesNearByCenterX(in: targetAttributes, collectionView: collectionView)
    } else if velocity.x > 0 {
      // 左スワイプの場合は最後の要素を取得する
      nextAttributes = targetAttributes.last
    } else {
      // 右スワイプの場合は最初の要素を取得する
      nextAttributes = targetAttributes.first
    }
    guard let attributes = nextAttributes else { return proposedContentOffset }
    let cellLeftMargin = (collectionView.bounds.width - attributes.bounds.width) / 2
    
    return .init(x: attributes.frame.minX - cellLeftMargin, y: collectionView.contentOffset.y)
  }
  
  /// 画面中央に一番近いCellの attributes を取得する
  private func layoutAttributesNearByCenterX(in attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView) -> UICollectionViewLayoutAttributes? {
    let screenCenterX = collectionView.contentOffset.x + collectionView.bounds.width / 2.0
    let result = attributes.reduce((attributes: nil as UICollectionViewLayoutAttributes?, distance: CGFloat.infinity)) { partialResult, attributes in
      let distance = attributes.frame.midX - screenCenterX
      return abs(distance) < abs(partialResult.distance) ? (attributes, distance) : partialResult
    }
    return result.attributes
  }

}
