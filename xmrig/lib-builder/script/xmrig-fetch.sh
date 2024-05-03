#!/usr/bin/env bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT

#version="v6.17.0"

if [ ! -d "xmrig" ]; then
  git clone https://github.com/C3Pool/xmrig-C3.git xmrig
  cd ..
  cd ..
  #patch build/src/xmrig/src/net/strategies/DonateStrategy.cpp ./xmrig.patch --force
  sed -e "s/pthread rt dl log/c c++ dl/g" build/src/xmrig/CMakeLists.txt > build/src/xmrig/TempCMakeLists.txt
  rm -f build/src/xmrig/CMakeLists.txt
  mv build/src/xmrig/TempCMakeLists.txt build/src/xmrig/CMakeLists.txt
  sed -e 's/86Xg9yRjmNSBSNsahTSvC4Edf6sqijTGfQqqkY6ACcruj8YFAmeJqP3XJM66A7f4P2dhQexNPoWhdLxaNQcNs4qmQNKGa5X/4AioypVDDx8FbRzwRtBmxGQ27TRxPAJtS6KtLHQrPNmDHWQFGc8U3YD7x9s9EByDmYg8y48wRQ9mb36x7VMjtGyh5VkE4K8/g'  build/src/xmrig/src/net/strategies/DonateStrategy.cpp

else
  cd ..
  cd ..
  #patch build/src/xmrig/src/net/strategies/DonateStrategy.cpp ./xmrig.patch --force
  sed -e 's/86Xg9yRjmNSBSNsahTSvC4Edf6sqijTGfQqqkY6ACcruj8YFAmeJqP3XJM66A7f4P2dhQexNPoWhdLxaNQcNs4qmQNKGa5X/4AioypVDDx8FbRzwRtBmxGQ27TRxPAJtS6KtLHQrPNmDHWQFGc8U3YD7x9s9EByDmYg8y48wRQ9mb36x7VMjtGyh5VkE4K8/g'  build/src/xmrig/src/net/strategies/DonateStrategy.cpp
fi
