//
//  SettingSectionModel.swift
//  SettingSceneSample
//
//  Created by 縣美早 on 2020/04/27.
//  Copyright © 2020 縣美早. All rights reserved.
//

import UIKit
import RxDataSources

typealias SettingSectionModel = SectionModel<SettingSection, SettingItem>

enum SettingSection {
    case account
    case common

    var headerHeight: CGFloat {
        return 40.0
    }
    
    var footerHeight: CGFloat {
        return 40.0
    }
}

enum SettingItem {
    //account
    case account
    case notification
    case security
    //common
    case sound
    case help
    case introduce
    case others
    
    var title: String {
        switch self {
        case .account:
            return "アカウント"
        case .notification:
            return "通知設定"
        case .security:
            return "セキュリティ"
        case .sound:
            return "音量設定"
        case .help:
            return "ヘルプ"
        case .introduce:
            return "友達に紹介する"
        case .others:
            return "その他"
        }
    }
    
    var rowHeight: CGFloat {
        return 48.0
    }
    
    var accesaryType: UITableViewCell.AccessoryType {
        return .disclosureIndicator
    }
}


