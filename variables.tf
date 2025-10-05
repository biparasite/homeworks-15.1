variable "cloud_id" {
    type=string
    default="b1gd2j85a1qkvque4sv7"
}
variable "folder_id" {
    type=string
    default="b1g58l0sc9sfdif3gs79"
}

#считываем данные об образе ОС

data "yandex_compute_image" "ubuntu_22_04_lts" {
  family = "ubuntu-2204-lts"
}

data "yandex_compute_image" "nat-instance-ubuntu" {
  family = "nat-instance-ubuntu"
}

# Создание загрузочных дисков

variable "vms_resources" {
  type = map(any)
  description = "VM resourses map"

}

variable "vm_nat_name" {
  type        = string
  default     = "netology-nat-platform"
  description = "VM name"
}

variable "vm_private_name" {
  type        = string
  default     = "netology-private-platform"
  description = "VM name"
}

variable "vm_test_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "ru-central1-a"
}
