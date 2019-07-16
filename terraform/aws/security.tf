resource "aws_security_group" "dotnetcore" {
  name        = "dotnetcore-${random_id.instance_id.hex}"
  description = "Security group for dotnetcore demo for Windows"
  vpc_id      = "${aws_vpc.dotnetcore-vpc.id}"

  tags {
    Name          = "${var.tag_customer}-${var.tag_project}-${random_id.instance_id.hex}-${var.tag_application}-security_group"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }
}
//////////////////////////
// General Rules

# HTTP in
resource "aws_security_group_rule" "ingress_http_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

# HTTPS in

resource "aws_security_group_rule" "ingress_https_all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

# App in

resource "aws_security_group_rule" "ingress_nopcommerce_all" {
  type              = "ingress"
  from_port         = 8090
  to_port           = 8090
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}
/////////////////////
// Habitat Rules

resource "aws_security_group_rule" "ingress_hab_sup_all_udp" {
  type              = "ingress"
  from_port         = 9638
  to_port           = 9638
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

resource "aws_security_group_rule" "ingress_hab_sup_all_tcp" {
  type              = "ingress"
  from_port         = 9631
  to_port           = 9638
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

//////////////////////////
// Linux Rules
resource "aws_security_group_rule" "ingress_ssh_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

//////////////////////////
// Base Windows Rules
# RDP - all
resource "aws_security_group_rule" "ingress_rdp_all" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

# WinRM - all
resource "aws_security_group_rule" "ingress_winrm_all" {
  type              = "ingress"
  from_port         = 5985
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

# SQLServer - all
resource "aws_security_group_rule" "ingress_sqlserver_all" {
  type              = "ingress"
  from_port         = 8888
  to_port           = 8888
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}

# Outbound All

resource "aws_security_group_rule" "windows_egress_allow_0-65535_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dotnetcore.id}"
}
