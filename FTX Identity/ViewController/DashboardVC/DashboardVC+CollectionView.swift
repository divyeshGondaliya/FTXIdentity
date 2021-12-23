//
//  DashboardVC+CollectionView.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import Foundation
import UIKit

extension DashboardVC:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardOptionCell", for: indexPath) as? DashboardOptionCell
        {
            cell.lbl_name.text = self.arr_title[indexPath.row]
            cell.img_name.image = self.arr_img[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension DashboardVC:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.15,
                       animations: {
                        //Fade-out
                        cell?.alpha = 0.5
        }) { (completed) in
            UIView.animate(withDuration: 0.15,
                           animations: {
                            //Fade-out
                            cell?.alpha = 1
            })
        }
        switch self.arr_title[indexPath.row] {
        case "Logout":
            showalertYesNo(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.logout) {
                self.logOut()
            } failure: {
            }
        case "Biometric Info":
            let vc = BiometricInfoVC(nibName: "BiometricInfoVC", bundle: nil)
            vc.img_url = self.profileimg
            self.navigationController?.pushViewController(vc, animated: true)
        case "Sign-in Security":
            let vc = SignInSecurityVC(nibName: "SignInSecurityVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Personal Info":
            let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case "Membership":
            let vc = SearchRetailerVC(nibName: "SearchRetailerVC", bundle: nil)
            vc.vcForMemberShip = true
            self.navigationController?.pushViewController(vc, animated: true)
        case "Search Retailer":
            let vc = SearchRetailerVC(nibName: "SearchRetailerVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("nothing")
        }
    }
    
    func logOut()
    {
        if let userDefaults = UserDefaults(suiteName: "group.net.openid.appauth.Example") {
            userDefaults.removeObject(forKey: kAppAuthExampleAuthStateKey)
            userDefaults.synchronize()
            AuthLoginClass.shared.setAuthState(nil)
        }
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ChooseOprtionVC") as? ChooseOprtionVC
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension DashboardVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2)-8, height: 150)
   }
}
