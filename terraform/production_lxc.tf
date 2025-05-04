resource "proxmox_lxc" "production_lxc" {
  target_node  = "bhairavihypervisor"
  hostname     = var.hostname
  ostemplate   = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  password     = "admin"
  unprivileged = true

  cores  = 1
  memory = 512

  rootfs {
    storage = "local-lvm"
    size    = "8G" # disk size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "${var.ip_address}/24"
    gw     = "192.168.4.1"
  }

  # If you want to keep it for reference, move the comment above it
  # /*
  # DHCP config
  # network {
  #   name   = "eth0"
  #   bridge = "vmbr0"
  #   ip     = "dhcp"
  # }
  # */
}

# ✅ Notification block is fine and will always run due to timestamp()
resource "null_resource" "notify_discord" {
  provisioner "local-exec" {
    command = <<EOT
curl -H "Content-Type: application/json" \
     -X POST \
     -d '{"content": "✅ Terraform apply completed successfully on Proxmox hypervisor!"}' \
     "${var.discord_webhook}"
EOT
  }

  triggers = {
    always_run = timestamp()
  }

  # Optional: add depends_on if you want to run *after* the LXC is created
  depends_on = [proxmox_lxc.production_lxc]
}
