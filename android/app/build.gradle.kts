// plugins {
//     id("com.android.application")
//     // START: FlutterFire Configuration
//     id("com.google.gms.google-services")
//     // END: FlutterFire Configuration
//     id("kotlin-android")
//     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//     id("dev.flutter.flutter-gradle-plugin")
// }

// android {
//     namespace = "com.quick.job.quickjob.quick_job"
//     compileSdk = flutter.compileSdkVersion
//     ndkVersion = flutter.ndkVersion

//     compileOptions {

//         sourceCompatibility = JavaVersion.VERSION_1_8

//         targetCompatibility = JavaVersion.VERSION_1_8

//         isCoreLibraryDesugaringEnabled = true

//     }
 
//     kotlinOptions {

//         jvmTarget = "1.8"

//     }

 

 

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId = "com.quick.job.quickjob.quick_job"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://flutter.dev/to/review-gradle-config.
//         minSdk = flutter.minSdkVersion
//         targetSdk = flutter.targetSdkVersion
//         versionCode = flutter.versionCode
//         versionName = flutter.versionName
//     }
//         buildTypes {
//             getByName("release") {
//                 isMinifyEnabled = true
//                 isShrinkResources = true
//                 proguardFiles(
//                     getDefaultProguardFile("proguard-android-optimize.txt"),
//                     "proguard-rules.pro"
//                 )

//                 // Optional: signing config if needed
//                 signingConfig = signingConfigs.getByName("debug")
//             }
//         }


//     }
// }

// flutter {
//     source = "../.."
// }


// dependencies {
//     // Other dependencies
//     coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
       

//     implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")

        

    

// }


plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.quick.job.quickjob.quick_job"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.quick.job.quickjob.quick_job"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
}
