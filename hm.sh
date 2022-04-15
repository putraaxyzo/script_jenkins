#!/bin/bash
# Let's get started
mkdir awaken #create your dir rom
cd awaken 
git config --global user.name putraaxyzo
git config --global user.email wibowoyunantosrisaputra@gmail.com
# Build Script


git clone https://github.com/putraaxyzo/android_device_xiaomi_ginkgo -b awaken device/xiaomi/ginkgo
git clone https://github.com/putraaxyzo/android_vendor_ginkgo -b 12.1 vendor/xiaomi/ginkgo
git clone --depth=1 https://github.com/fiqri19102002/android_kernel_xiaomi_ginkgo -b inline-rom kernel/xiaomi/ginkgo
git clone --depth=1 https://github.com/ThankYouMario/proprietary_vendor_qcom_sdclang -b ruby-12 prebuilts/clang/host/linux-x86/clang-sdllvm
#kalau mau pake micam, hapus # di bawah ini, kalau gak mau, yaudah
#git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera && cd f*/av && git fetch https://github.com/PixelOS-Pixelish/frameworks_av twelve-cam && git cherry-pick a2f7b6b0c385038a46b8eca763d9e91fd1a15e1f && git cherry-pick 53f3edd0f004b475a237605220a3abf5daf6ee3d && cd .. && cd base && git fetch https://github.com/PixelOS-Pixelish/frameworks_base twelve-old && git cherry-pick 97be12cd32c0fb8aefc6bb92b869a2e28655c18d && cd ../../
rm -rf hardware/qcom-caf/sm8150/audio && rm -rf hardware/qcom-caf/sm8150/media && rm -rf hardware/qcom-caf/sm8150/display && git clone https://github.com/ArrowOS/android_hardware_qcom_audio.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/audio && git clone https://github.com/ArrowOS/android_hardware_qcom_media.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/media && git clone https://github.com/ArrowOS/android_hardware_qcom_display.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/display
#Mulai build ROM 
. build/envsetup.sh
lunch awaken_ginkgo-userdebug
sudo mkdir /ccache 
mkdir tempcc
sudo umount /ccache
sudo chmod 777 /ccache
sudo mount --bind $PWD/tempcc /ccache
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=/ccache
ccache -M 100G -F 0
make bacon -j20 
ls out/target/product/ginkgo/awaken
