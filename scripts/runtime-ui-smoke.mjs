#!/usr/bin/env node
// Explicit, destructive-to-fixture-only host test; never targets a user's patch.
import assert from 'node:assert/strict';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { resolve, join } from 'node:path';
import { discoverServices } from '../dist/live/discovery.js';

const [phase, directory] = process.argv.slice(2);
assert(directory, 'Usage: node scripts/runtime-ui-smoke.mjs generate|probe|check|managed|reopen DIRECTORY');
const root = resolve(directory);
const scope = 'runtimeqa';
// Port metadata checked against Max's bundled reference/help patches. No DSP sink.
const cases = [
  ['number', 1, ['', 'bang']], ['flonum', 1, ['', 'bang']],
  ['button', 1, ['bang']], ['toggle', 1, ['int']],
  ['textbutton', 1, ['', '', 'int'], { mode: 1, text: 'off', texton: 'on' }],
  ['slider', 1, ['']], ['dial', 1, ['float']],
  ['rslider', 2, ['', '']], ['pictslider', 2, ['int', 'int']],
  ['multislider', 1, ['', ''], { size: 3, setminmax: [0, 127] }],
  ['kslider', 2, ['int', 'int']],
  ['umenu', 1, ['int', '', ''], { items: ['one', ',', 'two', ',', 'three'] }],
  ['tab', 1, ['int', '', ''], { tabs: ['one', 'two', 'three'] }],
  ['radiogroup', 1, [''], { size: 3 }],
  ['matrixctrl', 1, ['list', 'list'], { columns: 3, rows: 2, range: 2 }],
  ['message', 2, [''], { text: '41 42' }],
  ['gain~', 2, ['signal', '']], ['pictctrl', 1, ['int']],
  ['incdec', 1, ['float']], ['live.button', 1, ['']],
  ['live.toggle', 1, ['']], ['live.text', 1, ['', ''], { mode: 1, text: 'off', texton: 'on' }],
  ['live.dial', 1, ['', 'float']], ['live.slider', 1, ['', 'float']],
  ['live.numbox', 1, ['', 'float']],
  ['live.menu', 1, ['', '', 'float']], ['live.tab', 1, ['', '', 'float']],
  ['live.gain~', 2, ['signal', 'signal', '', 'float', 'list']],
  ['radiogroup', 1, [''], { size: 3, itemtype: 1, flagmode: 0 }],
  ['radiogroup', 1, [''], { size: 3, itemtype: 1, flagmode: 1 }],
  ['textbutton', 1, ['', '', 'int'], { mode: 0 }],
  ['live.text', 1, ['', ''], { mode: 0 }],
];
const base = () => ({ fileversion: 1, appversion: { major: 9, minor: 0, revision: 0,
  architecture: 'x64', modernui: 1 }, classnamespace: 'box', rect: [100, 100, 1000, 700],
  default_fontsize: 12, default_fontname: 'Arial', boxes: [], lines: [] });
