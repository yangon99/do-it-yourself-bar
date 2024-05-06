cmake_minimum_required(VERSION 3.5)
project(DoItYourselfBar)

set(QT_MAJOR_VERSION 6)
set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

if(NOT CMAKE_INSTALL_PREFIX)
    set(CMAKE_INSTALL_PREFIX "/usr")
endif()

if(NOT KDE_INSTALL_QMLDIR)
    file(STRINGS /etc/os-release distro REGEX "^NAME=.*$")
    if(distro MATCHES ".*Ubuntu.*")
        set(KDE_INSTALL_QMLDIR "/usr/lib/x86_64-linux-gnu/qt6/qml")
    endif()

    file(STRINGS /etc/os-release distro REGEX "^NAME=.*$")
    if(distro MATCHES ".*openSUSE.*")
        set(KDE_INSTALL_QMLDIR "/usr/lib64/qt6/qml")
    endif()

    file(STRINGS /etc/os-release distro REGEX "^NAME=.*$")
    if(distro MATCHES ".*Arch|Manjaro|Solus.*")
        set(KDE_INSTALL_QMLDIR "/usr/lib/qt6/qml")
    endif()
endif()

if(NOT ICON_INSTALL_DIR)
    set(ICON_INSTALL_DIR "/usr/share/icons")
endif()

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs6)
include(KDECompilerSettings)
include(KDECMakeSettings)
include(ECMInstallIcons)

set(KF6_MIN_VERSION 6.0.0)

find_package(Qt6 REQUIRED COMPONENTS DBus
             CONFIG REQUIRED
             Qml)

find_package(KF6 ${KF6_MIN_VERSION}
             REQUIRED COMPONENTS)
find_package(Plasma)

plasma_install_package(package org.kde.plasma.doityourselfbar)

set(doityourselfbar_SRCS
    plugin/BlockInfo.cpp
    plugin/DBusService.cpp
    plugin/DoItYourselfBar.cpp
    plugin/DoItYourselfBarPlugin.cpp
)

add_library(doityourselfbar SHARED ${doityourselfbar_SRCS})

target_link_libraries(doityourselfbar
                      Qt6::Qml
                      Qt6::DBus)

install(TARGETS doityourselfbar DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/doityourselfbar)
install(FILES plugin/qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/plasma/doityourselfbar)

ecm_install_icons(ICONS icons/sc-apps-doityourselfbar.svg DESTINATION ${ICON_INSTALL_DIR})
