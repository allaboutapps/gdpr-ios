//
//  TosTableViewCell.swift
//  GDPR
//
//  Created by Lyn Almasri on 19.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import UIKit

class PolicyTableViewCell: UITableViewCell {
    
    var serviceModel: PolicyModel?
    
    let title = UILabel()
    let details = UILabel()
    let linkButton = UIButton()
    let agreementLabel = UILabel()
    let agreementSwitch = UISwitch()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(service: PolicyModel) {
        
        let stackView = UIStackView(arrangedSubviews: [title,
                                                       details,
                                                       linkButton])
        details.numberOfLines = 100
        stackView.axis = .vertical
        addSubview(stackView)
        title.text = service.title
        details.text = service.details
        linkButton.setTitle(service.linkTitle, for: .normal)
        linkButton.setTitleColor(.blue, for: .normal)
        linkButton.contentHorizontalAlignment = .left
        linkButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        stackView.withConstraints { (stack) -> [NSLayoutConstraint] in
            return[
                stack.alignTop(self.safeAreaLayoutGuide, constant: 16),
                stack.alignRight(self.safeAreaLayoutGuide, constant: -16),
                stack.alignBottom(self.safeAreaLayoutGuide, constant: -16),
                stack.alignLeft(self.safeAreaLayoutGuide, constant: 16)
            ]
        }
        stackView.spacing = 16
        
        if service.agreement ?? false {
            agreementLabel.text = "studd sstuff sstuuuff"
            let agreementStack = UIStackView(arrangedSubviews: [agreementLabel,
                                                                agreementSwitch])
            agreementStack.axis = .horizontal
            agreementStack.distribution = .fillProportionally
            agreementStack.spacing = 16
            stackView.addArrangedSubview(agreementStack)
            agreementSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        }
        
    }
    
    @objc func clicked() {
        print("Clicked")
    }
    
    @objc func switchChanged() {
        self.serviceModel?.agreedTo = agreementSwitch.isOn
        print(agreementSwitch.isOn)
    }
    
}
