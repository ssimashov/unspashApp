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
            return setupTestView()
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
    let locationContentView = LocationContentView()
    let nameContentView = NameContentView()
    let downloadsContentView = DownloadsContentView()
    let createdAtContentView = CreatedAtContentView()
    
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
        
        contenView.addSubview(locationContentView)
        locationContentView.translatesAutoresizingMaskIntoConstraints = false
        locationContentView.topAnchor.constraint(equalTo: likeControl.bottomAnchor).isActive = true
        locationContentView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        locationContentView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(nameContentView)
        nameContentView.translatesAutoresizingMaskIntoConstraints = false
        nameContentView.topAnchor.constraint(equalTo: locationContentView.bottomAnchor).isActive = true
        nameContentView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        nameContentView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(downloadsContentView)
        downloadsContentView.translatesAutoresizingMaskIntoConstraints = false
        downloadsContentView.topAnchor.constraint(equalTo: nameContentView.bottomAnchor).isActive = true
        downloadsContentView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        downloadsContentView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
        
        contenView.addSubview(createdAtContentView)
        createdAtContentView.translatesAutoresizingMaskIntoConstraints = false
        createdAtContentView.topAnchor.constraint(equalTo: downloadsContentView.bottomAnchor).isActive = true
        createdAtContentView.bottomAnchor.constraint(equalTo: contenView.bottomAnchor).isActive = true
        createdAtContentView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor).isActive = true
        createdAtContentView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor).isActive = true
    }
    
    private func setupTestView() {
        guard let detailVC = detailVC else { return }
        detailVC.view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: detailVC.view.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: detailVC.view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: detailVC.view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: detailVC.view.trailingAnchor).isActive = true
    }
}
