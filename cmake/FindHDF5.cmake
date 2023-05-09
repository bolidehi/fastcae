﻿# FindHDF5
# --------
#
# Find the HDF5 libraries(Only for HDF5 provided by FastCAE)
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# The following variables will be defined:
#
# ``HDF5_FOUND`` True if HDF5 found on the local system
#
# ``HDF5_VERSION`` HDF5 Version(x.x.x)
#
# ``HDF5_VERSION_MAJOR`` HDF5 Major Version
#
# ``HDF5_VERSION_MINOR`` HDF5 Minor Version
#
# ``HDF5_VERSION_PATCH`` HDF5 Patch Version
#
# ``HDF5_DIRS`` Location of HDF5(root dir)
#
# ``HDF5_INCLUDE_DIRS`` Location of HDF5 header files
#
# ``HDF5_LIBRARY_DIRS`` Location of HDF5 libraries
#
# ``HDF5_LIBRARIES`` List of the HDF5 libraries found
#

# 防止重复引入
if(FASTCAE_HDF5_ALREADY_INCLUDED)
	return()
endif()
set(FASTCAE_HDF5_ALREADY_INCLUDED 1)

# find_path 搜索包含某个文件的路径
# 如果在某个路径下发现了该文件，该结果会被存储到该变量中；如果没有找到，存储的结果将会是<VAR>-NOTFOUND
find_path(HDF5_DIRS 
	NAMES 
		include/hdf5.h 
	PATHS 
		${CMAKE_SOURCE_DIR}/extlib/HDF5 
	NO_SYSTEM_ENVIRONMENT_PATH
	NO_CMAKE_SYSTEM_PATH
)

set(HDF5_VERSION_MAJOR 1)
set(HDF5_VERSION_MINOR 13)
set(HDF5_VERSION_PATCH 1)

set(HDF5_VERSION "${HDF5_VERSION_MAJOR}.${HDF5_VERSION_MINOR}.${HDF5_VERSION_PATCH}")

find_path(HDF5_INCLUDE_DIRS
	NAMES
		hdf5.h
	HINTS
		${HDF5_DIRS}/include
)

find_path(HDF5_LIBRARY_DIRS
	NAMES
		hdf5.lib libhdf5.so
	HINTS
		${HDF5_DIRS}/lib
)

set(HDF5_LIBRARIES FASTCAE::HDF5;FASTCAE::HDF5CPP;FASTCAE::HDF5HL;FASTCAE::HDF5HLCPP;FASTCAE::HDF5TOOLS)

add_library(FASTCAE::HDF5 SHARED IMPORTED)
add_library(FASTCAE::HDF5CPP SHARED IMPORTED)
add_library(FASTCAE::HDF5HL SHARED IMPORTED)
add_library(FASTCAE::HDF5HLCPP SHARED IMPORTED)
add_library(FASTCAE::HDF5TOOLS SHARED IMPORTED)

set_property(TARGET FASTCAE::HDF5 PROPERTY INTERFACE_COMPILE_DEFINITIONS "H5_BUILT_AS_DYNAMIC_LIB")
set_property(TARGET FASTCAE::HDF5 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${HDF5_INCLUDE_DIRS})
set_property(TARGET FASTCAE::HDF5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)

