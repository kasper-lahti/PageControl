import XCTest
@testable import PageControl

class PageControlParityTests: XCTestCase {
    var uiPageControl: UIPageControl!
    var klPageControl: PageControl!
    
    override func setUp() {
        super.setUp()
        
        uiPageControl = UIPageControl()
        klPageControl = PageControl()
    }
    
    override func tearDown() {
        uiPageControl = nil
        klPageControl = nil
        
        super.tearDown()
    }
    
    func testPageControlDefaults() {
        XCTAssertEqual(uiPageControl.numberOfPages, klPageControl.numberOfPages)
        XCTAssertEqual(uiPageControl.currentPage, klPageControl.currentPage)
        XCTAssertEqual(uiPageControl.hidesForSinglePage, klPageControl.hidesForSinglePage)
        XCTAssertEqual(uiPageControl.defersCurrentPageDisplay, klPageControl.defersCurrentPageDisplay)
        XCTAssertEqual(uiPageControl.pageIndicatorTintColor == nil, klPageControl.pageIndicatorTintColor == nil)
        XCTAssertEqual(uiPageControl.currentPageIndicatorTintColor == nil, klPageControl.currentPageIndicatorTintColor == nil)
    }
    
    func testPageControlSizeForNumberOfPages() {
        for pageCount in 0...50 {
            XCTAssertEqual(uiPageControl.size(forNumberOfPages: pageCount), klPageControl.sizeForNumberOfPages(pageCount))
        }
    }
    
    func testUIAccessibility() {
        XCTAssertEqual(uiPageControl.isAccessibilityElement, klPageControl.isAccessibilityElement)
        XCTAssertEqual(uiPageControl.accessibilityLabel, klPageControl.accessibilityLabel)
        XCTAssertEqual(uiPageControl.accessibilityHint, klPageControl.accessibilityHint)
        XCTAssertEqual(uiPageControl.accessibilityValue, klPageControl.accessibilityValue)
        XCTAssertEqual(uiPageControl.accessibilityTraits, klPageControl.accessibilityTraits)
        XCTAssertEqual(uiPageControl.accessibilityFrame, klPageControl.accessibilityFrame)
        XCTAssertEqual(uiPageControl.accessibilityElementsHidden, klPageControl.accessibilityElementsHidden)
    }
    
    func testUIControlDefaultControlAttributes() {
        XCTAssertEqual(uiPageControl.isEnabled, klPageControl.isEnabled)
        XCTAssertEqual(uiPageControl.isSelected, klPageControl.isSelected)
        XCTAssertEqual(uiPageControl.isHighlighted, klPageControl.isHighlighted)
        XCTAssertEqual(uiPageControl.contentVerticalAlignment, klPageControl.contentVerticalAlignment)
        XCTAssertEqual(uiPageControl.contentHorizontalAlignment, klPageControl.contentHorizontalAlignment)
        XCTAssertEqual(uiPageControl.state, klPageControl.state)
        XCTAssertEqual(uiPageControl.isTracking, klPageControl.isTracking)
    }
    
    func testUIViewDefaults() {
        
        XCTAssertEqual(uiPageControl.frame, klPageControl.frame)
        XCTAssertEqual(uiPageControl.bounds, klPageControl.bounds)
        
        // UI Direction
        if #available(iOS 9.0, *) {
            XCTAssertEqual(UIPageControl.userInterfaceLayoutDirection(for: uiPageControl.semanticContentAttribute), PageControl.userInterfaceLayoutDirection(for: klPageControl.semanticContentAttribute))
            XCTAssertEqual(uiPageControl.semanticContentAttribute, klPageControl.semanticContentAttribute)
        }
        
        // Event Related Behaviour
        XCTAssertEqual(uiPageControl.isUserInteractionEnabled, klPageControl.isUserInteractionEnabled)
        XCTAssertEqual(uiPageControl.isMultipleTouchEnabled, klPageControl.isMultipleTouchEnabled)
        XCTAssertEqual(uiPageControl.isExclusiveTouch, klPageControl.isExclusiveTouch)
        
