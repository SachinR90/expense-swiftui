import SwiftUI

public struct DecimalTextField: UIViewRepresentable {
    var maxLength: Int = 10
    var placeholder: String = ""
    @Binding var value: Double
    var prefix: String = ""
    var action: (() -> Void)?
    var precisionLength: Int = 2
    var clearFieldOnInit = true

    func getMaxLength() -> Int {
        maxLength + (floor(value) != value ? (precisionLength + 1) : 0)
    }

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.placeholder = placeholder

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
        toolbar.isTranslucent = true
        toolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: context.coordinator,
                                   action: #selector(context.coordinator.onDoneTapped(button:)))

        toolbar.items = [done, flexSpace]
        toolbar.setItems([done, flexSpace], animated: true)

        textField.inputAccessoryView = toolbar
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = context.coordinator
        textField.borderStyle = .roundedRect
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.placeholder = placeholder
        let displayText = context.coordinator.getDisplayText()
        uiView.text = displayText.isEmpty ? "" : "\(prefix)\(displayText)"
    }

    public func makeCoordinator() -> DecimalTextFieldCoordinator {
        DecimalTextFieldCoordinator(self, value: $value)
    }
}

public class DecimalTextFieldCoordinator: NSObject, UITextFieldDelegate {
    @Binding var value: Double
    private var strValue: String = ""
    func textFor(value: Double) -> String {
        return String(value)
    }

    init(_ parent: DecimalTextField, value: Binding<Double>) {
        _value = value
        self.parent = parent
        strValue = parent.clearFieldOnInit ? "" : "\(value.wrappedValue)"
    }

    var parent: DecimalTextField?

    @objc public func onDoneTapped(button _: UIBarButtonItem) {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        parent?.action?()
    }

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        let prefixCount = parent?.prefix.count ?? 0

        let textFieldString = textField.text! as NSString
        var newStr = textFieldString.replacingCharacters(in: range, with: string)
        if prefixCount > 0 && newStr.hasPrefix(parent!.prefix) {
            newStr = String(newStr.dropFirst(prefixCount))
        }
        let floatRegex = "^([0-9]+)?(\\.([0-9]{0,\(parent?.precisionLength ?? 2)})?)?$"
        let floatExPredicate = NSPredicate(format: "SELF MATCHES %@", floatRegex)
        if !floatExPredicate.evaluate(with: newStr) {
            return false
        }
        if newStr.count > (parent?.getMaxLength() ?? 10) {
            return false
        }
        strValue = newStr
        value = Double(newStr) ?? 0.0
        return true
    }

    public func getDisplayText() -> String {
        strValue
    }
}

extension DecimalTextField {
    func placeholder(_ string: String) -> DecimalTextField {
        var view = self
        view.placeholder = string
        return view
    }

    func setPrefix(_ string: String) -> DecimalTextField {
        var view = self
        view.prefix = string
        return view
    }

    func setMaxLength(_ length: Int) -> DecimalTextField {
        var view = self
        view.maxLength = length
        return view
    }

    func setPrecisionLength(_ length: Int) -> DecimalTextField {
        var view = self
        view.precisionLength = length
        return view
    }

    func onDone(_ action: (() -> Void)?) -> DecimalTextField {
        var view = self
        view.action = action
        return view
    }
}
