{ ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.llama-cpp = {
      image = "ghcr.io/ggml-org/llama.cpp:server-cuda";
      autoStart = true;
      volumes = [
        "/var/lib/llama-cpp:/root/.cache/llama.cpp"
      ];

      cmd = [
        "-hf" "unsloth/Qwen3.8-27B-GGUF:UD-Q4_K_M"
        "-c" "32768"
        "-ngl" "24"
        "-fa" "on"
        "--jinja"
        "--host" "0.0.0.0"
        "--port" "8080"
      ];
      extraOptions = [
        "--network=host"
        "--device=nvidia.com/gpu=all"
      ];
    };
  };
}