set_property(TARGET FASTCAE::HDF5CPP PROPERTY INTERFACE_COMPILE_DEFINITIONS "H5_BUILT_AS_DYNAMIC_LIB")
set_property(TARGET FASTCAE::HDF5CPP PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${HDF5_INCLUDE_DIRS})
set_property(TARGET FASTCAE::HDF5CPP APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_property(TARGET FASTCAE::HDF5CPP PROPERTY INTERFACE_LINK_LIBRARIES FASTCAE::HDF5)

set_property(TARGET FASTCAE::HDF5HL PROPERTY INTERFACE_COMPILE_DEFINITIONS "H5_BUILT_AS_DYNAMIC_LIB")
set_property(TARGET FASTCAE::HDF5HL PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${HDF5_INCLUDE_DIRS})
set_property(TARGET FASTCAE::HDF5HL APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_property(TARGET FASTCAE::HDF5HL PROPERTY INTERFACE_LINK_LIBRARIES FASTCAE::HDF5)

set_property(TARGET FASTCAE::HDF5HLCPP PROPERTY INTERFACE_COMPILE_DEFINITIONS "H5_BUILT_AS_DYNAMIC_LIB")
set_property(TARGET FASTCAE::HDF5HLCPP PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${HDF5_INCLUDE_DIRS})
set_property(TARGET FASTCAE::HDF5HLCPP APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_property(TARGET FASTCAE::HDF5HLCPP PROPERTY INTERFACE_LINK_LIBRARIES FASTCAE::HDF5HL)

set_property(TARGET FASTCAE::HDF5TOOLS PROPERTY INTERFACE_COMPILE_DEFINITIONS "H5_BUILT_AS_DYNAMIC_LIB")
set_property(TARGET FASTCAE::HDF5TOOLS PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${HDF5_INCLUDE_DIRS})
set_property(TARGET FASTCAE::HDF5TOOLS APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_property(TARGET FASTCAE::HDF5TOOLS PROPERTY INTERFACE_LINK_LIBRARIES FASTCAE::HDF5)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
	set_target_properties(FASTCAE::HDF5 PROPERTIES
		IMPORTED_LOCATION_RELEASE "${HDF5_LIBRARY_DIRS}/libhdf5.so.300.1.0"
		IMPORTED_SONAME_RELEASE "libhdf5.so.300"
	)
	set_target_properties(FASTCAE::HDF5CPP PROPERTIES
		IMPORTED_LOCATION_RELEASE "${HDF5_LIBRARY_DIRS}/libhdf5_cpp.so.300.0.1"
		IMPORTED_SONAME_RELEASE "libhdf5_cpp.so.300"
	)
	set_target_properties(FASTCAE::HDF5HL PROPERTIES
		IMPORTED_LOCATION_RELEASE "${HDF5_LIBRARY_DIRS}/libhdf5_hl.so.300.0.1"
		IMPORTED_SONAME_RELEASE "libhdf5_hl.so.300"
	)
	set_target_properties(FASTCAE::HDF5HLCPP PROPERTIES
		IMPORTED_LOCATION_RELEASE "${HDF5_LIBRARY_DIRS}/libhdf5_hl_cpp.so.300.0.1"
		IMPORTED_SONAME_RELEASE "libhdf5_hl_cpp.so.300"
	)
	set_target_properties(FASTCAE::HDF5TOOLS PROPERTIES
		IMPORTED_LOCATION_RELEASE "${HDF5_LIBRARY_DIRS}/libhdf5_tools.so.300.0.1"
		IMPORTED_SONAME_RELEASE "libhdf5_tools.so.300"
	)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
	set_target_properties(FASTCAE::HDF5 PROPERTIES
		IMPORTED_IMPLIB_RELEASE "${HDF5_LIBRARY_DIRS}/hdf5.lib"
		IMPORTED_LOCATION_RELEASE "${HDF5_DIRS}/bin/hdf5.dll"
	)
	set_target_properties(FASTCAE::HDF5CPP PROPERTIES
		IMPORTED_IMPLIB_RELEASE "${HDF5_LIBRARY_DIRS}/hdf5_cpp.lib"
		IMPORTED_LOCATION_RELEASE "${HDF5_DIRS}/bin/hdf5_cpp.dll"
	)
	set_target_properties(FASTCAE::HDF5HL PROPERTIES
		IMPORTED_IMPLIB_RELEASE "${HDF5_LIBRARY_DIRS}/hdf5_hl.lib"
		IMPORTED_LOCATION_RELEASE "${HDF5_DIRS}/bin/hdf5_hl.dll"
	)
	set_target_properties(FASTCAE::HDF5HLCPP PROPERTIES
		IMPORTED_IMPLIB_RELEASE "${HDF5_LIBRARY_DIRS}/hdf5_hl_cpp.lib"
		IMPORTED_LOCATION_RELEASE "${HDF5_DIRS}/bin/hdf5_hl_cpp.dll"
	)
	set_target_properties(FASTCAE::HDF5TOOLS PROPERTIES
		IMPORTED_IMPLIB_RELEASE "${HDF5_LIBRARY_DIRS}/hdf5_tools.lib"
		IMPORTED_LOCATION_RELEASE "${HDF5_DIRS}/bin/hdf5_tools.dll"
	)
endif()

include(FindPackageHandleStandardArgs)

# 如果找到所有需要的变量，并且版本匹配，则将HDF5_FOUND变量设置为TRUE
find_package_handle_standard_args(HDF5
	FOUND_VAR
		HDF5_FOUND
	REQUIRED_VARS
		HDF5_DIRS
		HDF5_INCLUDE_DIRS
		HDF5_LIBRARY_DIRS
		HDF5_LIBRARIES
	VERSION_VAR
		HDF5_VERSION
)