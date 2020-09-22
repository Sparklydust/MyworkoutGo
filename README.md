# Myworkout Interview Task - Login/Signup flow



## by Roland LARIOTTE
## contact: roland.lariotte@gmail.com



## Description
Your task is to implement a minimal app consisting of 4 screens (as shown in proto.pdf), which you can distinguish with the following headings:

1. Get started screen: "Myworkout GO".
2. Login screen: "Welcome back".
3. Signup screen: "Create a new account".
4. Profile screen: "Profile".

The app should support the following core use cases:

1. As a new user, I would like to have a way to create an account in order to use the app.
2. As an existing user that has not logged in yet, I would like to have a way to enter my credentials in order to access the app.
3. As a user that has an account and has logged in before, I would like to access the app without having to log in again.
4. As a logged in user, I would like to be able to log out of the app so that other users are not able to access my session.

## Approach
1. Create a GIT repository.
2. Add ANSWERS.md to the repository.
3. Create a native iOS project and add the project to the GIT repo you created.
4. Commit these changes to the repository.
5. We have included some assets (in the Assets directory), that can be used in the implementation.
6. Track the time spent to complete each task.
7. Check-in/commit changes to the repository as you progress.
8. Fill in the ANSWERS.md and answer the questions provided there.
9. When you have either completed the task or spent the maximum allocated time , zip the repository (with the .git) and submit it through the provided link. Do not hesitate to let us know if you are experiencing any problems with uploading the task.

The purpose of this task, in part, is to show how you think and work. Therefore, we would like you to commit chunks of code as you work towards completing the task. As an added benefit, if you don't manage to finish the task, you will still have something to submit for evaluation.

We value your time; therefore we expect you to spend a maximum of between 4 to 8 hours on this task. We also recommend that you prioritize completing the functional requirements over polishing the UI, which you can then focus on towards the end of the task. By logging the time you spend on this task, both you and the evaluators will gain some insight into the duration of the task.

## How we will evaluate your performance
Your performance will be evaluated based on:
1. Your knowledge of programming best practices and clean code.
2. Your ability to understand requirements.
3. Your ability to communicate your decisions and code changes.
4. Tests are not required but will be considered a bonus.
5. A generally polished UI/UX will be considered a bonus.
6. Styling is not the primary objective of the test. Therefore we do not expect the implementation to match the design 100%. You are welcome to choose your own appropriate fonts, colors, etc. The use of gradients is also optional.

## Requirements
The sections below describe the core functionality of each of the screens.

### Screen 1 Get started screen
```Gherkin
Feature: Get started screen
    When either a new or existing user opens the app for the first time, they
    will be greeted with the getting started screen. The purpose of this screen is to 
    direct them to either the Signup or Login screen based on whether
    their email address is already registered or not.

Scenario: The email address registered@email.com is already registered
    Given the email address is "registered@email.com" 
    When the Next button is tapped
    Then it should navigate to the Login screen

Scenario: Any other email address is not yet registered
    Given the email address is [any other email address]
    When the Next button is tapped
    Then it should navigate to the Signup screen
```
#### Notes:
1. Initially, there is only one registered user in the system with the following details:
    - Email: registered@email.com
2. You are not required to write any server-side code for this, you can mock this service. This should be an asynchronous operation that will take at least a second to execute (which can be simulated by adding a 1 second delay).
    
### Screen 2 Login screen
```Gherkin
Feature: Login Functionality
    When an existing user wants to use the app, they would have to sign in 
    by providing their registered email address and password

Scenario: Valid login credentials are provided
    Given the email address is "registered@email.com" 
    And the password is "password"
    When the Log in button is tapped
    Then the user should be logged in
    And the user should be taken to the profile screen
```
#### Notes:
1. Initially, there is only one registered user in the system with the following details:
    - Email: registered@email.com
    - Password: password
2. An error should be presented if the user specifies invalid login credentials
3. You are not required to write any server-side code for this, you can mock this log in service. This should be an asynchronous operation that will take at least a second to execute (which can be simulated by adding a 1 second delay).

### Screen 3 Signup screen
```Gherkin
Feature: Signup Functionality
    When a new user wants to use the app, they should be able to sign up
    by providing an email address, password and their gender.

Scenario: A valid email address (non-registered), password and gender is specified.
    Given a valid (non-registered) email address is provided
    And a valid password is provided
    And a gender is provided 
    When the Sign up button is tapped
    Then a new user should be created with the given information
    And the user should be logged in with the newly created account
    And the user should be taken to the profile screen
```
#### Notes: 
1. An error should be presented if the user tries to sign up with an already registered account.
2. All fields should be required (non-empty)
3. You are not required to write any server-side code for this, you can mock this sign up service. This should be an asynchronous operation that will take at least a second to execute (which can be simulated by adding a 1 second delay).

### Screen 4 Profile screen
```Gherkin
Feature: Profile screen
    After a new user has signed up or an existing user has logged in they should 
    see a profile screen that shows their personal information.

Scenario: The profile screen is shown
    When the profile screen is shown
    Then the logged in user's email address should be displayed
    And the logged in user's gender should be displayed
```

```Gherkin
Feature: Logout functionality 
    A user that is logged in wants to be able to log out so that they (or someone else) can sign in / sign up
    with a different account.
Scenario: Tapping on the log out button
    When the log out button is tapped
    Then the user should be logged out 
    And should be taken to the Get started screen
```

#### Notes:
The profile picture is nonessential, you can just show any static image here.

## Additional requirements
### Cancel button
The user should be taken back to the initial "Get started screen" when the "Cancel" button is pressed on either the Login or Signup screen.

### Remaining logged in
If a user is logged in to the app, and they close the app, then they should remain logged in after opening the app again. The app should start directly on the Profile screen if they are already logged in. It is up to you to decide how the user's information will be persisted between the sessions, but a solution like storing the logged-in user using NSUserDefaults would be an easy and suitable way for this task.

### Prefilled Email field
The email address that was entered on the Get started screen should be prefilled on the Login and Signup screen.