function box(patcher, maxclass, name, inlets, outlets, x, y, attrs = {}) {
  const id = `obj-${patcher.boxes.length + 1}`;
  patcher.boxes.push({ box: { id, maxclass, varname: name, numinlets: inlets,
    numoutlets: outlets.length, outlettype: outlets, patching_rect: [x, y, 90, 24], ...attrs } });
  return id;
}
function wire(patcher, source, outlet, destination, inlet = 0) {
  patcher.lines.push({ patchline: { source: [source, outlet], destination: [destination, inlet] } });
}
function fixture(patcherId) {
  const patcher = base();
  box(patcher, 'newobj', 'bridge', 1, [''], 40, 30,
    { text: `maxforge @patcher_id ${patcherId} @scope ${scope}` });
  for (const [index, [name, inlets, outlets, attrs = {}]] of cases.entries()) {
    const child = base();
    const live = name.startsWith('live.');
    const parameters = live ? { parameter_enable: 1, saved_attribute_attributes: { valueof: {
      parameter_longname: name, parameter_shortname: name,
      parameter_type: ['live.menu', 'live.tab', 'live.toggle', 'live.text', 'live.button'].includes(name) ? 2 : 0,
      parameter_mmin: 0, parameter_mmax: name === 'live.gain~' ? 6 :
        ['live.menu', 'live.tab'].includes(name) ? 2 :
        ['live.button', 'live.toggle', 'live.text'].includes(name) ? 1 : 127,
      parameter_enum: ['off', 'on', 'third'],
    } } } : {};
    const subject = box(child, name, 'subject', inlets, outlets, 40, 40, { ...parameters, ...attrs });
    outlets.forEach((type, outlet) => {
      if (type === 'signal') return;
      const x = 40 + outlet * 190;
      const trigger = box(child, 'newobj', `trigger_${outlet}`, 1, ['bang'], x, 130, { text: 't b' });
      const counter = box(child, 'newobj', `counter_${outlet}`, 5, ['int', '', '', 'int'], x, 180,
        { text: 'counter 1 1000000' });
      const count = box(child, 'number', `count_${outlet}`, 1, ['', 'bang'], x, 230);
      wire(child, subject, outlet, trigger); wire(child, trigger, 0, counter); wire(child, counter, 0, count);
      const unpack = box(child, 'newobj', `unpack_${outlet}`, 1, ['float', 'float', 'float', 'float'], x, 300,
        { text: 'unpack 0. 0. 0. 0.' });
      wire(child, subject, outlet, unpack);
      for (let atom = 0; atom < 4; atom++) {
        const value = box(child, 'flonum', `value_${outlet}_${atom}`, 1, ['', 'bang'], x, 350 + atom * 45);
        wire(child, unpack, atom, value);
      }
    });
    box(patcher, 'newobj', `case_${index}`, 0, [], 40 + (index % 5) * 185,
      100 + Math.floor(index / 5) * 65, { text: `p ${name}`, patcher: child });
  }
  return { patcher };
}

