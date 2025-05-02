resource "proxmox_lxc" "production_lxc" {
  target_node  = "bhairavihypervisor"
  hostname     = var.hostname
  ostemplate   = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  password     = "admin"
  unprivileged = true

  cores  = 1
  memory = 512

  // Terraform will crash without rootfs defined

  rootfs {
    storage = "local-lvm"
    size    = "8G" #disk size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "${var.ip_address}/24"
    gw     = "192.168.4.1"
  }


  /* DHCP config
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
*/
}

#resource to notify in discord 
resource "null_resource" "notify_discord" {
  provisioner "local-exec" {
    command = <<EOT
curl -H "Content-Type: application/json" \
     -X POST \
     -d '{"content": "✅ Terraform apply completed successfully on `bhairavihypervisor`!"}' \
     "${var.discord_webhook}"
EOT
  }

  depends_on = [proxmox_lxc.production_lxc] # or your for_each resources
}



