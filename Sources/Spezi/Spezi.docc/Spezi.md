# ``Spezi``

<!--

This source file is part of the Stanford Spezi open-source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT

-->

Open-source framework for rapid development of modern, interoperable digital health applications.

## Overview

> Tip: Refer to the <doc:Initial-Setup> instructions on how to integrate Spezi into your application!

Spezi introduces a standards-based modular approach to building digital health applications. 


<!--
Unfortunately, DocC currently does not support dark mode images: https://github.com/apple/swift-docc/pull/359#issuecomment-1214405608
-->
@Row {
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziOnboarding/main/Sources/SpeziOnboarding/SpeziOnboarding.docc/Resources/ConsentView.png", alt: "Screenshot displaying the UI of the onboarding module.") {
            [The Spezi Onboarding Module](https://github.com/StanfordSpezi/SpeziOnboarding)
        }
    }
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziContact/main/Sources/SpeziContact/SpeziContact.docc/Resources/Overview.png", alt: "Screenshot displaying the UI of the contact module.") {
            [The Spezi Contract Module](https://github.com/StanfordSpezi/SpeziContact)
        }
    }
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziQuestionnaire/main/Sources/SpeziQuestionnaire/SpeziQuestionnaire.docc/Resources/Overview.png", alt: "Screenshot displaying the UI of the questionnaire module.") {
            [The Spezi Questionnaire Module](https://github.com/StanfordSpezi/SpeziQuestionnaire)
        }
    }
}
@Row {
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziAccount/main/Sources/SpeziAccount/SpeziAccount.docc/Resources/AccountSetup.png", alt: "Screenshot displaying the account setup view with an email and password prompt and a Sign In with Apple button using the Spezi Account module.") {
            [The Spezi Account Module](https://github.com/StanfordSpezi/SpeziAccount)
        }
    }
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziViews/main/Sources/SpeziValidation/SpeziValidation.docc/Resources/Validation.png", alt: "Three different kinds of text fields showing validation errors in red text using Spezi Validation package.") {
            The `SpeziValidation` package of the [Spezi Views Module](https://github.com/StanfordSpezi/SpeziViews).
        }
    }
    @Column {
        @Image(source: "https://raw.githubusercontent.com/StanfordSpezi/SpeziLLM/main/Sources/SpeziLLMLocal/SpeziLLMLocal.docc/Resources/ChatView.png", alt: "A Chat View of a locally executed LLM using the Spezi LLM module.") {
            [The Spezi LLM Module](https://github.com/StanfordSpezi/SpeziLLM)
        }
    }
}

The best way to get started and explore the functionality of Spezi is by taking a look at the [Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication). The application incorporates a wide variety of sophisticated modules and demonstrates the usage of these modules in a simple-to-use and easy-to-extend application.


### An Ecosystem of Modules

You can find a list of modules and reusable Swift Packages offered by the Spezi team at Stanford at [the Swift Package Index Stanford Spezi page](https://swiftpackageindex.com/StanfordSpezi).

> Note: Spezi relies on an ecosystem of modules. Think about what modules you want to build and contribute to the open-source community! Refer to the <doc:Spezi-Guide> and <doc:Documentation-Guide> about the requirements for Spezi-based software modules and the ``Module`` documentation to learn more about building your modules.

Learn more about Spezi at [spezi.stanford.edu](https://spezi.stanford.edu).
Reach out to us on social media and use the [Stanford Spezi Discussion Forum](https://github.com/orgs/StanfordSpezi/discussions) to ask any Spezi-related questions or share the projects you built with Spezi.

Check out the [Stanford Biodesign Digital Health GitHub organization](https://github.com/StanfordBDHG) and [Stanford Biodesign Digital Health website at bdh.stanford.edu](https://bdh.stanford.edu), for example, applications built with Spezi and some of our related open-source and research projects.


### The Spezi Building Blocks

> Tip: The <doc:Spezi-Guide> and <doc:Documentation-Guide> guides define the requirements for Spezi-based modules, including terminology, hints, and examples of structuring your Spezi module, Swift Package, and surrounding repository.

A ``Standard`` defines the key coordinator that orchestrates the data flow in the application by meeting requirements defined by modules.
You can learn more about the ``Standard`` protocol and when it is advised to create your own standard in your application in the <doc:Standard> documentation.

A ``Module`` defines a software subsystem providing distinct and reusable functionality.
Modules can use the constraint mechanism to enforce a set of requirements to the standard used in the Spezi-based software where the module is used.
Modules also define dependencies on each other to reuse functionality and can communicate with other modules by offering and collecting information.
You can learn more about modules in the <doc:Module> documentation.


## Topics

### Ecosystem Overview
- <doc:Spezi_Ecosystem>

### Configuration

- <doc:Initial-Setup>
- ``SpeziAppDelegate``
- ``Configuration``
- ``SwiftUICore/View/spezi(_:)-3bn89``

### Essential Concepts

- ``Spezi/Spezi``
- ``Standard``
- ``Module``

### Previews

- ``SwiftUICore/View/previewWith(standard:simulateLifecycle:_:)``
- ``SwiftUICore/View/previewWith(simulateLifecycle:_:)``
- ``Foundation/ProcessInfo/isPreviewSimulator``
- ``LifecycleSimulationOptions``

### Contribute to Spezi

- <doc:Contributing-Guide>
- <doc:Spezi-Guide>
- <doc:Documentation-Guide>
