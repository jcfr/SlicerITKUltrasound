#-----------------------------------------------------------------------------
# Build the ITK BSplineGradient module, pointing it to Slicer's ITK

set(proj ITKSplitComponents)

# Dependencies
set(${proj}_DEPENDENCIES )
ExternalProject_Include_Dependencies(${proj} PROJECT_VAR proj DEPENDS_VAR ${proj}_DEPENDENCIES)

set(${proj}_BINARY_DIR ${CMAKE_BINARY_DIR}/${proj}-build)

# disable-wrapping 2018-06-15
set(${proj}_GIT_TAG 9349567031960e08a3ff20119c2a776e8368598c)
ExternalProject_Add(${proj}
  ${${proj}_EP_ARGS}
  GIT_REPOSITORY ${EP_GIT_PROTOCOL}://github.com/InsightSoftwareConsortium/ITKSplitComponents.git
  GIT_TAG ${${proj}_GIT_TAG}
  SOURCE_DIR ${proj}
  BINARY_DIR ${${proj}_BINARY_DIR}
  INSTALL_COMMAND ""
  CMAKE_CACHE_ARGS
    -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}
    -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
    -DITK_DIR:PATH=${ITK_DIR}
    -DBUILD_TESTING:BOOL=OFF
    -DITK_INSTALL_RUNTIME_DIR:STRING=${Slicer_INSTALL_LIB_DIR}
    -DITK_INSTALL_LIBRARY_DIR:STRING=${Slicer_INSTALL_LIB_DIR}
  DEPENDS ${${proj}_DEPENDENCIES}
)

set(${proj}_DIR ${${proj}_BINARY_DIR})
mark_as_superbuild(VARS ${proj}_DIR:PATH)

ExternalProject_Message(${proj} "${proj}_DIR:${${proj}_DIR}")
