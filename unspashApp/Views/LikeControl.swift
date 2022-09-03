//
//  LikeControl.swift
//  unspashApp
//
//  Created by Sergey Simashov on 04.09.2022.
//

import UIKit

class LikeControl: UIControl {
    
    var isLiked: Bool? = false

    let like: UIImageView = {
        let like = UIImageView()
        like.contentMode = .scaleAspectFill
        return like
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupConfig() {
        addSubview(like)
        like.translatesAutoresizingMaskIntoConstraints = false
        like.topAnchor.constraint(equalTo: topAnchor).isActive = true
        like.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        like.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        like.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setupLikeColor() {
        if isLiked == false {
            like.image = UIImage(systemName: "heart")
            like.tintColor = .gray
        } else if isLiked == true {
            self.like.image = UIImage(systemName: "heart.fill")
            self.like.tintColor = .red
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
//        guard let isLiked = isLiked else { return }

        if isLiked == false {
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.25, options: [.autoreverse]) {
                self.like.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } completion: { _ in
                self.like.transform = .identity
            }
            
            UIView.transition(with: like, duration: 0.1, options: .transitionCrossDissolve) {
                self.like.image = UIImage(systemName: "heart.fill")
                self.like.tintColor = .red
            }
            
            isLiked = true
            
        } else if isLiked == true {
            
            UIView.transition(with: like, duration: 0.1, options: .transitionCrossDissolve) {
                self.like.image = UIImage(systemName: "heart")
                self.like.tintColor = .gray
            }
            
            isLiked = false
        }
    }
}
