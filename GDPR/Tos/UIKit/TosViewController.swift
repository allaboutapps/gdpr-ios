//
//  TosViewController.swift
//  GDPR
//
//  Created by Lyn Almasri on 19.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import UIKit

public class TosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: TosViewModel?
    let tableView = UITableView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupConstraints() {
        tableView.withConstraints { (table) -> [NSLayoutConstraint] in
            return [
                table.alignTop(),
                table.alignBottom(),
                table.alignLeft(),
                table.alignRight()
            ]
        }
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PolicyTableViewCell.self, forCellReuseIdentifier: "serviceCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        setupConstraints()
    }
    
    // MARK: Data Source
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.services?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as! PolicyTableViewCell
        cell.configureCell(service: (viewModel?.services![indexPath.row])!)
        return cell
    }
}
