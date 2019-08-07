# Download automatically, you can also just copy the conan.cmake file
set(CONAN_MODULE "${CMAKE_SOURCE_DIR}/support/cmake/conan.cmake")
if (NOT EXISTS "${CONAN_MODULE}")
    message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.14/conan.cmake"
            "${CONAN_MODULE}")
endif()
include("${CONAN_MODULE}")


set(CONNAN_PACKAGES
        fmt/5.3.0@bincrafters/stable
        gsl_microsoft/2.0.0@bincrafters/stable
        Catch2/2.7.0@catchorg/stable
        )

conan_check(VERSION 1.0.0 REQUIRED)
set(CONAN_LIBCXX "libstdc++11")
conan_cmake_run(
        REQUIRES ${CONNAN_PACKAGES}
        BASIC_SETUP CMAKE_TARGETS
        BUILD missing)


message("** Conan libs \t: ${CONAN_LIBS}")

find_package(fmt REQUIRED)
find_package(Catch2 REQUIRED)