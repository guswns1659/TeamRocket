//
//  WholeTutorialView.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class WholeTutorialView: UIView {
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var firstView: TutorialFirstView!
    @IBOutlet weak var secondView: TutorialSecondView!
    @IBOutlet weak var thirdView: TutorialThirdView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        configureUI()
        configureGestureRecognizer()
        thirdView.delegate = self
    }
    
    private func configureUI() {
        firstView.roundCorner(cornerRadius: 10)
        secondView.roundCorner(cornerRadius: 10)
        thirdView.roundCorner(cornerRadius: 10)
        scrollView.contentInset = .init(top: 0, left: 38, bottom: 0, right: 38)
        scrollView.decelerationRate = .fast
    }
    
    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide(_:)))
        frameView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hide(_ recognizer: UITapGestureRecognizer) {
        isHidden = true
    }
}

extension WholeTutorialView: TutorialThirdViewDelegate {
    func doneButtonDidTap() {
        isHidden = true
    }
}

extension WholeTutorialView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let cellWidthIncludingSpacing = firstView.frame.width + 12
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing

        var roundedIndex = round(index)
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index) }
        else {
            roundedIndex = ceil(index)
        }
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
