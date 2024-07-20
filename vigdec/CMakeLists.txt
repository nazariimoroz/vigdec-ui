cmake_minimum_required(VERSION 2.8)
project(vigdec)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

find_package(Threads REQUIRED)
if(THREADS_HAVE_PTHREAD_ARG)
	target_compile_options(tester PUBLIC "-pthread")
endif()


set(CMAKE_C_FLAGS "-Wall")
set(CMAKE_C_FLAGS_DEBUG "-g")
set(CMAKE_C_FLAGS_RELEASE "-O3")

if (DIRTY)
  set(CMAKE_C_FLAGS_RELEASE "-O3 -march=broadwell -mtune=broadwell")
endif()	

set(CRYPTO 
	crypto/exception.cpp
	crypto/sym_alg.cpp
	crypto/vigenere_ciph.cpp
	crypto/subst_cipher.cpp
)

set(ANALYZER 
	analyzer/analyzer.cpp
	analyzer/scanner.cpp
	analyzer/utils.cpp
	analyzer/ngram.cpp
)

set(TEST 
	test/test_main.cpp
	test/test_cryptor.cpp
	analyzer/utils.cpp
	test/gtest/gtest-all.cc
)

add_library(cryptor SHARED ${CRYPTO})

include_directories(test/include)

add_library(vigdec SHARED ${ANALYZER})
target_link_libraries(vigdec PRIVATE cryptor)
target_include_directories(vigdec PUBLIC ./analyzer/)

add_executable(vigdec_cli analyzer/vigdec.cpp)
target_link_libraries(vigdec_cli PRIVATE vigdec)

add_executable(tester ${TEST})
if (CMAKE_THREAD_LIBS_INIT)
	target_link_libraries(tester cryptor "${CMAKE_THREAD_LIBS_INIT}")
endif()
target_link_libraries(tester cryptor)

if (NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_CURRENT_BINARY_DIR)

	set(data_SHADOW english_trigrams.txt english_bigrams.txt english_quadgrams.txt)

	foreach(item IN LISTS data_SHADOW)
		message(STATUS ${item})
		add_custom_command(TARGET vigdec
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E copy_if_different
					"${CMAKE_CURRENT_SOURCE_DIR}/${item}"
					"${CMAKE_CURRENT_BINARY_DIR}/${item}"
		)
	endforeach()
endif()
