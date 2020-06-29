import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    java
    id("com.github.johnrengelman.shadow") version "6.0.0"
}

repositories {
    mavenLocal()
    jcenter()
}

java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}

dependencies {
    implementation("com.hazelcast:hazelcast-client:3.12.7")
    implementation("com.hazelcast:hazelcast-aws:2.4")
}

tasks.withType<ShadowJar>() {
    manifest {
        attributes["Main-Class"] = "engineering.everest.hazelcast.App"
    }
}