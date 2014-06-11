//
//  DSL.swift
//  Quick
//
//  Created by Brian Ivan Gesiak on 6/5/14.
//  Copyright (c) 2014 Brian Ivan Gesiak. All rights reserved.
//

@objc class DSL {
    class func describe(description: String, closure: () -> ()) {
        var group = ExampleGroup(description)
        World.currentExampleGroup()!.appendExampleGroup(group)
        World.setCurrentExampleGroup(group)
        closure()
        World.setCurrentExampleGroup(group.parent)
    }

    class func context(description: String, closure: () -> ()) {
        self.describe(description, closure: closure)
    }

    class func beforeEach(closure: () -> ()) {
        World.currentExampleGroup()!.appendBefore(closure)
    }

    class func afterEach(closure: () -> ()) {
        World.currentExampleGroup()!.appendAfter(closure)
    }

    class func it(description: String, closure: () -> ()) {
        let example = Example(description, closure)
        World.currentExampleGroup()!.appendExample(example)
    }
}

func describe(description: String, closure: () -> ()) {
    DSL.describe(description, closure: closure)
}

func context(description: String, closure: () -> ()) {
    describe(description, closure)
}

func beforeEach(closure: () -> ()) {
    DSL.beforeEach(closure)
}

func afterEach(closure: () -> ()) {
    DSL.afterEach(closure)
}

func beforeSuite(closure: () -> ()) {
    World.appendBeforeSuite(closure)
}

func afterSuite(closure: () -> ()) {
    World.appendAfterSuite(closure)
}

func it(description: String, closure: () -> ()) {
    DSL.it(description, closure: closure)
}
