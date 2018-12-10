# Cricket Team
[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/ibhavikmakwana) 

A Flutter application that demonstarte simple CRUD operations with Firebase cloud database.

## Add Firebase to your app

1. Create a Firebase project. Check out the [Firebase](https://firebase.google.com/docs/flutter/setup) documentation for setting up the firebase in your flutter application.
2. Create a new Firebase console project
3. Add [Cloud Firestore](https://pub.dartlang.org/packages/cloud_firestore) to the project in the pubspec.yaml
4. Drop the created *google-services.json* in *android/app*

## Gradles

Changes to the *android/build.gradle*:

```
buildscript {
        repositories {
            ...
        }

        dependencies {
            ...
            classpath 'com.google.gms:google-services:3.2.1' // Google Services plugin
        }
    }
```

And then we have the *android/app/build.gradle*:

```
//bottom of file
apply plugin: 'com.google.gms.google-services'
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Contribute
1. Fork the the project
2. Create your feature branch (git checkout -b my-new-feature)
3. Make required changes and commit (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## Questions?🤔

Hit me on

<a href="https://twitter.com/ibhavikmakwana"><img src="./icons/twitter-icon.png?raw=true" width="60"></a>
<a href="https://medium.com/@ibhavikmakwana"><img src="./icons/medium-icon.png?raw=true" width="60"></a>
<a href="https://www.linkedin.com/in/ibhavikmakwana/"><img src="./icons/linkedin-icon.png?raw=true" width="60"></a>
