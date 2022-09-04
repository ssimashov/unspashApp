//
//  SearchCollectionViewCell.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCell(){
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
