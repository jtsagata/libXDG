set(SOURCES
  "hello_test.cpp"
)

find_package(Sanitizers)

set(LIB_NAME ${PROJECT_NAME}_lib)
set(TEST_NAME tests)

add_executable(xdg_tests test_main.cpp ${SOURCES})
add_sanitizers(xdg_tests)

target_link_libraries(xdg_tests PRIVATE xdglib CONAN_PKG::Catch2)
target_compile_definitions(xdg_tests PRIVATE CATCH_CONFIG_CONSOLE_WIDTH=80)
