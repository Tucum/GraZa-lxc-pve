## Requirements

Before using the `install-zerotier-debian12.sh` script, ensure:

1. A **ZeroTier account** created on the ZeroTier platform.
2. A **ZeroTier network** created on the platform, so you can insert its **Network ID** into the script.

If you are installing ZeroTier in a Proxmox LXC container, ensure:
1. A Proxmox LXC container that is **PRIVILEGED**.
2. If the container is not yet privileged, you can create a backup and restore it by selecting the “Restore as privileged container”
3. You have edited the container's .conf file in /etc/pve/lxc/ and added the following lines:
```bash
lxc.cgroup2.devices.allow = c 10:200 rwm
lxc.hook.autodev = sh -c "modprobe tun; cd ${LXC_ROOTFS_MOUNT}/dev; mkdir net; mknod net/tun c 10 200; chmod 0666 net/tun"
```
## References
The solution to make ZeroTier work correctly in Proxmox LXC containers was found on the Level1Techs forum:
- [ZeroTier in LXC (Proxmox) – Level1Techs Forums](https://forum.level1techs.com/t/zerotier-in-lxc-proxmox/155515/11)
