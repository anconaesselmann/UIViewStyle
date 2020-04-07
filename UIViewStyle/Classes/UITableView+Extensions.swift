//  Created by Axel Ancona Esselmann on 4/3/20.
//  Copyright © 2020 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public extension UITableView {
    @discardableResult
    func emptyFooter() -> Self {
        tableFooterView = UIView()
        return self
    }

    @discardableResult
    func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
}
