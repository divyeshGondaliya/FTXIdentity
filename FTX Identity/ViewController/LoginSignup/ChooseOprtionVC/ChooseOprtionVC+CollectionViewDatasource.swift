//
//  ChooseOprtionVC+CollectionViewDatasource.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import Foundation
import UIKit

extension ChooseOprtionVC:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChooseOprtionTopInfoCollectionViewCell", for: indexPath) as? ChooseOprtionTopInfoCollectionViewCell
        {
            cell.lbl_title.text = self.titleArr[indexPath.row]
            cell.lbl_des.text = self.descriptionArr[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}


extension ChooseOprtionVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
   }
}

extension ChooseOprtionVC

{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth = Float(collectionView.frame.size.width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.currentPage)

        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.currentPage + 1 : self.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }

        self.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        if self.currentPage > 2
        {
            self.currentPage = 2
        }
        self.updatePagging(selectedPage: self.currentPage)
    }
}
