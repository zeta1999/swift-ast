/*
   Copyright 2016 Ryuichi Saito, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

public class EnumCaseElementDeclaration: Declaration {
    private let _name: String

    public init(name: String) {
        _name = name
    }

    public var name: String {
        return _name
    }

    public override func inspect(indent: Int = 0) -> String {
        return "\(getIndentText(indent))(enum-case-element-declaration '\(_name)')".terminalColor(.Yellow)
    }
}

public class EnumCaseDelcaration: Declaration {
    private let _elements: [EnumCaseElementDeclaration]

    public init(elements: [EnumCaseElementDeclaration]) {
        _elements = elements
    }

    public convenience init(element: EnumCaseElementDeclaration) {
        self.init(elements: [element])
    }

    var elements: [EnumCaseElementDeclaration] {
        return _elements
    }

    public override func inspect(indent: Int = 0) -> String {
        var inspectionText = "\(getIndentText(indent))(enum-case-declaration".terminalColor(.White)
        for element in _elements {
            inspectionText += "\n\(element.inspect(indent + 1))"
        }
        inspectionText += ")".terminalColor(.White)
        return inspectionText
    }
}

public class EnumDeclaration: Declaration {
    private let _name: String
    private let _accessLevel: AccessLevel
    private let _cases: [EnumCaseDelcaration]
    private let _attributes: [Attribute]

    public init(
        name: String,
        cases: [EnumCaseDelcaration] = [],
        attributes: [Attribute] = [],
        accessLevel: AccessLevel = .Default) {
        _name = name
        _cases = cases
        _attributes = attributes
        _accessLevel = accessLevel

        super.init()
    }

    public var name: String {
        return _name
    }

    public var attributes: [Attribute] {
        return _attributes
    }

    public var accessLevel: AccessLevel {
        return _accessLevel
    }

    public var cases: [EnumCaseDelcaration] {
        return _cases
    }

    public var elements: [EnumCaseElementDeclaration] {
        return _cases.flatMap { $0.elements }
    }

    public override func inspect(indent: Int = 0) -> String {
        var attrs = ""
        if !_attributes.isEmpty {
            let attrList = _attributes.map({ return $0.name }).joinWithSeparator(",")
            attrs = " attributes=\(attrList)"
        }
        var inspectionText = "\(getIndentText(indent))(enum-declaration '\(_name)'\(attrs) access='\(_accessLevel)' \(getSourceRangeText())".terminalColor(.Green)
        for enumCase in _cases {
            inspectionText += "\n\(enumCase.inspect(indent + 1))"
        }
        inspectionText += ")".terminalColor(.Green)
        return inspectionText
    }
}