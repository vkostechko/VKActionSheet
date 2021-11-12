//
//  ActionSheetCell.swift
//  VKActionSheet
//
//  Created by Viachaslau Kastsechka on 11/11/21.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var checkmarkImageView: UIImageView!
    @IBOutlet private weak var mainTextLabel: UILabel!
    
    // MARK: - Properties
    
    private var imageLoadingTask: URLSessionDataTask?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = .sheetGray
        selectedBackgroundView = backgroundColorView
        
        checkmarkImageView.round()
        
        photoImageView.makeBorder(width: 1.0, with: .sheetLightBlue)
        checkmarkImageView.makeBorder(width: 1.0, with: .white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkmarkImageView.isHidden = !selected
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.round()
    }
    
    // MARK: - Public
    
    func update(with item: ActionSheetItem?) {
        guard let item = item else {
            cleanUp()
            return
        }
        
        mainTextLabel.text = item.title
        checkmarkImageView.isHidden = !item.isSelected
        cancelImageLoading()
        imageLoadingTask = photoImageView.setupImage(from: item.imageURL)
    }
    
    // MARK: - Private
    
    private func cleanUp() {
        cancelImageLoading()
        photoImageView.image = UIImage(named: "no-photo")
        checkmarkImageView.isHidden = true
        mainTextLabel.text = ""
    }
    
    private func cancelImageLoading() {
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
    }
}
