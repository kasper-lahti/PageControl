import UIKit

/// The `PageControl` displays a horizontal arrangement of circle outlines, each representing a page or section in your app. The currently viewed page is indicated by a filled circle.
///
/// When `setCurrentPage()` method is called with the animated parameter set to `true` the current page indicator will move to the new page with an animation.
/// This method can be used together with a `UIScrollViewDelegate`'s `scrollViewDidScroll` method to update the current page indicator continuously as the user swipes through your app's pages.
///
/// - SeeAlso: `UIPageControl`
@IBDesignable
public class PageControl: UIControl {
    
    // MARK: - Interface
    
    /// The current page, diplayed as a filled circle.
    ///
    /// The default value is 0.
    @IBInspectable
    public var currentPage: Int {
        get {
            return Int(_currentPage)
        }
        set {
            setCurrentPage(CGFloat(newValue), animated: true)
        }
    }
    
    /// The current page, diplayed as a filled or partially filled circle.
    ///
    /// - Parameter currentPage: The current page indicator is filled if the value is .0, and about half filled if ±.25.
    /// - Parameter animated: `true` to animate the transition to the new page, `false` to make the transition immediate.
    public func setCurrentPage(currentPage: CGFloat, animated: Bool = false) {
        let newPage = max(0, min(currentPage, CGFloat(numberOfPages - 1)))
        _currentPage = newPage
        updateCurrentPageDisplayWithAnimation(animated)
        updateAccessibility()
    }
    
    /// The number of page indicators to display.
    ///
    /// The default value is 0.
    @IBInspectable
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
            updateAccessibility()
        }
    }

    /// Hides the page control when there is only one page.
    ///
    /// The default is `false`.
    @IBInspectable
    public var hidesForSinglePage: Bool = false {
        didSet {
            hidden = hidesForSinglePage && numberOfPages <= 1
        }
    }
    
    /// Controls when the current page will update.
    ///
    /// The default is `false`.
    @IBInspectable
    public var defersCurrentPageDisplay: Bool = false
    
    /// Updates the current page indicator to the current page.
    /// 
    public func updateCurrentPageDisplay() {
        updateCurrentPageDisplayWithAnimation()
    }

    /// Use to size the control to fit a certain number of pages.
    /// - Parameter pageCount: A number of pages to calculate size from.
    /// - Returns: Minimum size required to display all page indicators.
    public func sizeForNumberOfPages(pageCount: Int) -> CGSize {
        let width = pageIndicatorSize * CGFloat(pageCount) + pageIndicatorSpacing * CGFloat(max(0, pageCount - 1))
        return CGSize(width: max(7, width), height: defaultControlHeight)
    }
    
    // MARK: - Tint Color Overrides

    /// When set this property overrides the page indicator border color.
    ///
    /// The default is the control's `tintColor`.
    @IBInspectable
    public var pageIndicatorTintColor: UIColor?
    
    /// When set this property overrides the current page indicator's fill color.
    ///
    /// The default is the control's `tintColor`.
    @IBInspectable
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
    
    private let accessibilityPageControl = UIPageControl()

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
        updateAccessibility()
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
        
        updateCurrentPageDisplayWithAnimation(false)

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
        } else if let superview = superview {
            return CGSize(width: superview.bounds.width, height: defaultControlHeight)
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
        for _ in 0..<numberOfPages {
            let view = UIView()
            pageIndicatorContainerView.addSubview(view)
        }
    }

    func frameForPageIndicator(page: CGFloat, forNumberOfPages numberOfPages: Int) -> CGRect {
        let clampedHorizontalIndex = max(0, min(page, CGFloat(numberOfPages) - 1))
        let size = sizeForNumberOfPages(numberOfPages)
        let horizontalCenter = bounds.width / 2.0
        let verticalCenter = bounds.height / 2.0 - pageIndicatorSize / 2.0
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
                if _currentPage - floor(_currentPage) > 0.01 {
                    _currentPage = floor(_currentPage)
                } else {
                    _currentPage = max(0, floor(_currentPage) - 1)
                }
            }
            else {
                _currentPage = min(round(_currentPage + 1), CGFloat(numberOfPages - 1))
            }
            if !defersCurrentPageDisplay {
                updateCurrentPageDisplayWithAnimation(true)
                updateAccessibility()
            }
            sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
}

// MARK: - Accessibility

private extension PageControl {
    func updateAccessibility() {
        accessibilityPageControl.currentPage = currentPage
        accessibilityPageControl.numberOfPages = numberOfPages
        
        isAccessibilityElement = accessibilityPageControl.isAccessibilityElement
        accessibilityLabel = accessibilityPageControl.accessibilityLabel
        accessibilityHint = accessibilityPageControl.accessibilityHint
        accessibilityTraits = accessibilityPageControl.accessibilityTraits
        accessibilityValue = accessibilityPageControl.accessibilityValue
    }
    
}
