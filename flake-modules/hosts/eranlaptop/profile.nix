{...}: {
  flake.nixosModules.eranlaptop-profile = {
    my.hyprland = {
      nvidia = false;
      battery = true;
      asus-nmcli-fix = true;
      monitors = [
        {
          name = "eDP-1";
          position = "0x0";
          resolution = "preferred";
          scale = 1.25;
        }
      ];
    };

    my.hibernation = {
      resumeDevice = "/dev/nvme0n1p3";
      laptop = true;
    };
  };

  flake.homeModules.eranlaptop-home-profile = {
    my.hyprland = {
      nvidia = false;
      battery = true;
      asus-nmcli-fix = true;
      monitors = [
        {
          name = "eDP-1";
          position = "0x0";
          resolution = "preferred";
          scale = 1.25;
        }
      ];
    };

    my.btca.repos = [
      {
        name = "iced";
        url = "https://github.com/iced-rs/iced";
        branch = "latest";
        specialNotes = "Iced is a cross-platform GUI library for Rust. Use this repo to answer questions about Iced development patterns, widget usage, and Rust GUI programming.";
      }
      {
        name = "svelte";
        url = "https://github.com/sveltejs/svelte.dev";
        branch = "main";
        specialNotes = "This is the svelte docs website repo, not the actual svelte repo. Use the docs to answer questions about svelte.";
      }
      {
        name = "tailwindcss";
        url = "https://github.com/tailwindlabs/tailwindcss.com";
        branch = "main";
        specialNotes = "This is the tailwindcss docs website repo, not the actual tailwindcss repo. Use the docs to answer questions about tailwindcss.";
      }
      {
        name = "nextjs";
        url = "https://github.com/vercel/next.js";
        branch = "canary";
        specialNotes = "Next.js is a React framework for full-stack web development. Use this repo for questions about Next.js features, routing, server components, and deployment patterns.";
      }
    ];
  };
}
