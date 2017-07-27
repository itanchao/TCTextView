//
//  TCTextView.swift
//  TCTextView
//
//  Created by 谈超 on 2017/7/27.
//  Copyright © 2017年 谈超. All rights reserved.
//

import UIKit

@IBDesignable class TCTextView: UITextView {
    @IBInspectable public var placeholder : NSString?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var placeholderColor : UIColor = UIColor.lightGray{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addNotify()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addNotify()
        setNeedsDisplay()
    }
    deinit {
        removeNotify()
    }
    
    
    /// 注册通知
    private func addNotify(){
        NotificationCenter.default.addObserver(self, selector: #selector(textChange(notify:)), name: .UITextViewTextDidChange, object: self)
    }
    
    /// 移除通知
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 响应通知
    @objc private func textChange(notify:NSNotification) {
        setNeedsDisplay()
    }
    override open func draw(_ rect: CGRect) {
        if text.count == 0, let placeholder = placeholder {
            textContainerInset = UIEdgeInsetsMake(10, 0, 0, 0)
            let inset = textContainerInset
            let r = CGRect(x: rect.origin.x + inset.left + 6, y: rect.origin.y + inset.top, width: rect.width - inset.left - inset.right, height: rect.height - inset.top - inset.bottom)
            placeholder.draw(in: r, withAttributes: [NSAttributedStringKey.foregroundColor:placeholderColor,NSAttributedStringKey.font:font ?? UIFont.systemFont(ofSize: 12)])
            return
        }
        super.draw(rect)
    }
}
