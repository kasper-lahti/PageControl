import XCTest
@testable import PageControl

class PageControlParity3Tests: XCTestCase {
    var uiPageControl: UIPageControl!
    var klPageControl: PageControl!
    
    override func setUp() {
        super.setUp()
        
        uiPageControl = UIPageControl()
        klPageControl = PageControl()
        
        uiPageControl.numberOfPages = 1
        klPageControl.numberOfPages = 1
        
        uiPageControl.currentPage = 100
        klPageControl.currentPage = 100
        
        uiPageControl.hidesForSinglePage = true
        klPageControl.hidesForSinglePage = true
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
        for pageCount in 0...200 {
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
        XCTAssertEqual(uiPageControl.enabled, klPageControl.enabled)
        XCTAssertEqual(uiPageControl.selected, klPageControl.selected)
        XCTAssertEqual(uiPageControl.highlighted, klPageControl.highlighted)
        XCTAssertEqual(uiPageControl.contentVerticalAlignment, klPageControl.contentVerticalAlignment)
        XCTAssertEqual(uiPageControl.contentHorizontalAlignment, klPageControl.contentHorizontalAlignment)
        XCTAssertEqual(uiPageControl.state, klPageControl.state)
        XCTAssertEqual(uiPageControl.tracking, klPageControl.tracking)
    }
    
    func testUIViewDefaults() {
        
        XCTAssertEqual(uiPageControl.frame, klPageControl.frame)
        XCTAssertEqual(uiPageControl.bounds, klPageControl.bounds)
        
        // UI Direction
        if #available(iOS 9.0, *) {
            XCTAssertEqual(UIPageControl.userInterfaceLayoutDirectionForSemanticContentAttribute(uiPageControl.semanticContentAttribute), PageControl.userInterfaceLayoutDirectionForSemanticContentAttribute(klPageControl.semanticContentAttribute))
            XCTAssertEqual(uiPageControl.semanticContentAttribute, klPageControl.semanticContentAttribute)
        }
        
        // Event Related Behaviour
        XCTAssertEqual(uiPageControl.userInteractionEnabled, klPageControl.userInteractionEnabled)
        XCTAssertEqual(uiPageControl.multipleTouchEnabled, klPageControl.multipleTouchEnabled)
        XCTAssertEqual(uiPageControl.exclusiveTouch, klPageControl.exclusiveTouch)
        
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
        XCTAssertEqual(uiPageControl.opaque, klPageControl.opaque)
        XCTAssertEqual(uiPageControl.clearsContextBeforeDrawing, klPageControl.clearsContextBeforeDrawing)
        XCTAssertEqual(uiPageControl.hidden, klPageControl.hidden)
        XCTAssertEqual(uiPageControl.contentMode, klPageControl.contentMode)
        XCTAssertEqual(uiPageControl.mask == nil, klPageControl.maskView == nil)
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
        
        XCTAssertEqual(UIPageControl.requiresConstraintBasedLayout(), PageControl.requiresConstraintBasedLayout())
        
        // Separation of Concerns
        
        XCTAssertEqual(uiPageControl.alignmentRect(forFrame: .zero), klPageControl.alignmentRectForFrame(.zero))
        XCTAssertEqual(uiPageControl.frame(forAlignmentRect: .zero), klPageControl.frameForAlignmentRect(.zero))
        XCTAssertEqual(uiPageControl.alignmentRectInsets(), klPageControl.alignmentRectInsets())
        
        XCTAssertEqual(uiPageControl.intrinsicContentSize(), klPageControl.intrinsicContentSize())
        
        XCTAssertEqual(uiPageControl.contentHuggingPriority(for: .horizontal), klPageControl.contentHuggingPriorityForAxis(.Horizontal))
        XCTAssertEqual(uiPageControl.contentHuggingPriority(for: .vertical), klPageControl.contentHuggingPriorityForAxis(.Vertical))
        
        XCTAssertEqual(uiPageControl.contentCompressionResistancePriority(for: .horizontal), klPageControl.contentCompressionResistancePriorityForAxis(.Horizontal))
        XCTAssertEqual(uiPageControl.contentCompressionResistancePriority(for: .vertical), klPageControl.contentCompressionResistancePriorityForAxis(.Vertical))
        
    }
    
    func testUIResponderDefaults() {
        XCTAssertEqual(uiPageControl.canBecomeFirstResponder(), klPageControl.canBecomeFirstResponder())
        XCTAssertEqual(uiPageControl.becomeFirstResponder(), klPageControl.becomeFirstResponder())
    }
}
