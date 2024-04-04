# Translation of most of https://github.com/sunqm/libcint/blob/master/CMakeLists.txt (no test or example)
# To be used with a wrap file as a Meson subproject.

project(
    'cint', 'c',
    version : '#VERSION#',
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()

# configure
project_config = configuration_data({
    'cint_VERSION': '#VERSION#',
    'cint_SOVERSION': '6'
})

quadmath_dep = cc.find_library('quadmath', required: false)
if quadmath_dep.found() and cc_id != 'clang'
    project_config.set('HAVE_QUADMATH_H', true)
endif

if cc.has_function('expl')
    project_config.set('HAVE_EXPL', true)
endif

if cc.has_function('sqrtl')
    project_config.set('HAVE_SQRTL', true)
endif

# sources & includes
srcs = []

subdir('include')
subdir('src')

includes = include_directories('src', 'include')

# configure dependencies & build args
project_dep = [
    cc.find_library('m', required : true)
]

build_args = []

if cc.has_argument('-march=native')
    build_args += ['-march=native', '-fno-math-errno']
    if cc.get_id() == 'intel'
        build_args += ['-unroll-aggressive', '-ipo']
    else
        build_args += ['-funroll-loops', '-ftree-vectorize']
    endif
    message('added -march=native and loop unroling flags')
endif

if quadmath_dep.found() and cc_id != 'clang'
    project_dep += quadmath_dep
    build_args += '-DHAVE_QUADMATH_H'
    message('added quadmath')
endif

# deal with options:
if get_option('with_polynomial_fit')
    srcs += files('src/polyfits.c', 'src/sr_rys_polyfits.c')
    build_args += '-DWITH_POLYNOMIAL_FIT'
endif

if get_option('with_f12')
    srcs += files('src/g2e_f12.c', 'src/stg_roots.c', 'src/cint2e_f12.c')
    build_args += '-DWITH_F12'
endif

if get_option('with_4c1e')
    srcs += files('src/cint4c1e.c', 'src/g4c1e.c')
    message('Enabled WITH_4C1E. Note there are bugs in 4c1e integral functions')
endif

if get_option('pypzpx')
    build_args += '-DPYPZPX'
endif

if get_option('min_expcutoff') != ''
    build_args += '-DMIN_EXPCUTOFF=' + get_option('min_expcutoff')
endif

if get_option('keep_going')
    build_args += '-DKEEP_GOING'
endif

if get_option('with_fortran')
    build_args += '-DWITH_FORTRAN'
endif

if get_option('with_cint2_interface')
    build_args += '-DWITH_CINT2_INTERFACE'
endif

# library
libcint = library(
    meson.project_name(),
    srcs,
    c_args: build_args,
    include_directories: includes,
    dependencies: project_dep,
    install: not meson.is_subproject(),
)

libcint_dep = declare_dependency(
    link_with: libcint,
    include_directories: includes,
    dependencies: project_dep,
)
