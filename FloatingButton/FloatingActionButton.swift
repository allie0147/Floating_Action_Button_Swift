//
//  FloatingActionButton.swift
//  FloatingButton
//
//  Created by 김도희 on 2021/07/12.
//

import UIKit

class FloatingActionButton: UIButton {
    /// 터치 했을 때 color
    private var accentColor: UIColor?
    /// 터치 안했을 떄 color
    private var baseColor: UIColor?
    /// 아이콘
    private var buttonIcon: UIImage?

    /// 터치 했을 때 ripple 효과
    private var rippleEnabled: Bool = false
    /// 선택된 효과 적용
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? accentColor : baseColor
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
        rippleEffect: Bool? = false,
        completion: @escaping UIControlTargetClosure
    ) {
        self.init(frame: frame)
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
        self.rippleEnabled = rippleEffect ?? false
        // Corner radius
        self.layer.cornerRadius = frame.height / 2
        // shadow
        setShadow()
        self.addAction(for: .touchUpInside, closure: completion)
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
}
// MARK: -Extension: UIControl
extension UIControl {
    public typealias UIControlTargetClosure = (UIControl) -> ()

    /// closure 저장 WrapperClass
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure" // 값 저장용 key
    }

    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else {
                return nil
            }
            return closureWrapper.closure
        }

        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// 저장된 closure를 가져옴
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
        self.isSelected = !self.isSelected
    }

    /// action
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
}
