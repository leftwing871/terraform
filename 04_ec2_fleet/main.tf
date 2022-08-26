
# EC2 Instance
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.aws_security_group_ids
  subnet_id              = var.instance_subnet_id
  iam_instance_profile = var.iam_instance_profile
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Welcome to Terraform Workshop &#128075;</h1>" | sudo tee /var/www/html/index.html
EOF

  tags = {
    Name = "${var.tags}-ec2"
  }
}
