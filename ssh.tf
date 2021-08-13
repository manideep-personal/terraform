
output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.test-ec2-instance.public_ip
}

resource "aws_key_pair" "github" {
  key_name   = "github"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjvc+nzlG2d8+1y2aCfUagpdgYCwr4Ftxt7p9gEMrZN4USxxrUpHfaqsOke1tPjgYVnScSq1gCw80ubvX13ICcptJV7dyCgmp8FGnqlKce39w/Cehn0USjeDr9QZsGth6FDDYW3PTN7g81+9Rs/gIfHsb8TV6grvB2OUqyNkq9F4FlKwhhjWo0FlT9ptRbATD1zkzIoP3Jg4UDZKBpFJ8wDJxJtftaoyOYk+JE+g78Q0IiTHqfaucczbGTCIottvLG7jmPteYTso6wjykQpmJsJOMNrl7V23JC0gAIcimjd+xjQVXD32Ugm6YSdTTG8v/Wv/Js1iPLhj92lvnE5OmV sanjay@DESKTOP-I89FM8U"
}
