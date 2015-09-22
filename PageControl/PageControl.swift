import UIKit

@IBDesignable
public class PageControl: UIControl {
    
    // MARK: - Interface
    
    public var currentPage: Int {
        get {
            return Int(_currentPage)
        }
        set {
            setCurrentPage(CGFloat(newValue), animated: true)
        }
    }
    public func setCurrentPage(currentPage: CGFloat, animated: Bool = false) {
        let newPage = max(0, min(currentPage, CGFloat(numberOfPages - 1)))
        _currentPage = newPage
        updateCurrentPageDisplayWithAnimation(animated)
    }
    public var numberOfPages: Int = 0 {
        didSet {
            hidden = hidesForSinglePage && numberOfPages <= 1
            if numberOfPages != oldValue {
                clearPageIndicators()
                generatePageIndicators()
                updateMaskSubviews()
                invalidateIntrinsicContentSize()
            }
            if numberOfPages > oldValue {
                updateCornerRadius()
                updateColors()
            }
            
            setCurrentPage(_currentPage, animated: false)
        }
    }
    public var hidesForSinglePage: Bool = false {
        didSet {
            hidden = hidesForSinglePage && numberOfPages <= 1
        }
    }
    public var defersCurrentPageDisplay: Bool = false
    public func updateCurrentPageDisplay() {
        updateCurrentPageDisplayWithAnimation()
    }
    public func sizeForNumberOfPages(pageCount: Int) -> CGSize {
        let width = pageIndicatorSize * CGFloat(pageCount) + pageIndicatorSpacing * CGFloat(max(0, pageCount - 1))
        return CGSize(width: max(7, width), height: defaultControlHeight)
    }
    // MARK: - Tint Color Overrides

    public var pageIndicatorTintColor: UIColor?
    public var currentPageIndicatorTintColor: UIColor?
    // MARK: - Private
    
    private var _currentPage: CGFloat = -1
    private var currentPageChangeAnimationDuration: NSTimeInterval = 0.3

    private var currentPageIndicatorContainerView = UIView()
    private var currentPageIndicatorView = UIView()
    private var pageIndicatorMaskingView = UIView()
    private var pageIndicatorContainerView = UIView()
    
    private let pageIndicatorSize: CGFloat = 7
    private let pageIndicatorSpacing: CGFloat = 9
    private let defaultControlHeight: CGFloat = 37
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: UILayoutConstraintAxis.Vertical)
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: UILayoutConstraintAxis.Horizontal)
        
        autoresizingMask = [UIViewAutoresizing.FlexibleWidth]
        
        didInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }

    private func didInit() {
        currentPageIndicatorContainerView.addSubview(currentPageIndicatorView)
        currentPageIndicatorContainerView.layer.mask = pageIndicatorMaskingView.layer
        addSubview(currentPageIndicatorContainerView)
        
        addSubview(pageIndicatorContainerView)
        
        generatePageIndicators()
        updateMaskSubviews()
        
        updateCornerRadius()
        updateColors()
        
        updateCurrentPageDisplayWithAnimation(false)
    }
}

// MARK: - Current Page Display

private extension PageControl {
    func updateCurrentPageDisplayWithAnimation(animated: Bool = true) {
        let frame = frameForPageIndicator(_currentPage, forNumberOfPages: numberOfPages)
        if animated && currentPageChangeAnimationDuration > 0.0 {
            UIView.animateWithDuration(currentPageChangeAnimationDuration) {
                self.currentPageIndicatorView.frame = frame
            }
        } else {
            currentPageIndicatorView.frame = frame
        }
    }
}

// MARK: - Tint Color

extension PageControl {
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        updateColors()
    }
}

// MARK: - Subview Layout

extension PageControl {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        pageIndicatorContainerView.frame = bounds
        pageIndicatorMaskingView.frame = bounds
        currentPageIndicatorContainerView.frame = bounds
        
        for (index, view) in pageIndicatorContainerView.subviews.enumerate() {
            view.frame = frameForPageIndicator(CGFloat(index), forNumberOfPages: numberOfPages)
        }

