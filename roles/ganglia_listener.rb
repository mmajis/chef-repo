name "ganglia_listener"
description "Ganglia listener receives monitoring data and has gmetad and ganglia web interface"
run_list(
  #"recipe[build-essential]",
  "recipe[testapp::ganglia-listener]",
  "recipe[testapp::ganglia-web]"
)
default_attributes(
  :ganglia => {
    :mute => "yes",
    :deaf => "no"
  }
)