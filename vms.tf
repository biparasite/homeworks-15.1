resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  platform_id = var.vm_test_platform
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.natvm.cores
    memory        = var.vms_resources.natvm.memory
    core_fraction = var.vms_resources.natvm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-instance-ubuntu.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.netology-hw.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    ip_address = "192.168.10.254"
    nat       = true
  }

  metadata = {
  user-data          = file("./cloud-init.yml")
  serial-port-enable = 1
  }

}

### private vm
resource "yandex_compute_instance" "private-vm" {
  name        = var.vm_private_name
  platform_id = var.vm_test_platform
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.privatevm.cores
    memory        = var.vms_resources.privatevm.memory
    core_fraction = var.vms_resources.privatevm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_22_04_lts.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.netology-hw-private.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
  }

  metadata = {
  user-data          = file("./cloud-init.yml")
  serial-port-enable = 1
  }

}
