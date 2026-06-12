# ------------------------------
# Flutter + Deferred Components (Play Store)
# ------------------------------
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }

# Keep listeners and tasks used by deferred components
-keep class com.google.android.play.core.tasks.** { *; }

# ------------------------------
# Stripe Push Provisioning
# ------------------------------
-keep class com.stripe.android.pushProvisioning.** { *; }
-keep interface com.stripe.android.pushProvisioning.EphemeralKeyUpdateListener { *; }
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }

# ------------------------------
# General Flutter and reflection
# ------------------------------
-keep class io.flutter.embedding.android.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keepattributes *Annotation*


-keep class **.zego.** { *; }
-keep class **.**.zego_zpns.** { *; }

