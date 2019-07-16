data "template_file" "sup_service" {
  template = "${file("${path.module}/templates/hab-sup.service")}"

  vars {
    flags = "--auto-update --listen-gossip 0.0.0.0:9638 --listen-http 0.0.0.0:9631"
  }
}

data "template_file" "install_hab" {
  template = "${file("${path.module}/templates/install-hab.sh")}"
}
 
 resource "aws_instance" "loadbalancer" {
    connection {
    user        = "${var.aws_centos_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
    }

  ami                         = "${data.aws_ami.centos.id}"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.dotnetcore-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.dotnetcore.id}"]
  associate_public_ip_address = true
  
  tags {
    Name          = "${var.tag_contact}-${var.tag_customer}-loadbalancer"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.sup_service.rendered}"
    destination = "/home/centos/hab-sup.service"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /etc/machine-id",
      "sudo systemd-machine-id-setup",
      "sudo hostname aws-centos7",
      "sudo groupadd hab",
      "sudo adduser hab -g hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/centos/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
      "sleep 60",
      "sudo hab svc load core/haproxy --bind backend:nop-commerce.default --channel stable --strategy at-once"
    ]
  }
}
