variable "location" {
  description = "location of Resource gRoup"
  type        = string
}

variable "name" {
  description = "Name of Resource gRoup"
  type        = string

}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group."
  type        = map(string)
  default     = {}
}
