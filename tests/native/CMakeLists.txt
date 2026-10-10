add_executable(
	maxforge_native_protocol_test
	maxforge_native_protocol_test.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/../../source/projects/maxforge/maxforge_native_protocol.cpp
)
target_include_directories(
	maxforge_native_protocol_test
	PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/../../source/projects/maxforge
)
target_compile_features(maxforge_native_protocol_test PRIVATE cxx_std_17)

add_test(
	NAME maxforge_native_protocol
	COMMAND maxforge_native_protocol_test
)
