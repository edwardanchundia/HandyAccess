//
//  ButtonCollectionViewCell.swift
//  HandyAccess
//
//  Created by Edward Anchundia on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    let filterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterButton.setTitle("Button", for: .normal)
        
        contentView.addSubview(filterButton)
        filterButton.snp.makeConstraints({ (view) in
            view.top.equalTo(contentView.snp.top)
            view.bottom.equalTo(contentView.snp.bottom)
            view.leading.equalTo(contentView.snp.leading)
            view.trailing.equalTo(contentView.snp.trailing)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
}
