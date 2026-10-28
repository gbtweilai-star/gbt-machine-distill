# machine_distill

**One capability bit from GBT V8, packaged standalone.** No. 43 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **蒸馏件**（不是外挂）：把吞入件 AirsupHQ/machine-skill（MIT · 91星 · three.js · 无构建步）的**取法**提炼成我们自己的**求解器驱动可视化判据**：①每帧真解不查表（Brayton/火箭室/Cp(λ,β)/Darcy… 每台机器自带小求解器，画面每个数当帧解出来，还能给人看方程）②确定性时钟（?film=1，录制可复现：同输入同片）③坏也是算出来的（切掉再生冷却 ⇒ 铜喉熔；甩一片风扇叶片 ⇒ 求解器算机匣要扛的失衡载荷）④真量纲+真材质（米级真实比例 + 实测 reflectance，可信度不来自贴图）。op=source 现读胶囊尺寸+逐文件 sha256 · op=provenance 逐条指回原话（含**未蒸馏**两行：examples 作品与 record.mjs 引擎不取 · npx 安装不取）。**零作用域**。边界：与 diagram_distill **互补不重复** —— 一个管「画什么」（概念物化），一个管「数凭什么可信」（求解器）。op=method/source/provenance/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-machine-distill.git
cd gbt-machine-distill
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_machine_distill info                  # capability card
python -m gbt_machine_distill spec --json           # machine-readable contract
python -m gbt_machine_distill check --payload '{}'
python -m gbt_machine_distill run   --payload '{}'
```

Real `info` output from this machine:

```text
machine_distill  (creation)  v1.0.0
----------------------------------------
**蒸馏件**（不是外挂）：把吞入件 AirsupHQ/machine-skill（MIT · 91星 · three.js · 无构建步）的**取法**提炼成我们自己的**求解器驱动可视化判据**：①每帧真解不查表（Brayton/火箭室/Cp(λ,β)/Darcy… 每台机器自带小求解器，画面每个数当帧解出来，还能给人看方程）②确定性时钟（?film=1，录制可复现：同输入同片）③坏也是算出来的（切掉再生冷却 ⇒ 铜喉熔；甩一片风扇叶片 ⇒ 求解器算机匣要扛的失衡载荷）④真量纲+真材质（米级真实比例 + 实测 reflectance，可信度不来自贴图）。op=source 现读胶囊尺寸+逐文件 sha256 · op=provenance 逐条指回原话（含**未蒸馏**两行：examples 作品与 record.mjs 引擎不取 · npx 安装不取）。**零作用域**。边界：与 diagram_distill **互补不重复** —— 一个管「画什么」（概念物化），一个管「数凭什么可信」（求解器）。op=method/source/provenance/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : method, source, provenance, where
```

Wire a real implementation:

```python
from gbt_machine_distill import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（4 个）**：`method`、`source`、`provenance`、`where`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.11s
```

## Provenance

| field | value |
|---|---|
| capability | `machine_distill` |
| domain | `creation` |
| handler | `machine_distill` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [creation/machine_distill](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/machine_distill.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
