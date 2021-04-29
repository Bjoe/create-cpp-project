hunter_add_package(doctest)

find_package(doctest CONFIG REQUIRED)

add_executable(maintest maintest.cpp)
target_link_libraries(maintest PRIVATE project_warnings project_options doctest::doctest)
add_test(NAME maintest COMMAND maintest)
