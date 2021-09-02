//
//  FloatingActionButton.swift
//  FloatingButton
//
//  Created by 김도희 on 2021/07/12.
//

import UIKit

protocol FloatingActionButtonDelegate {
    func didTapButton()
}

class FloatingActionButton: UIButton {
    var delegate: FloatingActionButtonDelegate?
    /// 터치 했을 때 color
    private var accentColor: UIColor?
    /// 터치 안했을 떄 color
    private var baseColor: UIColor?
    /// 아이콘
    private var buttonIcon: UIImage?
    /// 버튼 rotate animation
    var buttonRotate: Bool?

    override var isSelected: Bool {
        didSet {
            delegate?.didTapButton()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    /// FAB init
    convenience init(
        frame: CGRect,
        baseColor: UIColor = .systemPink,
        accentColor: UIColor? = .clear,
        borderColor: UIColor? = .clear,
        borderWidth: CGFloat? = 0.0,
        icon: UIImage? = UIImage(named: "plus"),
        rotation: Bool = true,
        completion: @escaping UIControlTargetClosure
    ) {
        self.init(frame: frame)
        self.delegate = self
        // image
        setButtonImage()
        // colors
        self.baseColor = baseColor
        self.accentColor = accentColor
        self.backgroundColor = baseColor
        // border
        self.layer.borderColor = borderColor?.cgColor
        // icon
        self.buttonIcon = icon
        // Corner radius
        self.layer.cornerRadius = frame.height / 2
        // button rotate
        self.buttonRotate = rotation
        // shadow
        setShadow()
        addAction(for: .touchUpInside, closure: completion)
    }

    private func setButtonImage() {
        self.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .center
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
    }

    private func setShadow() {
        // Shadow
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.45
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: self.layer.cornerRadius
        ).cgPath
        self.layer.shouldRasterize = true // cache the rendered shadow
    }

    private func rotateButton(angle: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}

extension FloatingActionButton: FloatingActionButtonDelegate {
    /// tapped button 
    func didTapButton() {
        if self.isSelected {
            self.backgroundColor = accentColor
            if buttonRotate == true {
                rotateButton(angle: CGFloat.pi / 4)
            }
        } else {
            self.backgroundColor = baseColor
            if buttonRotate == true {
                rotateButton(angle: 0)
            }
        }
    }
}
