//
//  DetailView.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

import UIKit

class DetailView: UIView {
    
    weak var detailVC: DetailViewController? {
        didSet {
            return setupView()
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contenView: UIView = {
        let view = UIView()
        return view
    }()
    
    let likeControl = LikeControl()
    let locationView = LocationView()
    let creatorNameView = CreatorNameView()
    let downloadsView = DownloadsView()
    let createdAtView = CreatedAtView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        scrollView.addSubview(contenView)
        contenView.translatesAutoresizingMaskIntoConstraints = false
        contenView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contenView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contenView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(likeControl)
        likeControl.translatesAutoresizingMaskIntoConstraints = false
        likeControl.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        likeControl.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        likeControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeControl.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        contenView.addSubview(locationView)
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.topAnchor.constraint(equalTo: likeControl.bottomAnchor).isActive = true
        locationView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        locationView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(creatorNameView)
        creatorNameView.translatesAutoresizingMaskIntoConstraints = false
        creatorNameView.topAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
        creatorNameView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        creatorNameView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(downloadsView)
        downloadsView.translatesAutoresizingMaskIntoConstraints = false
        downloadsView.topAnchor.constraint(equalTo: creatorNameView.bottomAnchor).isActive = true
        downloadsView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        downloadsView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(createdAtView)
        createdAtView.translatesAutoresizingMaskIntoConstraints = false
        createdAtView.topAnchor.constraint(equalTo: downloadsView.bottomAnchor).isActive = true
        createdAtView.bottomAnchor.constraint(equalTo: contenView.bottomAnchor).isActive = true
        createdAtView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        createdAtView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
    }
    
    private func setupView() {
        guard let detailVC = detailVC else { return }
        detailVC.view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: detailVC.view.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: detailVC.view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: detailVC.view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: detailVC.view.trailingAnchor).isActive = true
    }
}
