# The Spezi Ecosystem

<!--
This source file is part of the Stanford Spezi open-source project
SPDX-FileCopyrightText: 2024 Stanford University and the project authors (see CONTRIBUTORS.md)
SPDX-License-Identifier: MIT
-->

Discover the core modules of the Spezi ecosystem and understand how you can use them to build your healthcare and research applications.


## Module Overview
This document outlines the modules specifically tailored to various use cases. 

- [Spezi Onboarding](#spezi-onboarding) for user onboarding with welcome screens and more. 
- [User Management](#user-management) for login account creation and customization flows.
- [Spezi Contact](#spezi-contact) for managing and displaying contact information.
- [Spezi AccessGuard](#spezi-accessguard) for login access codes and biometrics.
- [Connected Devices and Spezi Bluetooth](#connected-devices-and-spezi-bluetooth) for supporting Bluetooth-connected devices.
- [Cloud Systems](#cloud-systems) for Google Firebase integration and data synchronization.
- [Local Data Storage](#local-data-storage) for efficient data persistence and retrieval.
- [Electronic Health Integration](#electronic-health-integration) for managing FHIR data and data interoperability.
- [Mobile Health Data](#mobile-health-data) for accessing HealthKit data.
- [LLMs and AI Integration](#llms-and-ai-integration) for AI-driven functionalities.
- [Spezi Questionnaire](#spezi-questionnaire) for customizable forms.
- [Spezi Medication](#spezi-medication) for managing medication details, dosages, and more.
- [Tasks and Reminders](#tasks-and-reminders) for task scheduling and notification management.
- [Spezi Notifications](#spezi-notifications) for implementing user notifications and related.


## Overview of the Core Modules

The Spezi ecosystem provides a collection of interoperable modules designed to accelerate healthcare and research application development. Each module is built to work independently or in combination with others, allowing you to choose the components that best fit your needs.


> Important: To get started with Spezi, we recommend exploring the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)** first, which demonstrates many of the following modules in action.


### Spezi Onboarding
- The **[SpeziOnboarding](https://github.com/StanfordSpezi/SpeziOnboarding)** provides features for a comprehensive onboarding experience with welcome screens, sequential onboarding flows, and consent management.

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**

@Row{
    @Column {
        ![Screenshot displaying the onboarding view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziOnboarding/main/Sources/SpeziOnboarding/SpeziOnboarding.docc/Resources/OnboardingView.png)
    }
    @Column {
        ![Screenshot displaying the sequential onboarding view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziOnboarding/main/Sources/SpeziOnboarding/SpeziOnboarding.docc/Resources/SequentialOnboardingView.png)
    }
    @Column {
        ![Screenshot displaying the consent view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziOnboarding/main/Sources/SpeziOnboarding/SpeziOnboarding.docc/Resources/ConsentView.png)
    }
}

> Tip: Check out the [SpeziOnboarding Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziOnboarding/documentation/spezionboarding) to learn more about the implementation details.


### User Management
- The **[SpeziAccount](https://github.com/StanfordSpezi/SpeziAccount)** module provides comprehensive user authentication and profile management capabilities, enabling secure login flows, account creation, and profile customization within your application.

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

@Row{
    @Column {
        ![Screenshot displaying the account setup view with an email and password prompt and a Sign In with Apple button.](https://raw.githubusercontent.com/StanfordSpezi/SpeziAccount/main/Sources/SpeziAccount/SpeziAccount.docc/Resources/AccountSetup.png)
    }
    @Column {
        ![Screenshot displaying the Signup Form for Account setup.](https://raw.githubusercontent.com/StanfordSpezi/SpeziAccount/main/Sources/SpeziAccount/SpeziAccount.docc/Resources/SignupForm.png)
    }
    @Column {
        ![Screenshot displaying the Account Overview.](https://raw.githubusercontent.com/StanfordSpezi/SpeziAccount/main/Sources/SpeziAccount/SpeziAccount.docc/Resources/AccountOverview.png)
    }
}

> Tip: Check out the [SpeziAccount Documentation](https://swiftpackageindex.com/stanfordspezi/speziaccount/documentation/speziaccount) for implementation details.


### Spezi Contact
- The **[SpeziContact](https://github.com/StanfordSpezi/SpeziContact)** module facilitates the presentation and management of contact information, offering customizable display options for contact details including names, phone numbers, and email addresses. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

@Row{
    @Column {
       ![Screenshot showing contact display](https://raw.githubusercontent.com/StanfordSpezi/SpeziContact/refs/heads/main/Sources/SpeziContact/SpeziContact.docc/Resources/Overview.png)
    }
    @Column {
       > Tip: Check out the [SpeziContact Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziContact/documentation/spezicontact) for implementation details.
    }   
    @Column {
       ![ ]()
    }  
}


### Spezi AccessGuard
- The **[SpeziAccessGuard](https://github.com/StanfordSpezi/SpeziAccessGuard)** module provides robust security features for SwiftUI views, including numeric access code protection, biometric authentication support, and customizable timeout settings for automatic locking.

@Row {
    @Column {
        ![Screenshot showing access code entry](https://raw.githubusercontent.com/StanfordSpezi/SpeziAccessGuard/refs/heads/main/Sources/SpeziAccessGuard/SpeziAccessGuard.docc/Resources/AccessGuarded.png)
    }
    @Column {
        ![Screenshot showing biometric auth](https://raw.githubusercontent.com/StanfordSpezi/SpeziAccessGuard/refs/heads/main/Sources/SpeziAccessGuard/SpeziAccessGuard.docc/Resources/AccessGuarded-Biometrics.png)
    }
    @Column {
      > Tip: Check out the [SpeziAccessGuard Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziAccessGuard/documentation/speziaccessguard) for implementation details.
    }  
}


### Connected Devices and Spezi Bluetooth
- The **[SpeziDevices](https://github.com/StanfordSpezi/SpeziDevices)** module streamlines the integration of Bluetooth-connected devices, handling device discovery, connection management, and data exchange through a unified interface that works seamlessly with the SpeziBluetooth infrastructure.

- The **[SpeziBluetooth](https://github.com/StanfordSpezi/SpeziBluetooth)** module provides the foundational infrastructure for Bluetooth communication, offering robust device discovery, configuration management, and reliable data transmission capabilities for healthcare and research applications.

> Note: SpeziDevices is a higher-level module that depends on the core Bluetooth connectivity offered by SpeziBluetooth module (see below). Together, they enable seamless interaction with Bluetooth devices.

@Row{
    @Column {
        ![Screenshot showing paired devices in a grid layout. A sheet is presented in the foreground showing a nearby devices able to pair.](https://raw.githubusercontent.com/StanfordSpezi/SpeziDevices/main/Sources/SpeziDevicesUI/SpeziDevicesUI.docc/Resources/PairedDevices.png)
    }
    @Column {
        ![Displaying the device details of a paired device with information like Model number and battery percentage.](https://raw.githubusercontent.com/StanfordSpezi/SpeziDevices/main/Sources/SpeziDevicesUI/SpeziDevicesUI.docc/Resources/DeviceDetails.png)
    }
    @Column {
        ![Showing a newly recorded blood pressure measurement.](https://raw.githubusercontent.com/StanfordSpezi/SpeziDevices/main/Sources/SpeziDevicesUI/SpeziDevicesUI.docc/Resources/MeasurementRecorded_BloodPressure.png)
    }
}

> Tip: Check out the [SpeziDevices Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziDevices/documentation/spezidevices) and [SpeziBluetooth Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziBluetooth/documentation/spezibluetooth) for implementation details.


### Cloud Systems
- The **[SpeziFirebase](https://github.com/StanfordSpezi/SpeziFirebase)** module enables seamless Google Firebase integration, providing backend authentication and data storage capabilities with features for Firebase authentication, database operations, and cross-device data synchronization. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**

> Tip: Check out the [SpeziFirebase Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziFirebase/documentation/spezifirebaseaccount) for implementation details.


### Local Data Storage
- The **[SpeziStorage](https://github.com/StanfordSpezi/SpeziStorage)** module provides robust local storage capabilities, offering efficient data persistence, retrieval management, and seamless integration with other Spezi modules. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

> Tip: Check out the [SpeziStorage Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziStorage/documentation/spezilocalstorage) for implementation details.


### Electronic Health Integration
- The **[SpeziFHIR](https://github.com/StanfordSpezi/SpeziFHIR)** module provides comprehensive support for managing and processing FHIR (Fast Healthcare Interoperability Resources), enabling storage and management of FHIR resources, automatic healthcare data categorization, and seamless interoperability with healthcare systems.

> Tip: Check out the [SpeziFHIR Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziFHIR/documentation/spezifhir) for implementation details.


### Mobile Health Data 
- The **[SpeziHealthKit](https://github.com/StanfordSpezi/SpeziHealthKit)** module simplifies access to HealthKit data, providing streamlined retrieval of health samples and supporting various query types including single, anchored, and background queries for comprehensive health data monitoring. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

@Row{
    @Column {
        ![Screenshot showing Health Kit Access Screen.](https://raw.githubusercontent.com/StanfordSpezi/SpeziTemplateApplication/refs/heads/main/TemplateApplication/Supporting%20Files/TemplateApplication.docc/Resources/Onboarding/HealthKitAccess.png)
    }
    @Column {
        ![Displaying the device view of a Health Kit Access.](https://raw.githubusercontent.com/StanfordSpezi/SpeziTemplateApplication/refs/heads/main/TemplateApplication/Supporting%20Files/TemplateApplication.docc/Resources/Onboarding/HealthKitSheet.png)
    }
    @Column {
       > Tip: Check out the [SpeziHealthKit Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziHealthKit/documentation/spezihealthkit) for implementation details.
    } 
}


### Electronic Health Integration
- The **[SpeziFHIR](https://github.com/StanfordSpezi/SpeziFHIR)** module provides comprehensive support for managing and processing FHIR (Fast Healthcare Interoperability Resources), enabling storage and management of FHIR resources, automatic healthcare data categorization, and seamless interoperability with healthcare systems.

> Tip: Check out the [SpeziFHIR Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziFHIR/documentation/spezifhir) for implementation details.


### LLMs and AI Integration
This module includes three submodules:

- The **[SpeziChat](https://github.com/StanfordSpezi/SpeziChat)** module implements sophisticated chat-based user interfaces with comprehensive message history management and seamless AI integration for natural language processing.

@Row{
    @Column {
        ![Screenshot displaying the regular chat view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziChat/main/Sources/SpeziChat/SpeziChat.docc/Resources/ChatView.png)
    }
    @Column {
        ![Screenshot displaying the text input chat view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziChat/main/Sources/SpeziChat/SpeziChat.docc/Resources/ChatView+TextInput.png)
    }
    @Column {
        ![Screenshot displaying the voice input chat view.](https://raw.githubusercontent.com/StanfordSpezi/SpeziChat/main/Sources/SpeziChat/SpeziChat.docc/Resources/ChatView+VoiceInput.png)
    }
}

- The **[SpeziSpeech](https://github.com/StanfordSpezi/SpeziSpeech)** module delivers comprehensive voice interaction capabilities, offering both speech synthesis and recognition features along with robust session management for voice input and output.

- The **[SpeziLLM](https://github.com/StanfordSpezi/SpeziLLM)** module integrates large language models to provide AI-driven functionalities, enabling sophisticated text generation and contextual understanding for complex queries.

@Row{
    @Column {
        ![Screenshot displaying the Chat View utilizing the OpenAI API from SpeziLLMOpenAI.](https://raw.githubusercontent.com/StanfordSpezi/SpeziLLM/main/Sources/SpeziLLMOpenAI/SpeziLLMOpenAI.docc/Resources/ChatView.png)
    }
    @Column {
        ![Screenshot displaying the Local LLM Download View from SpeziLLMLocalDownload.](https://raw.githubusercontent.com/StanfordSpezi/SpeziLLM/main/Sources/SpeziLLMLocalDownload/SpeziLLMLocalDownload.docc/Resources/LLMLocalDownload.png)
    }
    @Column {
        ![Screenshot displaying the Chat View utilizing a locally executed LLM via SpeziLLMLocal.](https://raw.githubusercontent.com/StanfordSpezi/SpeziLLM/main/Sources/SpeziLLMLocal/SpeziLLMLocal.docc/Resources/ChatView.png)
    }
}

> Tip: 
Check out [SpeziChat Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziChat/documentation/spezichat), [SpeziSpeech Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziSpeech/1.1.1/documentation/spezispeechrecognizer) for implementation details.
and [SpeziLLM Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziLLM/documentation/spezillm) for implementation details.


### Spezi Questionnaire
- The **[SpeziQuestionnaire](https://github.com/StanfordSpezi/SpeziQuestionnaire)** module implements comprehensive questionnaire features, providing customizable forms for data capture and seamless integration with health or research applications. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

@Row {
    @Column {
        ![Screenshot showing questionaire view](https://raw.githubusercontent.com/StanfordSpezi/SpeziTemplateApplication/refs/heads/main/TemplateApplication/Supporting%20Files/TemplateApplication.docc/Resources/Schedule/Questionnaire.png)
    }
    @Column {
       > Tip: Check out the [SpeziQuestionnaire Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziQuestionnaire/documentation/speziquestionnaire) for implementation details.
    } 
    @Column {
       ![ ]()
    } 
}


### Spezi Medication 
- The **[SpeziMedication](https://github.com/StanfordSpezi/SpeziMedication)** module provides comprehensive medication management capabilities, enabling the display and editing of medication details, dosages, and schedules, along with complete medication list management functionality.

> Tip: Check out the [SpeziMedication Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziMedication/documentation/spezimedication) for implementation details.


### Tasks and Reminders
- The **[SpeziScheduler](https://github.com/StanfordSpezi/SpeziScheduler)** module provides comprehensive task scheduling and reminder functionality, enabling task creation, notification management, and seamless integration with other Spezi modules. 

This module is included and demonstrated in the **[Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication)**.

@Row {
    @Column {
        ![Screenshot showing SpeziScheduler view](https://raw.githubusercontent.com/StanfordSpezi/SpeziScheduler/refs/heads/main/Sources/SpeziSchedulerUI/SpeziSchedulerUI.docc/Resources/Schedule-Date.png)
    }
    @Column {
       ![Screenshot showing SpeziScheduler view](https://raw.githubusercontent.com/StanfordSpezi/SpeziScheduler/refs/heads/main/Sources/SpeziSchedulerUI/SpeziSchedulerUI.docc/Resources/Schedule-Today-Center.png) 
    } 
    @Column {
       ![Screenshot showing SpeziScheduler view](https://raw.githubusercontent.com/StanfordSpezi/SpeziScheduler/refs/heads/main/Sources/SpeziSchedulerUI/SpeziSchedulerUI.docc/Resources/Schedule-Tomorrow.png) 
    } 
}

> Tip: Check out the [SpeziScheduler Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziScheduler/documentation/spezischeduler) for implementation details.


### Spezi Notifications
- The **[SpeziNotifications](https://github.com/StanfordSpezi/SpeziNotifications)** module simplifies the implementation of user notifications, providing features for scheduling local notifications, customizing notification content, and managing notification permissions and settings.

> Tip: Check out the [SpeziNotifications Documentation](https://swiftpackageindex.com/StanfordSpezi/SpeziNotifications/documentation/spezinotifications) for implementation details.


