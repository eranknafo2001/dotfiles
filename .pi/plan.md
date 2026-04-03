# Plan
- [x] 1. Replace the three central registry files with true per-file flake-parts modules.
- [x] 2. Keep host composition roots as the source of truth.
- [x] 3. Convert each exported feature to a direct flake-parts file.
- [x] 4. Convert package outputs to the same pattern.
- [x] 5. Validate that host configuration definitions also follow the same rule.
- [x] 6. Delete the registry files only after the per-file version works.
- [x] 7. Validate with flake checks and builds after each batch.

If you approve, the next implementation pass should focus only on this cleanup:
- first NixOS module exports
- then Home module exports
- then Home configuration ownership per host
- then package output split
