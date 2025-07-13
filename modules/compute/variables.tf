variable "instance" {
     description = "Name of the instance machine"
     type = string
     default = "default"
  
}
variable "machine_type" {
    description = "machine type of compute engine"
    type = string
    validation {
      condition = contains(["n2-standard-2"], var.machine_type)
      error_message= "please use n2-standard-2 only"
    }
  
  
}
variable "my_label" {
  description ="boot disk arg"
  type=string
  default="testing-disk"
}
variable "region"{
description="region of the resource/prject"
type=string
}

variable "zone"{
description="zone within the region"
type=string

}