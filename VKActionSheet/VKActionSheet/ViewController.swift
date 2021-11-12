//
//  ViewController.swift
//  ActionSheet
//
//  Created by Viachaslau Kastsechka on 11/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionSheetButtonDidTap(_ sender: Any) {
        let actionSheet = ActionSheet(title: "Select Organization", dataSource: self, delegate: self)
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - ActionSheetDataSource

extension ViewController: ActionSheetDataSource {
    
    func numberOfItems(in actionSheetView: ActionSheet) -> Int {
        DataProvider.companies.count
    }
    
    func actionSheet(_ actionSheet: ActionSheet, itemAt index: Int) -> ActionSheetItem {
        DataProvider.companies[index]
    }
}

// MARK: - ActionSheetDelegate

extension ViewController: ActionSheetDelegate {
    func actionSheet(_ actionSheet: ActionSheet, didSelectItemAt index: Int) {
        let company = DataProvider.companies[index]
        print("Did select \(company)")
    }
}

// MARK: - ActionSheetItem

extension Company: ActionSheetItem {
    var title: String { name }
    var isSelected: Bool { false }
    var imageURL: URL? { URL(string: photoURL ?? "") }
}
