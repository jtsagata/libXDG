#
# Translations
#


message(${CMAKE_INSTALL_LOCALEDIR})

# List of languages this project has been translated into.  Each
# language should match a ${LANGUAGE}.po file in this directory.
set(translated_languages)

find_package(Gettext REQUIRED)

# Find sources to use process.
file(GLOB gettext_source_files
        ${CMAKE_SOURCE_DIR}/test/*.cpp
        ${CMAKE_SOURCE_DIR}/src/*.cpp
        ${CMAKE_SOURCE_DIR}/src/*.h
        )

SET(XGETTEXT_OPTIONS_DEFAULT
        --language=C --keyword=_ --keyword=N_ --keyword=C_:1c,2 --keyword=NC_:1c,2 -s --add-comments
        --escape --add-comments="/" --package-name=${PROJECT_NAME} --package-version=${PROJECT_VERSION}
        --msgid-bugs-address="${PROJECT_BUGS}")

# Create an "update-pot" target.  This will scan the sources and
# update the list of translatable strings.  Note that this will output
# to the source directory, not the build directory.
find_program(XGETTEXT xgettext)
if(NOT "${XGETTEXT}" STREQUAL "XGETTEXT-NOTFOUND")
    add_custom_command(OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/${TRANSLATION_DOMAIN}.pot
            COMMAND ${XGETTEXT}
            -o "${CMAKE_CURRENT_SOURCE_DIR}/${TRANSLATION_DOMAIN}.pot"
            ${XGETTEXT_OPTIONS_DEFAULT}
            ${gettext_source_files}
            DEPENDS ${gettext_source_files})

    add_custom_target(update-pot DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${TRANSLATION_DOMAIN}.pot")
endif()

file(STRINGS "LINGUAS" TRANSLATED)
set(translated_languages ${TRANSLATED})

# Create targets to translate each language's po file into an mo file.
set(mo_files)
set(LOCALE_BASE_DIR "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LOCALEDIR}")
foreach(language ${translated_languages})
    list(APPEND mo_files "${CMAKE_CURRENT_BINARY_DIR}/${language}.mo")
    set(TRANSLATION_RESULT_DIR "${LOCALE_BASE_DIR}/${language}/LC_MESSAGES/")
    file(MAKE_DIRECTORY ${TRANSLATION_RESULT_DIR})
    add_custom_command(OUTPUT "${language}.mo"
            COMMAND ${GETTEXT_MSGFMT_EXECUTABLE}
            -o "${TRANSLATION_RESULT_DIR}/${TRANSLATION_DOMAIN}.mo"
            "${language}.po"
            DEPENDS "${language}.po"
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
    install(FILES "${TRANSLATION_RESULT_DIR}/${TRANSLATION_DOMAIN}.mo"
            DESTINATION "${CMAKE_INSTALL_LOCALEDIR}/${language}/LC_MESSAGES/")
endforeach(language)

# Create an "update-mo" target which depends on all the mo files.
add_custom_target(update-translations ALL DEPENDS ${mo_files})
