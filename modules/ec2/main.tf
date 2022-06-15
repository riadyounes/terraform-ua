resource "aws_instance" "backend" {
  ami           = var.ami
  instance_type = var.instance_type
}
