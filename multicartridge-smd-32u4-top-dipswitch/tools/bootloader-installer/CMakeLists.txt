cmake_minimum_required(VERSION 3.20)
project(p2000t_bootloader_installer LANGUAGES CXX)

add_executable(p2000t-bootloader-installer src/main.cpp)
target_compile_features(p2000t-bootloader-installer PRIVATE cxx_std_17)
target_compile_options(p2000t-bootloader-installer PRIVATE -Wall -Wextra -Wpedantic)

if(MINGW)
    target_link_options(p2000t-bootloader-installer PRIVATE
        -static -static-libgcc -static-libstdc++)
endif()

set(FIRMWARE_IMAGE "${CMAKE_CURRENT_SOURCE_DIR}/../../firmware/build/combined.hex")
add_custom_target(package_bundle
    COMMAND "${CMAKE_COMMAND}"
        -DINSTALLER=$<TARGET_FILE:p2000t-bootloader-installer>
        -DFIRMWARE_IMAGE=${FIRMWARE_IMAGE}
        -DSOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}
        -P "${CMAKE_CURRENT_SOURCE_DIR}/cmake/PackageBundle.cmake"
    DEPENDS p2000t-bootloader-installer
    VERBATIM)
