if (POLICY CMP0072)
    cmake_policy(SET CMP0072 NEW)
endif()

find_package(OpenGL REQUIRED)
set(DEPENDENCIES realsense2 glfw ${OPENGL_LIBRARIES})
