//
//  MyPageViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var myPlatesCountView: UIView!
    @IBOutlet weak var myPlatesCountLabel: UILabel!
    @IBOutlet weak var myGreenHouseGasView: UIView!
    @IBOutlet weak var myGeenHouseGasLabel: UILabel!
    @IBOutlet weak var pointHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureTableView()
        configureUI()
    }
    
    private func configureUI() {
        profileImageView.roundCorner(cornerRadius: profileImageView.frame.width / 2)
        myPlatesCountView.layer.borderColor = UIColor(named: "key_green")?.cgColor
        myPlatesCountView.layer.borderWidth = 1
        myPlatesCountView.roundCorner(cornerRadius: 10)
        myPlatesCountView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
        myGreenHouseGasView.roundCorner(cornerRadius: 10)
        myGreenHouseGasView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
        pointHistoryTableView.roundCorner(cornerRadius: 20)
        pointHistoryTableView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
        pointHistoryTableView.clipsToBounds = true
    }
    
    private func configureTableView() {
        pointHistoryTableView.register(UINib(nibName: String(describing: PointHistoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PointHistoryTableViewCell.self))
        pointHistoryTableView.dataSource = self
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PointHistoryTableViewCell.self), for: indexPath)
        return cell
    }
}
