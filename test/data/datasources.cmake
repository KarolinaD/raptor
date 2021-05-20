cmake_minimum_required (VERSION 3.8)

include (cmake/app_datasources.cmake)

# declare_datasource (FILE example_data.tar.gz
#                     URL https://ftp.imp.fu-berlin.de/pub/seiler/raptor/example_data.tar.gz
#                     URL_HASH SHA256=7c2e7bdbf573cfe2314c8255080a5d57d966722e8bfb53712e03d87ce463ff15)


# declare_datasource (FILE expected_results.tar.gz
#                     URL https://ftp.imp.fu-berlin.de/pub/seiler/raptor/expected_results.tar.gz
#                     URL_HASH SHA256=2685ef95ebea074514f4736888b493857f0327514684ef88d798b3f25df5fd5a)

declare_datasource (FILE bin1.fa
                    URL ${CMAKE_SOURCE_DIR}/test/data/bin1.fa
                    URL_HASH SHA256=03ac546c2dfa34f2a75283d43dd2293aa702ed2b7dd877dfbb4f966d258201f0)
declare_datasource (FILE bin2.fa
                    URL ${CMAKE_SOURCE_DIR}/test/data/bin2.fa
                    URL_HASH SHA256=5bbf2f6fee427d3e967932203987b8c391ac86f0f089101455d529cb7e27b985)
declare_datasource (FILE bin3.fa
                    URL ${CMAKE_SOURCE_DIR}/test/data/bin3.fa
                    URL_HASH SHA256=93d80997611587f9635bdf7ed48eff26d995b54899e757026551df90e37464e7)
declare_datasource (FILE bin4.fa
                    URL ${CMAKE_SOURCE_DIR}/test/data/bin4.fa
                    URL_HASH SHA256=b4e3be3c001aac8481be2251aab110e4318996d26f2cdc91fb3061c35cbec4a1)

declare_datasource (FILE query.fq
                    URL ${CMAKE_SOURCE_DIR}/test/data/query.fq
                    URL_HASH SHA256=f48eb3f357e23df89e7e15d2f77f9285a428f73c4903eb1c6580271e0dea3d87)

declare_datasource (FILE 1bins19window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/1bins19window.ibf
                    URL_HASH SHA256=43da478233d4131102d3757ea33c63892b566fc796110bd4be009dcaa44b1723)
declare_datasource (FILE 1bins23window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/1bins23window.ibf
                    URL_HASH SHA256=902dae7ba8809395924bfd9517cc287dc14aacbfd60381de45bc78168f662f1c)
declare_datasource (FILE 64bins19window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/64bins19window.ibf
                    URL_HASH SHA256=7aab415ef05c942efe5ce5ec2600141b851bcde8170dad459a5c738fd7960a30)
declare_datasource (FILE 64bins23window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/64bins23window.ibf
                    URL_HASH SHA256=2a00d9fd2cf9865841b559219cb1896d33e8a20e77604906ba551e94fbdbed7f)
declare_datasource (FILE 128bins19window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/128bins19window.ibf
                    URL_HASH SHA256=73c3c7edea4d0e8a78d98397605813da195df5fedbf2aa23e12b3ff9ee0462fa)
declare_datasource (FILE 128bins23window.ibf
                    URL ${CMAKE_SOURCE_DIR}/test/data/128bins23window.ibf
                    URL_HASH SHA256=be6d52e1314fb85fbf4e919ba125dea6e4146ccddabceb7496fda9ad158671eb)

declare_datasource (FILE 1bins19window0error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/1bins19window0error.out
                    URL_HASH SHA256=b8ea0488dd7cb423b8727a6f51576d84bfffea4c16717d98e5a7247e02ace1b7)
declare_datasource (FILE 1bins19window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/1bins19window1error.out
                    URL_HASH SHA256=b8ea0488dd7cb423b8727a6f51576d84bfffea4c16717d98e5a7247e02ace1b7)
declare_datasource (FILE 1bins23window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/1bins23window1error.out
                    URL_HASH SHA256=b8ea0488dd7cb423b8727a6f51576d84bfffea4c16717d98e5a7247e02ace1b7)
declare_datasource (FILE 64bins19window0error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/64bins19window0error.out
                    URL_HASH SHA256=4c922d863949c251dcc6c351c1e7ca2a169d78969e7777abc28a6542e59211e2)
declare_datasource (FILE 64bins19window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/64bins19window1error.out
                    URL_HASH SHA256=841b3f6fb42f82b73ca6969e3395b7d48e212c8ede46526ec7befd0d670d18c5)
declare_datasource (FILE 64bins23window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/64bins23window1error.out
                    URL_HASH SHA256=841b3f6fb42f82b73ca6969e3395b7d48e212c8ede46526ec7befd0d670d18c5)
declare_datasource (FILE 128bins19window0error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/128bins19window0error.out
                    URL_HASH SHA256=62e23f0d578dd5a849fd75cde52620d4342481bc3226aced9c4de1c351b75d63)
declare_datasource (FILE 128bins19window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/128bins19window1error.out
                    URL_HASH SHA256=101c164463d9c9760351cbb81024dd74129725d9e18ef1dc7a7f3e1cd7b5e01e)
declare_datasource (FILE 128bins23window1error.out
                    URL ${CMAKE_SOURCE_DIR}/test/data/128bins23window1error.out
                    URL_HASH SHA256=101c164463d9c9760351cbb81024dd74129725d9e18ef1dc7a7f3e1cd7b5e01e)
