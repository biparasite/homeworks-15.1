resource "yandex_vpc_network" "netology-hw" {
  name = "netology-hw"
}

#создаем подсеть public zone A

resource "yandex_vpc_subnet" "netology-hw" {
  name           = "public"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-hw.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

#создаем подсеть private zone A

resource "yandex_vpc_subnet" "netology-hw-private" {
  name           = "private"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-hw.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Создание ACL

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = "nat-instance-sg"
  network_id = yandex_vpc_network.netology-hw.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ANY"
    description    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Создание таблицы маршрутизации и статического маршрута

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.netology-hw.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}