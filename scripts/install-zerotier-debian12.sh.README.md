# Proxmox LXC containers must be PRIVILEGED for ZeroTier to function correctly

# Edit the container's .conf file in /etc/pve/lxc/ and add the following lines:
lxc.cgroup2.devices.allow = c 10:200 rwm
lxc.hook.autodev = sh -c "modprobe tun; cd ${LXC_ROOTFS_MOUNT}/dev; mkdir net; mknod net/tun c 10 200; chmod 0666 net/tun"

## References
The solution to make ZeroTier work correctly in Proxmox LXC containers was found on the Level1Techs forum:
- [ZeroTier in LXC (Proxmox) – Level1Techs Forums](https://forum.level1techs.com/t/zerotier-in-lxc-proxmox/155515/11)
