//
//  MapTableViewCell.swift
//  HandyAccess
//
//  Created by Miti Shah on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
        
        static let cellIdentifier = "mapTableViewCellIdentifier"
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
            self.addSubview(mapNameLabel)
            self.addSubview(mapDescriptionLabel)
            
            self.selectionStyle = .none
            
            self.mapNameLabel.snp.makeConstraints { (view) in
                view.leading.top.equalToSuperview().offset(8)
                view.trailing.equalToSuperview().inset(8)
            }
            
            self.mapDescriptionLabel.snp.makeConstraints { (view) in
                view.top.equalTo(self.mapNameLabel.snp.bottom).offset(8)
                view.leading.equalToSuperview().offset(8)
                view.trailing.bottom.equalToSuperview().inset(8)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
        
        let mapNameLabel: UILabel = {
            let label = UILabel()
            label.text = "Location Name"
            label.font = UIFont.systemFont(ofSize: 20, weight: 8)
            label.numberOfLines = 0
            return label
        }()
        
        let mapDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Location Description"
            label.font = UIFont.systemFont(ofSize: 16, weight: 6)
            label.numberOfLines = 0
            return label
        }()

}