        // Resizing Behavior
        XCTAssertEqual(uiPageControl.autoresizesSubviews, klPageControl.autoresizesSubviews)
        XCTAssertEqual(uiPageControl.autoresizingMask, klPageControl.autoresizingMask)
        XCTAssertEqual(uiPageControl.sizeThatFits(.zero), klPageControl.sizeThatFits(.zero))
        XCTAssertEqual(uiPageControl.sizeThatFits(CGSize(width: 1000, height: 1000)), klPageControl.sizeThatFits(CGSize(width: 1000, height: 1000)))
        
        XCTAssertEqual(uiPageControl.layoutMargins, klPageControl.layoutMargins)
        
        // Visual Appearance

        XCTAssertEqual(uiPageControl.clipsToBounds, klPageControl.clipsToBounds)
        XCTAssertEqual(uiPageControl.backgroundColor, klPageControl.backgroundColor)
        XCTAssertEqual(uiPageControl.alpha, klPageControl.alpha)
        XCTAssertEqual(uiPageControl.isOpaque, klPageControl.isOpaque)
        XCTAssertEqual(uiPageControl.clearsContextBeforeDrawing, klPageControl.clearsContextBeforeDrawing)
        XCTAssertEqual(uiPageControl.isHidden, klPageControl.isHidden)
        XCTAssertEqual(uiPageControl.contentMode, klPageControl.contentMode)
        XCTAssertEqual(uiPageControl.mask == nil, klPageControl.mask == nil)
        XCTAssertEqual(uiPageControl.tintColor, klPageControl.tintColor)
        XCTAssertEqual(uiPageControl.tintAdjustmentMode, klPageControl.tintAdjustmentMode)
        
        // Gestures
        
        XCTAssertEqual(uiPageControl.gestureRecognizers?.isEmpty, klPageControl.gestureRecognizers?.isEmpty)
        
        // Motion Effects
        
        XCTAssertEqual(uiPageControl.motionEffects.isEmpty, klPageControl.motionEffects.isEmpty)
        
        //
        // UIView Constraint-based Layout Support
        //
        
        // Installing Constraints
        
        XCTAssertEqual(uiPageControl.constraints.isEmpty, klPageControl.constraints.isEmpty)
        
        // Compatibility and Adoption
        
        XCTAssertEqual(uiPageControl.translatesAutoresizingMaskIntoConstraints, klPageControl.translatesAutoresizingMaskIntoConstraints)
        
        XCTAssertEqual(UIPageControl.requiresConstraintBasedLayout, PageControl.requiresConstraintBasedLayout)
        
        // Separation of Concerns
        
        XCTAssertEqual(uiPageControl.alignmentRect(forFrame: .zero), klPageControl.alignmentRect(forFrame: .zero))
        XCTAssertEqual(uiPageControl.frame(forAlignmentRect: .zero), klPageControl.frame(forAlignmentRect: .zero))
        XCTAssertEqual(uiPageControl.alignmentRectInsets, klPageControl.alignmentRectInsets)
        
        XCTAssertEqual(uiPageControl.intrinsicContentSize, klPageControl.intrinsicContentSize)
        
        XCTAssertEqual(uiPageControl.contentHuggingPriority(for: .horizontal), klPageControl.contentHuggingPriority(for: .horizontal))
        XCTAssertEqual(uiPageControl.contentHuggingPriority(for: .vertical), klPageControl.contentHuggingPriority(for: .vertical))
        
        XCTAssertEqual(uiPageControl.contentCompressionResistancePriority(for: .horizontal), klPageControl.contentCompressionResistancePriority(for: .horizontal))
        XCTAssertEqual(uiPageControl.contentCompressionResistancePriority(for: .vertical), klPageControl.contentCompressionResistancePriority(for: .vertical))
        
    }

    func testUIResponderDefaults() {
        XCTAssertEqual(uiPageControl.canBecomeFirstResponder, klPageControl.canBecomeFirstResponder)
        XCTAssertEqual(uiPageControl.becomeFirstResponder(), klPageControl.becomeFirstResponder())
    }
}
