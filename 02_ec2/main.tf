# EC2 Security Group
resource "aws_security_group" "ec2" {
  name     = "${var.tags}-sg"
  vpc_id = var.vpc_id

  ingress {
    description      = "ingress from Load Balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups      = [ aws_security_group.alb.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.tags}-sg"
  }
}

# EC2 Instance
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2.id]
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

# Load Balancer
resource "aws_lb" "alb" {
  name                       = "${var.tags}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets = var.pulbic_subnets

  tags = {
    Name = "${var.tags}-alb"
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}

# Load Balancer Security Group
resource "aws_security_group" "alb" {
  name     = "${var.tags}-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    description      = "ingress from Local IP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.tags}-alb-sg"
  }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "alb" {
  name                 = "${var.tags}-albtg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  tags = {
    Name = "${var.tags}-albtg"
  }
}

# Load Balancer Target Group 
resource "aws_lb_target_group_attachment" "alb" {
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_instance.this.id
  port             = 80
}