@setlocal

@if "%1"=="" (set config=Debug) else (set config=%1)
@if "%2"=="" (set platform=x64) else (set platform=%2)
@if "%~3"=="" (set cmake_args=) else (set cmake_args=-- /logger:%3)

@set PreferredToolArchitecture=%platform%
@set BOOST_ROOT=%CD%\IPC\packages\boost.1.71.0.0\lib\native\include
@set BOOST_LIBRARYDIR=%CD%\IPC\packages\boost.1.71.0.0
@set BOND_GBC_PATH=%CD%\IPC\packages\Bond.Compiler.9.0.3\tools

@rmdir /s /q bond\build\CMakeFiles
@del bond\build\CMakeCache.txt

@mkdir bond\build\target\%platform%\%config%
@pushd bond\build

@cmake -G "Visual Studio 16 2019" -A %platform% -DBOND_LIBRARIES_ONLY=ON -DBOND_ENABLE_GRPC=FALSE -DCMAKE_INSTALL_PREFIX=%CD%\target\%platform%\%config% ..
@cmake --build . --config %config% --target %cmake_args%
@cmake --build . --config %config% --target INSTALL %cmake_args%

@popd
@endlocal
