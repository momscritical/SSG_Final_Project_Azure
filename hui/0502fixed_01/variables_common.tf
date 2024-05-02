variable "preshared_key" {
    type = list(string)
    description = "the key of the preshared key for peering"
    default = ["always_sleepy_0529", "sleepy_always_0529"]
}
variable "ssh_public_key" {
    default = "~/.ssh/final-key.pub"
}