//
//  FloatingActionButton.swift
//  FloatingButton
//
//  Created by 김도희 on 2021/07/12.
//

import UIKit

enum FABType {
    case `default`
    case custom
}

class FloatingActionButton: UIButton {
    private var fabType: FABType = .default
    /// 터치 했을 때 color
    private var accentColor: UIColor?
    /// 터치 안했을 떄 color
    private var baseColor: UIColor?
    /// 아이콘
    private var buttonIcon: UIImage?
    /// 터치 했을 때 dim 효과
//    private var maskLayer: CALayer {
//        let mask = CALayer()
//        mask.frame = self.bounds
//        mask.backgroundColor = isSelected ?
//            accentColor?.darker()?.withAlphaComponent(0.3).cgColor
//            : baseColor?.darker()?.withAlphaComponent(0.3).cgColor
//        return mask
//    }

    /// 버튼 색 변경 유무
    private var changeBackground: Bool = false

    /// 선택된 효과 적용
    override var isSelected: Bool {
        didSet {
            if changeBackground {
                self.layer.backgroundColor = isSelected ? accentColor?.cgColor : baseColor?.cgColor
            }
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
        fabType: FABType = .default,
        changeColor: Bool = false,
        baseColor: UIColor = .systemPink,
        accentColor: UIColor? = .clear,
        borderColor: UIColor? = .clear,
        borderWidth: CGFloat? = 0.0,
        icon: UIImage? = UIImage(systemName: "plus",
                                 withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
    ) {
        self.init(type: .custom)
        // -TODO: fab type에 따라서 분기
        // do something()..
        
        
        // background change Y/N
        self.changeBackground = changeColor
        // colors
        self.baseColor = baseColor
        self.accentColor = accentColor
        self.layer.backgroundColor = baseColor.cgColor
        // border
        self.layer.borderColor = borderColor?.cgColor
        // icon
        self.buttonIcon = icon
//        self.layer.borderWidth = borderWidth.value(or: 0.0)
        addButtonLayout()
    }

    // MARK: - Layout
    /// 버튼 레이아웃
    private func addButtonLayout() {
        self.setImage(buttonIcon, for: .normal)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        // Shadow
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 5,
                width: 60 + 5,
                height: 60
            ),
            cornerRadius: 30
        ).cgPath
        self.layer.shouldRasterize = true // cache the rendered shadow
        // Corner radius
        self.layer.cornerRadius = 30
        // add target
        self.addTarget(self, action: #selector(didTapFAB), for: .touchUpInside)
    }

    @objc
    private func didTapFAB() {
        print("tab!")
//        let alert = UIAlertController(title: "Add Something", message: "Floating Button Tapped", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
//        present(alert, animated: true)
    }
}
