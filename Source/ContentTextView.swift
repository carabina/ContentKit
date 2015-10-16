//
// Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit

public protocol ContentTextViewDelegate : UITextViewDelegate {}

public class ContentTextView: UITextView {
	//
	//	:name:	layoutConstraints
	//
	internal lazy var layoutConstraints: Array<NSLayoutConstraint> = Array<NSLayoutConstraint>()
	
	/**
		:name:	init
	*/
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		prepareView()
	}
	
	/**
		:name:	init
	*/
	public override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		prepareView()
	}
	
	//
	//	:name:	deinit
	//
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
	}
	
	/**
		:name:	placeholder
	*/
	public var placeholderLabel: UILabel? {
		didSet {
			if let p = placeholderLabel {
				p.translatesAutoresizingMaskIntoConstraints = false
				p.font = font
				p.textAlignment = textAlignment
				p.numberOfLines = 0
				p.backgroundColor = .clearColor()
				addSubview(p)
				updateLabelConstraints()
				textViewTextDidChange()
			}
		}
	}
	
	
	/**
		:name:	text
	*/
	public override var text: String! {
		didSet {
			textViewTextDidChange()
		}
	}
	
	/**
		:name:	attributedText
	*/
	public override var attributedText: NSAttributedString! {
		didSet {
			textViewTextDidChange()
		}
	}
	
	/**
		:name:	textContainerInset
	*/
	public override var textContainerInset: UIEdgeInsets {
		didSet {
			updateLabelConstraints()
		}
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		placeholderLabel?.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2
	}
	
	/**
		:name:	updateLabelConstraints
	*/
	internal func updateLabelConstraints() {
		if let p = placeholderLabel {
			NSLayoutConstraint.deactivateConstraints(layoutConstraints)
			layoutConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(left)-[placeholderLabel]-(right)-|",
				options: [],
				metrics: [
					"left": textContainerInset.left + textContainer.lineFragmentPadding,
					"right": textContainerInset.right + textContainer.lineFragmentPadding
				], views: [
					"placeholderLabel": p
				])
			
			layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(top)-[placeholderLabel]-(>=bottom)-|",
				options: [],
				metrics: [
					"top": textContainerInset.top,
					"bottom": textContainerInset.bottom
				],
				views: [
					"placeholderLabel": p
				])
			NSLayoutConstraint.activateConstraints(layoutConstraints)
		}
	}
	
	//
	//	:name:	textViewTextDidChange
	//
	internal func textViewTextDidChange() {
		if let p = placeholderLabel {
			p.hidden = !text.isEmpty
		}
	}
	
	//
	//	:name:	prepareView
	//
	private func prepareView() {
		// label needs to be added to the view
		// hierarchy before setting insets
		textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16)
		backgroundColor = .clearColor()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewTextDidChange", name: UITextViewTextDidChangeNotification, object: nil)
		updateLabelConstraints()
	}
}
