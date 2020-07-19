//
//  MyPageViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

class MyPageViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var myPlatesCountView: UIView!
    @IBOutlet weak var myPlatesCountLabel: UILabel!
    @IBOutlet weak var myGreenHouseGasView: UIView!
    @IBOutlet weak var myGeenHouseGasLabel: UILabel!
    @IBOutlet weak var pointHistoryTableView: UITableView!
    
    private var myPageUseCase: MyPageUseCase!
    private var pointHistories: PointHistoryContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchMyAccount()
        fetchPointHistory()
        fetchTodayRecords()
    }
}

// MARK:- Refreshable

extension MyPageViewController: Refreshable {
    func refresh() {
        fetchMyAccount()
        fetchPointHistory()
        fetchTodayRecords()
    }
}

//MARK: - Fetch Data

extension MyPageViewController {
    private func fetchMyAccount() {
        let request = MyAccountRequest(id:1).asURLRequest()
        myPageUseCase.getResources(request: request, dataType: MyAccount.self) { result in
            switch result {
            case .success(let account):
                self.pointLabel.text = "\(account.ecoPoint)"
                self.userNameLabel.text = account.name
                self.profileImageView.kf.setImage(with: URL(string: account.profileUrl)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchPointHistory() {
        let request = PointHistoryRequest().asURLRequest()
        myPageUseCase.getResources(request: request, dataType: PointHistoryContainer.self) { result in
            switch result {
            case .success(let history):
                self.pointHistories = history
                self.pointHistoryTableView.dataSource = self
                self.pointHistoryTableView.reloadData()
            case .failure(let error):
                print(error)
            }

        }
    }
    
    private func fetchTodayRecords() {
        let request = TodayRecordRequest().asURLRequest()
        myPageUseCase.getResources(request: request, dataType: TodayRecord.self) { result in
            switch result {
            case .success(let record):
                self.myPlatesCountLabel.text = "\(record.todayMyPlates)"
                self.myGeenHouseGasLabel.text = String(format: "%.2f", arguments: [record.todayMySaving])
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- Configurations

extension MyPageViewController {
    private func configure() {
        configureTableView()
        configureUI()
        configureUseCase()
    }
    
    private func configureUseCase() {
        myPageUseCase = MyPageUseCase()
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
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointHistories.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PointHistoryTableViewCell.self), for: indexPath) as! PointHistoryTableViewCell
        cell.configureData(pointHistories.data[indexPath.row])
        return cell
    }
}
