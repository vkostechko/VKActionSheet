//
//  VKActionSheetViewController.swift
//  VKActionSheet
//
//  Created by Viachaslau Kastsechka on 11/11/21.
//

import UIKit

protocol ActionSheetDataSource: AnyObject {
    func numberOfItems(in actionSheet: ActionSheet) -> Int
    func actionSheet(_ actionSheet: ActionSheet, itemAt index: Int) -> ActionSheetItem
}

protocol ActionSheetDelegate: AnyObject {
    func actionSheet(_ actionSheet: ActionSheet, didSelectItemAt index: Int)
}

class ActionSheet: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var titeLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var stickView: UIView!
    @IBOutlet private weak var coverView: UIView!
    @IBOutlet private weak var actionSheetView: UIView!
    @IBOutlet private weak var actionSheetBottomOffsetConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    var sheetTitle: String? {
        didSet {
            guard isViewLoaded else { return }
            titeLabel.text = sheetTitle
        }
    }
    var dataSource: ActionSheetDataSource?
    var delegate: ActionSheetDelegate?
    
    // MARK: - Private Properties
    
    private struct Constant {
        static let cellIdentifier = "ActionSheetCell"
    }
    
    // MARK: - Lifecycle
    
    init(title: String? = nil, dataSource: ActionSheetDataSource? = nil, delegate: ActionSheetDelegate? = nil) {
        super.init(nibName: "ActionSheet", bundle: nil)
        self.sheetTitle = title
        self.dataSource = dataSource
        self.delegate = delegate
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titeLabel.text = sheetTitle
        tableView.register(UINib(nibName: "ActionSheetCell", bundle: nil),
                           forCellReuseIdentifier: Constant.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
        tableView.dataSource = self
        tableView.delegate = self
        makeSheet(visible: false, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async { [weak self] in
            self?.makeSheet(visible: true, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        makeSheet(visible: false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stickView.round()
        actionSheetView.roundTopCorners(radius: 10.0)
    }
    
    // MARK: - Actions
    
    @IBAction private func coverViewDidTap(_ sender: Any) {
        close()
    }

    // MARK: - Private
    
    private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeSheet(visible: Bool, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.3 : 0.0) { [weak self] in
            self?.actionSheetBottomOffsetConstraint.priority = visible ? .defaultLow : .defaultHigh
            self?.coverView.alpha = visible ? 1.0 : 0.0
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource

extension ActionSheet: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.numberOfItems(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as? ActionSheetCell
        else {
            fatalError("Can not initialize ActionSheetCell at index path \(indexPath)")
        }
        cell.update(with: dataSource?.actionSheet(self, itemAt: indexPath.row))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ActionSheet: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.actionSheet(self, didSelectItemAt: indexPath.row)
    }
}
