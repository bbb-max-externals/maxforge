# Audio output tester

`audio-tester.maxdsl` generates the complete dark Presentation UI, signal
routing, and sixteen output strips without JSON post-processing or custom
object metadata.

```sh
npm run build
node dist/cli/index.js compile examples/audio-tester/audio-tester.maxdsl -o examples/audio-tester/audio-tester.maxpat
```

Open the generated patch in Max. Startup selects pink noise at -20 dB, sets
every output trim to -100 dB (silence), and leaves OUTPUT off. DSP is controlled
separately; opening the patch does not turn it on. Each trim has a 20 ms ramp.
Solo enables the selected channels; several Solo buttons can be active. Mute
takes priority, including on a soloed channel.

Change `const channels = 16` to `8` to generate eight instances of the same
strip. The supported range is 1..16. The DAC and Solo aggregator remain sixteen
channels wide; unused DAC inputs are silent and unused Solo inputs stay zero.
Edit `strip_width`, `strip_gap`, styles, and the two instance origins to change
the UI without renaming boxes. Patching and Presentation coordinates are
independent.

The root `patcher` directive configures file output. Remove that directive for
managed plan/live compilation; it cannot edit the Max window settings. Keep
this authored source separately before adopting live edits, since decompilation
and adoption flatten templates/styles into explicit objects and attributes.

See [UI templates and styles](../../docs/ui-templates.md) for syntax and limits.
