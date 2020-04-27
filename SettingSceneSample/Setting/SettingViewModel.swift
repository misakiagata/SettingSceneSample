//
//  SettingViewModel.swift
//  SettingSceneSample
//
//  Created by 縣美早 on 2020/04/27.
//  Copyright © 2020 縣美早. All rights reserved.
//

import RxSwift
import RxDataSources

class SettingViewModel {
    
    let items = BehaviorSubject<[SettingSectionModel]>(value: [])
    
    func updateItem() {
        let section: [SettingSectionModel] = [
            accountSection(),
            commonSection()
        ]
        items.onNext(section)
    }
    
    private func accountSection() -> SettingSectionModel {
        let items: [SettingItem] = [
            .account,
            .notification,
            .security
        ]
        return SettingSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingSectionModel {
        let items: [SettingItem] = [
        .sound,
        .help,
        .introduce,
        .others
        ]
        return SettingSectionModel(model: .common, items: items)
    }
}
