//
//  UIControl+.swift
//  FloatingButton
//
//  Created by Allie Kim on 2021/08/27.
//

import UIKit

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
