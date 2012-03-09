include(CheckCSourceCompiles)

if(NOT TJPEG_INCLUDE_DIR)
	if(64BIT)
		set(DEFAULT_TJPEG_INCLUDE_DIR c:\\libjpeg-turbo64\\include)
	else()
		set(DEFAULT_TJPEG_INCLUDE_DIR c:\\libjpeg-turbo\\include)
	endif()
else()
	set(DEFAULT_TJPEG_INCLUDE_DIR ${TJPEG_INCLUDE_DIR})
	unset(TJPEG_INCLUDE_DIR)
	unset(TJPEG_INCLUDE_DIR CACHE)
endif()

find_path(TJPEG_INCLUDE_DIR turbojpeg.h
	DOC "TurboJPEG include directory (default: ${DEFAULT_TJPEG_INCLUDE_DIR})"
	HINTS ${DEFAULT_TJPEG_INCLUDE_DIR})
if(TJPEG_INCLUDE_DIR STREQUAL "TJPEG_INCLUDE_DIR-NOTFOUND")
	message(FATAL_ERROR "Could not find turbojpeg.h in ${DEFAULT_TJPEG_INCLUDE_DIR}.  If it is installed in a different place, then set TJPEG_INCLUDE_DIR accordingly.")
else()
	message(STATUS "TJPEG_INCLUDE_DIR = ${TJPEG_INCLUDE_DIR}")
endif()
include_directories(${TJPEG_INCLUDE_DIR})

if(64BIT)
	set(DEFAULT_TJPEG_LIBRARY c:\\libjpeg-turbo64\\lib\\turbojpeg-static.lib)
else()
	set(DEFAULT_TJPEG_LIBRARY c:\\libjpeg-turbo\\lib\\turbojpeg-static.lib)
endif()

set(TJPEG_LIBRARY ${DEFAULT_TJPEG_LIBRARY} CACHE PATH
  "TurboJPEG library path (default: ${DEFAULT_TJPEG_LIBRARY})")

set(CMAKE_REQUIRED_DEFINITIONS -MT)
set(CMAKE_REQUIRED_INCLUDES ${TJPEG_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${TJPEG_LIBRARY})
check_c_source_compiles("#include <turbojpeg.h>\nint main(void) { tjhandle h=tjInitCompress(); return 0; }" TURBOJPEG_WORKS)
set(CMAKE_REQUIRED_DEFINITIONS)
set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_LIBRARIES)
if(NOT TURBOJPEG_WORKS)
	message(FATAL_ERROR "Could not link with TurboJPEG library ${TJPEG_LIBRARY}.  If it is installed in a different place, then set TJPEG_LIBRARY accordingly.")
endif()

message(STATUS "TJPEG_LIBRARY = ${TJPEG_LIBRARY}")