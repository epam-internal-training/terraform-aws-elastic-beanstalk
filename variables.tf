variable "application_name" {
  description = "Name of the application."
  type        = string
}

variable "environment_name" {
  description = "A unique name for this Environment."
  type        = string
}

variable "solution_stack_name" {
  description = "A solution stack to base your environment."
  type        = string
  default     = null
}

variable "tier" {
  description = "Elastic Beanstalk Environment tier."
  type        = string
  default     = null
}

variable "tags" {
  type    = object({})
  default = {}
}

variable "settings" {
  description = "Settings to configure the new Environment."
  type        = list(map(string))
}