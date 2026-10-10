# Maxforge repository agent rules

## Live control and installation

- Use `maxforge` for offline DSL work and `maxforge-live` for live HTTP control
  or requested package setup/migration.
- Discover the Max-owned service and its action schemas. Require a supported
  API version and `versionCompatible: true` for the selected registered patch.
- Live status and registration identify the loaded native external; filesystem
  metadata alone does not prove which package Max loaded.
- The native external and bundled service are one distribution. Replace the
  complete Max package only for an authorized install/update, with Max closed
  after the user has saved their work. Never replace only the external binary.
- Skills and the optional HTTP client do not need an exact npm/native version
  match. Do not restore MCP, detached brokers, or automatic skill updates.
- A missing connection or discovered update does not authorize installation.
  Follow the live skill's setup reference for scoped legacy-skill removal.
- Preserve upstream DSL, editing, and release-contract regressions when changing
  transport. Never move an existing release tag or publish without authorization.
