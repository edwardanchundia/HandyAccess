//
//  SocialServiceTableViewCell.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit

class SocialServiceTableViewCell: UITableViewCell {

    static let cellIdentifier = "socialServiceTableViewCellIdentifier"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(organizationNameLabel)
        self.addSubview(organizationDescriptionLabel)
        //self.addSubview(openWebPageImageView)
        
        self.selectionStyle = .none
        
        self.organizationNameLabel.snp.makeConstraints { (view) in
            view.leading.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(8)
        }
        
        self.organizationDescriptionLabel.snp.makeConstraints { (view) in
            view.top.equalTo(self.organizationNameLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(8)
            view.bottom.equalToSuperview()
        }
        
        //self.openWebPageImageView.snp.makeConstraints { (view) in
        //    view.centerY.equalToSuperview()
        //    view.trailing.equalToSuperview().inset(8)
        //    view.height.equalTo(60)
        //    view.width.equalTo(60)
        //}
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
    
    override func prepareForReuse() {
        //self.openWebPageImageView.isHidden = true
        //self.openWebPageImageView.image = nil
    }
    
    let organizationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: 8)
        label.numberOfLines = 0
        return label
    }()
    
    let organizationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Description"
        label.font = UIFont.systemFont(ofSize: 16, weight: 6)
        label.numberOfLines = 3
        return label
    }()
    
    let openWebPageImageView: UIImageView = {
        let imageView = UIImageView()
        //<a href="https://icons8.com/web-app/13450/Open-in-Browser">
        imageView.image = #imageLiteral(resourceName: "Open in Browser-48")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

}