        for (index, view) in pageIndicatorMaskingView.subviews.enumerate() {
            view.frame = frameForPageIndicator(CGFloat(index), forNumberOfPages: numberOfPages)
        }
    }

}

// MARK: - Auto Layout

extension PageControl {
    public override func sizeThatFits(size: CGSize) -> CGSize {
        if numberOfPages == 0 || hidesForSinglePage && numberOfPages == 1 {
            return .zero
        } else {
            return sizeForNumberOfPages(numberOfPages)
        }
    }
    
    public override func intrinsicContentSize() -> CGSize {
        if numberOfPages == 0 || hidesForSinglePage && numberOfPages == 1 {
            return .zero
        } else {
            return sizeForNumberOfPages(numberOfPages)
        }
    }
}

// MARK: - Interface Builder

extension PageControl {
    public override func prepareForInterfaceBuilder() {
    }
}

// MARK: - Control

extension PageControl {
    override public var enabled: Bool {
        didSet {
            tintAdjustmentMode = enabled ? UIViewTintAdjustmentMode.Normal : UIViewTintAdjustmentMode.Dimmed
        }
    }
}

// MARK: - Page Indicators

private extension PageControl {
    func clearPageIndicators() {
        for pageIndicatorView in pageIndicatorContainerView.subviews {
            pageIndicatorView.removeFromSuperview()
        }
    }
    
    func generatePageIndicators() {
        for pageIndicatorView in pageIndicatorContainerView.subviews {
            pageIndicatorView.removeFromSuperview()
        }
        
        for _ in 0..<numberOfPages {
            let view = UIView()
            pageIndicatorContainerView.addSubview(view)
        }
    }

    func frameForPageIndicator(page: CGFloat, forNumberOfPages numberOfPages: Int) -> CGRect {
        let clampedHorizontalIndex = max(0, min(page, CGFloat(numberOfPages) - 1))
        let size = sizeForNumberOfPages(numberOfPages)
        let horizontalCenter = bounds.width / 2.0
        let verticalCenter = defaultControlHeight / 2.0 - pageIndicatorSize / 2.0
        let horizontalOffset = (pageIndicatorSize + pageIndicatorSpacing) * clampedHorizontalIndex
        return CGRect(x: horizontalOffset - size.width / 2.0 + horizontalCenter, y: verticalCenter, width: pageIndicatorSize, height: pageIndicatorSize)
    }
}

// MARK: - Appearance

private extension PageControl {
    func updateColors() {
        currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor ?? tintColor
        
        for view in pageIndicatorContainerView.subviews {
            view.layer.borderColor = pageIndicatorTintColor?.CGColor ?? tintColor.CGColor
            view.layer.borderWidth = 0.5
        }
    }
    
    func updateCornerRadius() {
        currentPageIndicatorView.layer.cornerRadius = pageIndicatorSize / 2.0
        for view in pageIndicatorContainerView.subviews {
            view.layer.cornerRadius = pageIndicatorSize / 2.0
        }
        for view in pageIndicatorMaskingView.subviews {
            view.layer.cornerRadius = pageIndicatorSize / 2.0
        }
    }
    
    func updateMaskSubviews() {
        for dotView in pageIndicatorMaskingView.subviews {
            dotView.removeFromSuperview()
        }
        
        for _ in 0..<numberOfPages {
            let view = UIView()
            view.clipsToBounds = true
            view.backgroundColor = UIColor.blackColor()
            pageIndicatorMaskingView.addSubview(view)
        }
    }
}

// MARK: - Touch

extension PageControl {
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where enabled == true {
            if touch.locationInView(self).x < bounds.size.width / 2 {
                    _currentPage = floor(_currentPage) - 1
            }
            else {
                _currentPage = round(_currentPage + 1)
            }
            if !defersCurrentPageDisplay {
                updateCurrentPageDisplayWithAnimation(true)
            }
            sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
}

}
