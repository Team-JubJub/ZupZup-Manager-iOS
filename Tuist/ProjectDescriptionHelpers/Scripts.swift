//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by YeongJin Jeong on 2023/02/18.
//

import ProjectDescription

public extension TargetScript {
    static let SwiftLintShell = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLint/set_swiftlint.sh"),
        name: "SwiftLintShell"
    )
}


