variable "hostname" {}
variable "ip_address" {
  type = string
}


#discord notifications

variable "discord_webhook" {
  description = "https://discordapp.com/api/webhooks/1367967683617886208/0uatkPCBQrjrIvGErc6l0lNXhoysLOfR7Kwcf7shEL80s0dyvZvTDcOHUO8jYrzh9hA6"
  type        = string
}
