{...}: {
  programs.btop = {
    enable = true;
    settings = {
      # Color theme and appearance
      color_theme = "Default";
      theme_background = false;
      truecolor = true;
      force_tty = false;
      rounded_corners = true;

      # Graph and display settings
      graph_symbol = "braille";
      shown_boxes = "cpu mem net proc";
      update_ms = 2000;

      # Process settings
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = true;
      proc_per_core = false;
      proc_mem_bytes = true;

      # CPU settings
      cpu_graph_upper = "total";
      cpu_graph_lower = "total";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = true;
      temp_scale = "celsius";
      show_cpu_freq = true;

      # Memory settings
      mem_graphs = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;

      # Network settings
      net_download = "10M";
      net_upload = "10M";
      net_auto = true;
      net_sync = false;
      net_color_fixed = false;
      net_iface = "";

      # Battery and misc
      show_battery = true;
      show_init = false;
      update_check = true;
      log_level = "WARNING";

      # Clock format
      draw_clock = "%X";
      background_update = true;

      # Custom names (empty to use defaults)
      custom_cpu_name = "";
      disks_filter = "";
    };
  };

  # Note: Locale environment variables moved to ghostty.nix for proper inheritance
}
