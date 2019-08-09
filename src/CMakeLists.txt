configure_file(config.h.in config.h  @ONLY)

set(SOURCES
  "hello.cpp"
  "hello.h"
)

find_package(Sanitizers)

add_library(xdglib STATIC ${SOURCES})
add_sanitizers(xdglib)
set_target_properties(xdglib PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_include_directories(xdglib PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(xdglib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(xdglib PROPERTIES PUBLIC_HEADER "hello.h")

install(TARGETS xdglib
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/libxdg
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})


add_executable(xdg_demo xdg_demo.cpp)
add_sanitizers(xdg_demo)
target_link_libraries(xdg_demo PRIVATE xdglib CONAN_PKG::fmt Boost::filesystem)
install(TARGETS xdg_demo
        RUNTIME DESTINATION bin
        )
