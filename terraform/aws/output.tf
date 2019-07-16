output "vpc_id" {
  value = "${aws_vpc.dotnetcore-vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.dotnetcore-subnet.id}"
}

output "loadbalancerpublic_ip" {
  value = ["${aws_instance.loadbalancer.public_ip}"]
}

output "appserver1_public_ips" {
  value = ["${aws_instance.appserver1.public_ip}"]
}

output "appserver2_public_ips" {
  value = ["${aws_instance.appserver2.public_ip}"]
}
output "database_public_ips" {
  value = ["${aws_instance.database.public_ip}"]
}