if (phase === 'generate') {
  await mkdir(root, { recursive: true });
  for (const suffix of ['a', 'b']) {
    await writeFile(join(root, `runtime-${suffix}.maxpat`), JSON.stringify(fixture(`runtime_qa_${suffix}`), null, 2), { flag: 'wx' });
  }
  console.log(`Generated isolated fixtures in ${root}`);
  process.exit(0);
}
const services = await discoverServices();
assert.equal(services.length, 1, 'Select exactly one live Max process for this test');
const service = services[0];
assert.equal(service.apiVersion, 1);
const expectedVersion = JSON.parse(await readFile(new URL('../package.json', import.meta.url), 'utf8')).version;
assert.equal(service.version, expectedVersion, 'Loaded package is not the candidate being tested');
const headers = { Authorization: `Bearer ${service.token}`, 'Content-Type': 'application/json' };
const url = `http://127.0.0.1:${service.port}`;
const tools = await (await fetch(`${url}/v1/tools`, { headers })).json();
for (const action of ['maxforge_read_runtime', 'maxforge_send_message', 'maxforge_inspect_patch']) {
  assert(tools.tools.some(tool => tool.name === action), `Missing ${action}`);
}
async function call(action, args) {
  const response = await fetch(`${url}/v1/tools/${action}`, { method: 'POST', headers, body: JSON.stringify(args) });
  const result = await response.json();
  assert(response.ok && !result.isError, JSON.stringify(result));
  return result.structuredContent;
}
async function rejects(action, args, code) {
  const response = await fetch(`${url}/v1/tools/${action}`, { method: 'POST', headers, body: JSON.stringify(args) });
  const failure = await response.json();
  assert(failure.isError || !response.ok);
  const details = failure.structuredContent ?? failure;
  assert.equal(details.code, code);
  assert.equal(details.execution, 'not_executed');
}
const patches = (await call('maxforge_list_patches', {})).patches;
if (phase === 'managed' || phase === 'reopen') {
  await testManaged();
  process.exit(0);
}
const patch = patches.find(p => p.patcherId === 'runtime_qa_a' && p.scope === scope);
assert(patch?.versionCompatible && patch.capabilities.includes('runtime_ui_v1'), 'Missing compatible fixture');
const routing = { patcherId: patch.patcherId, scope };
const inspected = await call('maxforge_inspect_patch', { ...routing, detail: 'full' });
await writeFile(join(root, 'inspection.json'), JSON.stringify(inspected, null, 2));
function request(target, message) {
  return { ...routing, instanceId: patch.instanceId, expectedStructureToken: inspected.structureToken,
    target: { targetPath: target.targetPath, runtimeId: target.runtimeId, varName: target.varName, maxclass: target.maxclass },
    allowUnmanaged: true, ...(message ? { message } : {}) };
}
function allBoxes(patcher) {
  return patcher.boxes.flatMap(b => [b, ...(b.subpatcher ? allBoxes(b.subpatcher) : [])]);
}
const boxes = allBoxes(inspected.snapshot.patcher);
const results = [];
const other = patches.find(p => p.patcherId === 'runtime_qa_b' && p.scope === scope);
if (phase === 'check') assert(other?.versionCompatible, 'Open both generated fixtures');
const otherRouting = other && { patcherId: other.patcherId, scope, instanceId: other.instanceId };
const otherInspection = other && await call('maxforge_inspect_patch', { ...otherRouting, detail: 'full' });
for (const [index, [name, , , attrs = {}]] of cases.entries()) {
  const target = boxes.find(b => b.varName === 'subject' && b.targetPath.at(-1) === `case_${index}`);
  assert(target, `Missing inspected ${name}`);
  const result = await call('maxforge_read_runtime', request(target));
  const otherBox = otherInspection?.snapshot.patcher.boxes.find(b => b.varName === 'subject' && b.targetPath.at(-1) === `case_${index}`);
  const otherArgs = box => ({ ...request(box), ...otherRouting, expectedStructureToken: otherInspection.structureToken });
  const otherBefore = otherBox && await call('maxforge_read_runtime', otherArgs(otherBox));
  results.push({ name, result });
  console.log(name, JSON.stringify(result.state));
  if (phase === 'check' || phase === 'exercise') {
    await rejects('maxforge_read_runtime', { ...request(target), allowUnmanaged: false }, 'UNMANAGED_TARGET');
    if (name === 'matrixctrl') await rejects('maxforge_send_message', request(target, { selector: 'set', atoms: [3, 0, 1] }), 'INVALID_ARGUMENT');
    if (name === 'multislider') await rejects('maxforge_send_message', request(target, { selector: 'list', atoms: [1, 2] }), 'INVALID_ARGUMENT');
    if (['textbutton', 'live.text'].includes(name) && attrs.mode === 0) {
      await rejects('maxforge_send_message', request(target, { selector: 'set', atoms: [1] }), 'UNSUPPORTED_MODE');
    }
    const read = async box => (await call('maxforge_read_runtime', request(box))).state.values;
    const readCounts = async () => { const values = []; for (const counter of counters) values.push(await read(counter)); return values; };
    const counters = boxes.filter(b => b.varName.startsWith('count_') && b.targetPath.at(-1) === `case_${index}`)
      .sort((a, b) => a.varName.localeCompare(b.varName));
    const countsBeforeRead = await readCounts();
    for (let repeat = 0; repeat < 3; repeat++) await call('maxforge_read_runtime', request(target));
    assert.deepEqual(await readCounts(), countsBeforeRead, `${name}: read fired an outlet`);
    const commands = name === 'message' ? [['bang', []]]
      : name === 'button' || name === 'live.button' ? [['bang', []], ['int', [1]], ['float', [1]], ['list', ['test', 1]]]
      : ['textbutton', 'live.text'].includes(name) && attrs.mode === 0 ? [['bang', []], ['int', [1]], ['float', [0]]]
      : ['textbutton', 'live.text'].includes(name) ? [['set', [0]], ['int', [1]], ['float', [0]], ['symbol', ['on']], ['setsymbol', ['off']], ['bang', []]]
      : name === 'radiogroup' && attrs.itemtype === 1 && !attrs.flagmode ? [['set', [0, 1, 0]], ['list', [1, 0, 1]], ['bang', []]]
      : name === 'radiogroup' ? [['set', [0]], ['int', [1]], ['bang', []]]
      : name === 'multislider' ? [['setlist', [10, 20, 30]], ['list', [30, 40, 50]], ['set', [2, 60]], ['bang', []]]
      : name === 'rslider' || name === 'pictslider' ? [['set', [10, 20]], ['list', [30, 40]], ['bang', []]]
      : name === 'matrixctrl' ? [['set', [1, 1, 1]], ['list', [2, 1, 1]], ['bang', []], ['clear', []]]
      : name === 'kslider' ? [['set', [60]], ['int', [61]], ['bang', []], ['clear', []]]
      : name === 'incdec' ? [['set', [10]], ['int', [20]], ['inc', []], ['dec', []], ['bang', []]]
      : [['set', [0]], ['int', [1]], ['float', [name === 'flonum' ? 0.25 : 0]], ['bang', []]];
    for (const [selector, atoms] of commands) {
      const before = await readCounts();
      try {
        const sent = await call('maxforge_send_message', request(target, { selector, atoms }));
        await new Promise(resolve => setTimeout(resolve, 150));
        const after = await readCounts();
        const entry = { selector, atoms, state: sent.state, counts: after.map((v, i) => v[0] - before[i][0]) };
        assert.equal(sent.execution, 'completed');
        assert.equal(sent.managed, false);
        const silent = ['set', 'setlist', 'setsymbol'].includes(selector) ||
          (name === 'incdec' && ['int', 'float'].includes(selector)) || (name === 'kslider' && selector === 'clear') ||
          (name === 'live.text' && attrs.mode === 0 && ['int', 'float'].includes(selector) && atoms[0] === 0);
        if (silent) assert(entry.counts.every(n => n === 0), `${name} ${selector}: unexpectedly output`);
        else if (phase === 'check') assert(entry.counts.some(n => n > 0), `${name} ${selector}: missing output`);
        if (name === 'flonum' && selector === 'float') assert.deepEqual(sent.state.values, [0.25]);
        if (otherInspection) {
          const otherState = await call('maxforge_read_runtime', otherArgs(otherBox));
          assert.equal(otherState.managed, false);
          assert.deepEqual(otherState.state, otherBefore.state, 'Runtime value leaked to another patch');
          const otherCounters = otherInspection.snapshot.patcher.boxes.filter(b => b.varName.startsWith('count_') && b.targetPath.at(-1) === `case_${index}`);
          for (const counter of otherCounters) {
            const value = await call('maxforge_read_runtime', { ...request(counter), ...otherRouting, expectedStructureToken: otherInspection.structureToken });
            assert.deepEqual(value.state.values, [0], 'Message leaked to another patch');
          }
        }
        results.push({ name, ...entry });
        console.log(' ', JSON.stringify(entry));
      } catch (error) {
        results.push({ name, selector, error: error.message });
        await writeFile(join(root, 'failed-check.json'), JSON.stringify(results, null, 2));
        throw error;
      }
    }
    const after = await call('maxforge_inspect_patch', { ...routing, detail: 'full' });
    assert.equal(after.structureToken, inspected.structureToken, `${name} changed structure`);
    assert.equal(after.revision, inspected.revision);
  }
}
await writeFile(join(root, 'probe.json'), JSON.stringify(results, null, 2));
assert(['probe', 'exercise', 'check'].includes(phase), 'Unknown phase');
console.log(`PASS: ${cases.length} UI configurations, ${results.length - cases.length} messages`);

