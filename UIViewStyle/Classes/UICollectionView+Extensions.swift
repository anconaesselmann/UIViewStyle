//  Created by Axel Ancona Esselmann on 4/7/20.
//

import UIKit

public extension UICollectionView {

    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

}
