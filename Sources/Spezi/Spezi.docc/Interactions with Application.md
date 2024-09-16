# Interactions with Application

Interact with the Application.

<!--

This source file is part of the Stanford Spezi open-source project

SPDX-FileCopyrightText: 2024 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT

-->

## Overview

Spezi provides platform-agnostic mechanisms to interact with your application instance.
To access application properties or actions you can use the ``Application`` property wrapper within your
``Module``, ``Standard`` or SwiftUI `View`.

> Tip: The <doc:Notifications> articles illustrates how you can easily manage user notifications within your Spezi application. 

## Topics

### Application Interaction

- ``Application``

### Properties

- ``Spezi/logger``
- ``Spezi/launchOptions``

### Notifications

- ``Spezi/registerRemoteNotifications``
- ``Spezi/unregisterRemoteNotifications``
- ``Spezi/notificationSettings``
- ``Spezi/requestNotificationAuthorization``

### Platform-agnostic type-aliases

- ``ApplicationDelegateAdaptor``
- ``BackgroundFetchResult``