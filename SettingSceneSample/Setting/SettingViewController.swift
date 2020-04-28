//
//  SettingViewController.swift
//  SettingSceneSample
//
//  Created by 縣美早 on 2020/04/27.
//  Copyright © 2020 縣美早. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    private var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingSectionModel>(configureCell: configureCell)
    
    private lazy var configureCell:
        RxTableViewSectionedReloadDataSource<SettingSectionModel>.ConfigureCell =
        { [weak self] (dataSource, tableView, indexPath, _) in
            let item = dataSource[indexPath]
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accesaryType
            return cell
    }
    
    private var viewModel: SettingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupViewModel()
    }
    
    private func setupViewController() {
        navigationItem.title = "設定"
    }
    
    private func setupTableView() {
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        settingTableView.contentInset.bottom = 12.0
        settingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        settingTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.settingTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = SettingViewModel()
        viewModel.items
            .bind(to: settingTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        viewModel.updateItem()
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
