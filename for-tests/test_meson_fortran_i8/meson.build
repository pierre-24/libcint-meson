project('test_libcint', 'fortran',
  version : '0.1.0',
  default_options : ['warning_level=3'],
)

fc = meson.get_compiler('fortran')

# configure dependencies
project_dep = []

build_args = [
  '-DPROJECT_NAME="lib' + meson.project_name() + '"',
  '-DPROJECT_VERSION="' + meson.project_version() + '"',
  '-fdefault-integer-8' # INTEGER*8 by default
]

libcint_dep = fc.find_library('libcint', required: false)
if not libcint_dep.found()
  libcint_proj = subproject('libcint', default_options: ['with_fortran=true', 'i8=true'])
  libcint_dep = libcint_proj.get_variable('libcint_dep')
endif
project_dep += libcint_dep


# fetch sources and includes
srcs = ['main.f90']

# Executable
stda_exe = executable(
  meson.project_name(), 
  srcs,
  dependencies: project_dep,
  fortran_args : build_args,
  link_language: 'fortran',
  install: true
)
