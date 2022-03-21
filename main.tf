provider "nomad" {
  address = "http://localhost:4646"
}

resource "nomad_job" "whoami" {
  jobspec = data.template_file.whoami_job.rendered
}

data "template_file" "whoami_job" {
  template = file("${path.module}/whoami.nomad.tpl.hcl")
}