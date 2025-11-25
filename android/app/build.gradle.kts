plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

android {
    namespace = "com.example.concise_note_pad"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.acer.concise_note_pad"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 添加签名配置
    // signingConfigs {
    //     create("release") {
    //         // 从 key.properties 文件读取签名配置
    //         val keystorePropertiesFile = rootProject.file("key.properties")
    //         val keystoreProperties = Properties()
    //         keystoreProperties.load(FileInputStream(keystorePropertiesFile))

    //         keyAlias = keystoreProperties.getProperty("keyAlias")
    //         keyPassword = keystoreProperties.getProperty("keyPassword")
    //         storeFile = file(keystoreProperties.getProperty("storeFile"))
    //         storePassword = keystoreProperties.getProperty("storePassword")
    //     }
    // }

    buildTypes {
      // getByName("release") {
      //     // 使用release签名配置
      //     signingConfig = signingConfigs.getByName("release")
      //     isMinifyEnabled = true
      //     isShrinkResources = true
      //     proguardFiles(
      //         getDefaultProguardFile("proguard-android.txt"),
      //         "proguard-rules.pro"
      //     )
      // }
        
      getByName("debug") {
          signingConfig = signingConfigs.getByName("debug")
      }
    }
}

flutter {
    source = "../.."
}