async function testManaged() {
  const source = 'input_value = number at(80, 100)\nadd_offset = + 1 at(80, 160)\noutput_value = flonum at(80, 220)\ninput_value -> add_offset -> output_value\n' +
    'nested = p nested {\n  input_value = number at(80, 100)\n  result = outlet at(80, 160)\n  input_value -> result\n}\n';
  const route = { patcherId: 'runtime_managed_a', scope: 'runtimecore' };
  let targetPatch = patches.find(p => p.patcherId === route.patcherId);
  if (phase === 'managed') {
    assert(!targetPatch, 'Dedicated managed fixture already exists; do not overwrite');
    targetPatch = (await call('maxforge_create_patch', { ...route, title: 'Runtime managed acceptance' })).patch;
    const initial = await call('maxforge_inspect_patch', { ...route, detail: 'full' });
    const preview = await call('maxforge_prepare_change', { ...route, expectedStructureToken: initial.structureToken, desiredDsl: source });
    assert(preview.canApply && preview.operationCounts.delete === 0 && preview.operationCounts.disconnect === 0);
    const applied = await call('maxforge_apply_prepared_change', { receiptId: preview.receiptId });
    await writeFile(join(root, 'managed-apply.json'), JSON.stringify(applied, null, 2));
    assert(applied.statePersisted && applied.baselineCaptured);
    assert.equal(applied.acknowledgement.revision, applied.targetRevision);
  }
  assert(targetPatch?.versionCompatible);
  const inspection = await call('maxforge_inspect_patch', { ...route, detail: 'full' });
  await writeFile(join(root, 'managed-inspection.json'), JSON.stringify(inspection, null, 2));
  const targets = inspection.snapshot.patcher.boxes;
  const input = targets.find(b => b.varName.endsWith('_input_value') && b.targetPath.length === 0);
  const output = targets.find(b => b.varName.endsWith('_output_value'));
  const nested = targets.find(b => b.varName.endsWith('_input_value') && b.targetPath.length === 1);
  assert(input && output && nested);
  const args = (box, message) => ({ ...route, instanceId: targetPatch.instanceId,
    expectedStructureToken: inspection.structureToken,
    target: { targetPath: box.targetPath, runtimeId: box.runtimeId, varName: box.varName, maxclass: box.maxclass },
    ...(message ? { message } : {}) });
  const read = async box => (await call('maxforge_read_runtime', args(box))).state.values;
  if (phase === 'managed') {
    const nestedBefore = await read(nested);
    await call('maxforge_send_message', args(input, { selector: 'int', atoms: [42] }));
    await new Promise(resolve => setTimeout(resolve, 150));
    await writeFile(join(root, 'managed-after-input.json'), JSON.stringify(await call('maxforge_inspect_patch', { ...route, detail: 'full' }), null, 2));
    assert.deepEqual(await read(input), [42]);
    assert.deepEqual(await read(output), [43]);
    await call('maxforge_send_message', args(input, { selector: 'set', atoms: [10] }));
    await new Promise(resolve => setTimeout(resolve, 150));
    assert.deepEqual(await read(input), [10]);
    assert.deepEqual(await read(output), [43], 'set emitted downstream');
    assert.deepEqual(await read(nested), nestedBefore, 'Wrong subpatch received input');
    await call('maxforge_send_message', args(nested, { selector: 'int', atoms: [99] }));
    await new Promise(resolve => setTimeout(resolve, 150));
    assert.deepEqual(await read(nested), [99]);
    assert.deepEqual(await read(input), [10]);
    assert.deepEqual(await read(output), [43]);
    for (const [bad, code] of [
      [{ ...args(input), target: { ...args(input).target, runtimeId: 'missing' } }, 'TARGET_NOT_FOUND'],
      [{ ...args(input), target: { ...args(input).target, varName: 'wrong' } }, 'STALE_TARGET'],
      [{ ...args(input), expectedStructureToken: '0'.repeat(16) }, 'STALE_STRUCTURE'],
      [{ ...args(input), scope: 'wrong_scope' }, 'RUNTIME_UNAVAILABLE'],
      [args(targets.find(b => b.varName.endsWith('_add_offset'))), 'UNSUPPORTED_CLASS'],
      [args(input, { selector: 'delete', atoms: [] }), 'UNSUPPORTED_MESSAGE'],
      [args(input, { selector: 'set', atoms: ['not-a-number'] }), 'INVALID_ARGUMENT'],
      [args(input, { selector: 'float', atoms: [null] }), 'INVALID_ARGUMENT'],
    ]) {
      const action = bad.message ? 'maxforge_send_message' : 'maxforge_read_runtime';
      await rejects(action, bad, code);
    }
  }
  const after = await call('maxforge_inspect_patch', { ...route, detail: 'full' });
  assert.equal(after.structureToken, inspection.structureToken);
  assert.equal(after.revision, inspection.revision);
  const preview = await call('maxforge_prepare_change', { ...route, expectedStructureToken: after.structureToken, desiredDsl: source });
  assert(preview.canApply);
  assert.equal(preview.operationCount, 0, 'Runtime values changed DSL');
  const evidence = { version: targetPatch.externalVersion, revision: after.revision,
    instanceId: targetPatch.instanceId, source, operationCount: preview.operationCount };
  if (phase === 'reopen') {
    const saved = JSON.parse(await readFile(join(root, 'managed.json'), 'utf8'));
    assert.equal(after.revision, saved.revision);
    assert.notEqual(targetPatch.instanceId, saved.instanceId);
    await rejects('maxforge_send_message', { ...args(input, { selector: 'int', atoms: [999] }), instanceId: saved.instanceId }, 'RUNTIME_UNAVAILABLE');
    await call('maxforge_send_message', args(input, { selector: 'int', atoms: [50] }));
    assert.deepEqual(await read(output), [51]);
  }
  const saved = await call('maxforge_save_patch', { ...route, path: join(root, 'managed-a.maxpat'), overwrite: phase === 'reopen' });
  assert.equal(saved.saved.dirty, false);
  await writeFile(join(root, `${phase}.json`), JSON.stringify(evidence, null, 2));
  await call('maxforge_close_patch', route);
  console.log(`PASS: ${phase}, downstream output/set, nested identity, structured errors, unchanged DSL, save/close`);
}
