#!/bin/bash

# main VM create
virt-install --name=sterra_hub \
    --connect=qemu:///system \
    --memory 512,maxmemory=1024 \
    --vcpus=1 \
    --import --disk path=iso/sterragate_hub.qcow2,format=qcow2,bus=virtio \
    --vnc \
    --noautoconsole \
    --os-type=linux \
    --accelerate \
    --network=bridge:br0,model=virtio \
    --network=bridge:br1,model=virtio \
    --network=bridge:br2,model=virtio #\
    #--network=bridge:br_client1,model=virtio
# spoke1 create
virt-install --name=sterra_spoke1 \
    --connect=qemu:///system \
    --memory 512,maxmemory=1024 \
    --vcpus=1 \
    --import --disk path=iso/sterragate_spoke1.qcow2,format=qcow2,bus=virtio \
    --vnc \
    --noautoconsole \
    --os-type=linux \
    --accelerate \
    --network=bridge:br0,model=virtio \
    --network=bridge:br1,model=virtio \
    --network=bridge:br_client2,model=virtio
# spoke2 create
virt-install --name=sterra_spoke2 \
    --connect=qemu:///system \
    --memory 512,maxmemory=1024 \
    --vcpus=1 \
    --import --disk path=iso/sterragate_spoke2.qcow2,format=qcow2,bus=virtio \
    --vnc \
    --noautoconsole \
    --os-type=linux \
    --accelerate \
    --network=bridge:br0,model=virtio \
    --network=bridge:br2,model=virtio \
    --network=bridge:br_client3,model=virtio
