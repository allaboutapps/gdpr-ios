//
//  ServiceTableViewCell.swift
//  GDPR
//
//  Created by Lyn Almasri on 19.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let details = UILabel()
    let agreementSwitch = UISwitch()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(service: PolicyModel) {
        let horizontalStackView = UIStackView(arrangedSubviews: [title,
                                                        agreementSwitch])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 16
        horizontalStackView.distribution = .fillProportionally
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView,
                                                        details])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        stackView.withConstraints { (stack) -> [NSLayoutConstraint] in
            return[
                stack.alignTop(self.safeAreaLayoutGuide, constant: 16),
                stack.alignRight(self.safeAreaLayoutGuide, constant: -16),
                stack.alignBottom(self.safeAreaLayoutGuide, constant: -16),
                stack.alignLeft(self.safeAreaLayoutGuide, constant: 16)
            ]
        }
    }
    
    @objc func switchChanged() {
        //        self.serviceModel?.agreedTo = agreementSwitch.isOn
        print(agreementSwitch.isOn)
    }
    
}
