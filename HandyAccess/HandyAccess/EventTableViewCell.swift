//
//  EventTableViewCell.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    static let cellIdentifier = "eventTableViewCellIdentifier"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(eventNameLabel)
        self.addSubview(eventDescriptionLabel)
        
        self.selectionStyle = .none
        
        self.eventNameLabel.snp.makeConstraints { (view) in
            view.leading.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(8)
        }
        
        self.eventDescriptionLabel.snp.makeConstraints { (view) in
            view.top.equalTo(self.eventNameLabel.snp.bottom).offset(8)
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
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: 8)
        label.numberOfLines = 0
        return label
    }()
    
    let eventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization Description"
        label.font = UIFont.systemFont(ofSize: 16, weight: 6)
        label.numberOfLines = 0
        return label
    }()

}
