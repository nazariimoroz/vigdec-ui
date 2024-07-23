cmake_minimum_required(VERSION 3.16)

project(ui VERSION 1.0 LANGUAGES CXX)
set(PROJECT_NAME_QT VigdecUi)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick Gui Core QuickControls2 REQUIRED)

qt_add_executable(${PROJECT_NAME}
        main.cpp
        DecoderThread.cpp
        DecoderThread.h
)

qt_add_qml_module(${PROJECT_NAME}
        URI ${PROJECT_NAME_QT}
        OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${PROJECT_NAME_QT}"
        RESOURCE_PREFIX /
        VERSION 1.0
        QML_FILES
            view/Main.qml
            view/Decoder.qml
            view/Processing.qml
            view/Result.qml
        SOURCES
            services/DecoderService.h
            services/DecoderService.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE
        .
        ./view/
        ./services/)

target_link_libraries(${PROJECT_NAME} PRIVATE vigdec Qt6::Quick Qt6::Gui Qt6::Core Qt6::QuickControls2)
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${vigdec_BINARY_DIR} $<TARGET_FILE_DIR:${PROJECT_NAME}>
    COMMAND_EXPAND_LISTS)
