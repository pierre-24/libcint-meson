project('test_libcint', 'c',
  version : '0.1.0',
  default_options : ['warning_level=3'],
)

cc = meson.get_compiler('c')

# configure dependencies
project_dep = []

build_args = [
  '-DPROJECT_NAME="lib' + meson.project_name() + '"',
  '-DPROJECT_VERSION="' + meson.project_version() + '"',
]

libcint_dep = cc.find_library('libcint', required: false)
if not libcint_dep.found()
  libcint_proj = subproject('libcint', default_options: [])
  libcint_dep = libcint_proj.get_variable('libcint_dep')
endif
project_dep += libcint_dep


# fetch sources and includes
srcs = ['main.c']

# Executable
stda_exe = executable(
  meson.project_name(), 
  srcs,
  dependencies: project_dep,
  c_args : build_args,
  install: true
)
