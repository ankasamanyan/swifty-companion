# Swifty-Companion

Swifty-Companion is an iOS application designed to help students of 42 Network of software engineering schools to keep track of their profiles, skills, and projects. It utilizes OAuth2 for authentication and interacts with the 42 API to fetch, search and display user data.

## Features

- **OAuth2 Authentication**: Securely log in using your 42 credentials.
- **User Profile**: View your profile information, including your cursus, skills, and projects.
- **Search Users**: Search for other 42 users by their login.
- **User Preview**: Get a quick preview of user profiles with key information displayed.
- **Skills and Projects**: Detailed view of skills and projects for each user.

## Preview

https://github.com/user-attachments/assets/bf6430e9-92a0-45cb-bd9a-ce4faf715a45

## Installation

To run the project locally, follow these steps:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/ankasamanyan/swifty-companion.git
    ```
2. Make sure that all the dependencies are installed, otherwise add them manually, from the dependencie list below

3. **Fill in your credentials**:
    Open the `Credentials.plist` file in the root of the `swifty-companion` directory and fill in the `CLIENT_ID` and `CLIENT_SECRET` with your 42 API credentials:
   
<img width="1106" alt="image" src="https://github.com/user-attachments/assets/042d8938-281d-4329-8cbc-a475497cdb83">
<br>

4. **Build and run** the project using Xcode on your preferred simulator or device.

## Usage

1. **Log In**: Use your 42 credentials to log in securely.
2. **View Profile**: After logging in, your profile information will be displayed.
3. **Search Users**: Use the search bar to find other 42 users by their login.
4. **View User Profiles**: Click on a user from the search results to view detailed information about their skills and projects.

## Project Structure

- `Models`: Contains all the data models used in the application.
- `Views`: Contains SwiftUI views for various screens and components.
- `APIClient.swift`: Manages all network requests to the 42 API.
- `OAuth2Handler.swift`: Manages OAuth2 authentication.

## Dependencies

- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift): Library for OAuth1.0a and OAuth2 authentication.
- [Kingfisher](https://github.com/onevcat/Kingfisher): A powerful, pure-Swift library for downloading and caching images from the web.

