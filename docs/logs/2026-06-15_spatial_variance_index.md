# Spatial Variance Index

This is a corpus index for not-fully-decoded regions in the decoded OP-XY project image.

## Corpus

| Item | Count |
| --- | ---: |
| Source roots | `/Users/kevinmorrill/Documents/xy-format/src, /Users/kevinmorrill/Documents/xy-format/output` |
| `.xy` files seen | `920` |
| `.xy` files decoded | `920` |
| Track structs observed | `29493` |
| Sample-slot observations | `199512` |
| Decode errors | `0` |

## Region Summary

| Region | Scope | Range | Len | Obs | Unique | Var bytes | Zero obs | Priority |
| --- | --- | --- | ---: | ---: | ---: | ---: | ---: | --- |
| `global.pre_scene_cluster` | global | `0x0008..0x0054` | 77 | 920 | 22 | 46 (59.7%) | 0.0% | medium-structured-variance |
| `global.eq_gap` | global | `0x0065..0x0067` | 3 | 920 | 6 | 3 (100.0%) | 97.6% | medium-narrow-variance |
| `global.pre_scene_slab_gap` | global | `0x0074..0x0094` | 33 | 920 | 7 | 32 (97.0%) | 0.0% | medium-narrow-variance |
| `track.low_preset_state` | track | `0x0026..0x029F` | 634 | 29493 | 16 | 26 (4.1%) | 0.0% | medium-narrow-variance |
| `track.post_plock_value_gap` | track | `0x17A0..0x2C4D` | 5294 | 29493 | 3 | 10 (0.2%) | 100.0% | low-mostly-zero |
| `track.plock_activation_slab` | track | `0x2C4E..0x304D` | 1024 | 29493 | 45 | 145 (14.2%) | 99.7% | medium-structured-variance |
| `track.post_plock_master_gap` | track | `0x304F..0x3056` | 8 | 29493 | 29 | 5 (62.5%) | 99.9% | medium-structured-variance |
| `track.preset_identity_prefix` | track | `0x3457..0x3856` | 1024 | 29493 | 20 | 181 (17.7%) | 99.9% | medium-narrow-variance |
| `track.m1_to_amp_gap` | track | `0x3867..0x3876` | 16 | 29493 | 24 | 16 (100.0%) | 53.0% | medium-structured-variance |
| `track.amp_to_filter_gap` | track | `0x3887..0x3896` | 16 | 29493 | 52 | 16 (100.0%) | 3.2% | medium-structured-variance |
| `track.filter_to_lfo_gap` | track | `0x38A7..0x38B6` | 16 | 29493 | 41 | 16 (100.0%) | 25.1% | medium-structured-variance |
| `track.lfo_to_filter_env_gap` | track | `0x38C7..0x38D6` | 16 | 29493 | 35 | 16 (100.0%) | 59.4% | medium-structured-variance |
| `track.post_filter_env_gap` | track | `0x38E7..0x38FF` | 25 | 29493 | 35 | 25 (100.0%) | 0.1% | medium-structured-variance |
| `track.mod_routing_matrix` | track | `0x3900..0x393B` | 60 | 29493 | 44 | 60 (100.0%) | 0.1% | medium-structured-variance |
| `track.pre_sample_gap` | track | `0x393C..0x3956` | 27 | 29493 | 32 | 27 (100.0%) | 71.9% | medium-structured-variance |
| `track.sample_table_pre_label` | track | `0x3957..0x453E` | 3048 | 8313 | 53 | 3048 (100.0%) | 0.1% | medium-structured-variance |
| `track.post_note_count_tail` | track | `0x4570..0x45D3` | 100 | 12350 | 23 | 100 (100.0%) | 94.9% | medium-structured-variance |
| `slot.byte_01` | slot | `0x0001..0x0001` | 1 | 199512 | 55 | 1 (100.0%) | 99.7% | medium-structured-variance |
| `slot.byte_04` | slot | `0x0004..0x0004` | 1 | 199512 | 49 | 1 (100.0%) | 99.6% | medium-structured-variance |
| `slot.bytes_05_06` | slot | `0x0005..0x0006` | 2 | 199512 | 137 | 2 (100.0%) | 46.2% | high-broad-variance |
| `slot.tail_68_7f` | slot | `0x0068..0x007F` | 24 | 191199 | 401 | 24 (100.0%) | 26.5% | high-broad-variance |

## Highest-Yield Regions

- `slot.tail_68_7f`: high-broad-variance, 401 unique bodies, 24/24 variable bytes. Speculation: Engine-dependent start/end/loop/gain/crossfade/length semantics.
- `slot.bytes_05_06`: high-broad-variance, 137 unique bodies, 2/2 variable bytes. Speculation: Need captures to identify which byte maps to which shift control.
- `slot.byte_01`: medium-structured-variance, 55 unique bodies, 1/1 variable bytes. Speculation: Candidate for low key, velocity low, slot enable, or alignment.
- `track.sample_table_pre_label`: medium-structured-variance, 53 unique bodies, 3048/3048 variable bytes. Speculation: Sample paths and many slot params live here; semantics vary across drum/sampler/multisampler.
- `track.amp_to_filter_gap`: medium-structured-variance, 52 unique bodies, 16/16 variable bytes. Speculation: Candidate for amp-envelope shift params, curves, velocity sensitivity mirror, engine volume.
- `slot.byte_04`: medium-structured-variance, 49 unique bodies, 1/1 variable bytes. Speculation: Candidate for velocity high, region enable, group, or loop flag.
- `track.plock_activation_slab`: medium-structured-variance, 45 unique bodies, 145/1024 variable bytes. Speculation: Remaining bytes probably parameter masks, current selection, or inactive lane flags.
- `track.mod_routing_matrix`: medium-structured-variance, 44 unique bodies, 60/60 variable bytes. Speculation: Need exact row/field names and signed amount encoding for every controller target.

## Top Variable Offsets By Region

### `global.pre_scene_cluster`

Global cluster before MIDI channels and scene records.

Speculation: Likely selected track/pattern, UI focus, edit mode, transport/project flags.

Observations: `920`; unique region bodies: `22`; variable bytes: `46` / `77`.

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x0040` | 4 | 894 | 0x01=890, 0x00=26, 0xFF=3, 0x04=1 |
| `+0x002E` | 4 | 16 | 0x00=904, 0xFF=8, 0x11=7, 0x01=1 |
| `+0x0044` | 4 | 12 | 0x00=908, 0xFF=9, 0x01=2, 0xFE=1 |
| `+0x0043` | 4 | 7 | 0x00=913, 0xFF=4, 0x01=2, 0x02=1 |
| `+0x0041` | 4 | 6 | 0x00=914, 0x01=4, 0x02=1, 0xFE=1 |
| `+0x0046` | 3 | 903 | 0x04=894, 0x00=17, 0xFF=9 |
| `+0x001C` | 3 | 897 | 0x11=894, 0x00=23, 0x01=3 |
| `+0x0042` | 3 | 893 | 0xFF=891, 0x00=27, 0x01=2 |
| `+0x003F` | 3 | 892 | 0xFF=890, 0x00=28, 0xFE=2 |
| `+0x0052` | 3 | 16 | 0x00=904, 0xFF=9, 0x01=7 |

### `global.eq_gap`

Three bytes between MIDI channel array and master EQ values.

Speculation: Could be transpose, key/scale, sync, or compact project flags.

Observations: `920`; unique region bodies: `6`; variable bytes: `3` / `3`.

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x0067` | 4 | 20 | 0x00=900, 0xFF=11, 0x19=8, 0x9A=1 |
| `+0x0066` | 4 | 13 | 0x00=907, 0x99=8, 0xFF=4, 0x19=1 |
| `+0x0065` | 3 | 15 | 0x00=905, 0x99=9, 0xFF=6 |

### `global.pre_scene_slab_gap`

Thirty-three bytes before the scene-record slab.

Speculation: Suspiciously one scene-record length; maybe live-selection alternate state or scene prologue.

Observations: `920`; unique region bodies: `7`; variable bytes: `32` / `33`.

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x0076` | 5 | 912 | 0x99=894, 0xFF=11, 0x00=8, 0x40=5, 0x9A=2 |
| `+0x007A` | 5 | 912 | 0x99=894, 0x40=12, 0x00=8, 0xFF=4, 0x9A=2 |
| `+0x008E` | 5 | 911 | 0xCC=894, 0x19=11, 0x00=9, 0x40=4, 0xCD=2 |
| `+0x007C` | 5 | 905 | 0x19=894, 0x00=15, 0xCD=8, 0x99=2, 0xCC=1 |
| `+0x0088` | 4 | 914 | 0x40=894, 0x99=11, 0x08=9, 0x00=6 |
| `+0x0077` | 4 | 908 | 0x99=896, 0x00=12, 0x40=8, 0xFF=4 |
| `+0x0075` | 4 | 907 | 0x9A=894, 0x00=13, 0xFF=11, 0x40=2 |
| `+0x008D` | 4 | 907 | 0xCD=894, 0x00=13, 0x99=11, 0x40=2 |
| `+0x007B` | 4 | 905 | 0x99=896, 0x00=15, 0x40=8, 0xCD=1 |
| `+0x0078` | 4 | 900 | 0x19=894, 0x00=20, 0xFF=4, 0x99=2 |

### `track.low_preset_state`

Opaque lower preset/track state copied by set_preset.

Speculation: Likely play mode, width, portamento, bend range, engine switches, routing defaults, UI mirrors.

Observations: `29493`; unique region bodies: `16`; variable bytes: `26` / `634`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x024F` | 6 | 15 | 0x00=29478, 0x7F=6, 0x40=4, 0x01=3, 0x3F=1 |
| `+0x024E` | 4 | 10 | 0x00=29483, 0xFF=8, 0xE8=1, 0x01=1 |
| `+0x0253` | 4 | 8 | 0x00=29485, 0x40=5, 0x08=2, 0x50=1 |
| `+0x0252` | 4 | 5 | 0x00=29488, 0x81=2, 0x88=2, 0xA3=1 |
| `+0x0251` | 3 | 6 | 0x00=29487, 0x40=3, 0x50=3 |
| `+0x0255` | 2 | 3 | 0x00=29490, 0x40=3 |
| `+0x0262` | 2 | 3 | 0x00=29490, 0xFF=3 |
| `+0x0263` | 2 | 3 | 0x00=29490, 0x7F=3 |
| `+0x0264` | 2 | 3 | 0x00=29490, 0xE8=3 |
| `+0x0265` | 2 | 3 | 0x00=29490, 0x03=3 |

### `track.post_plock_value_gap`

Large gap after p-lock value rows and before automation flags.

Speculation: Candidate for inactive automation buffers, UI mirrors, per-step metadata, or reserved capacity.

Observations: `29493`; unique region bodies: `3`; variable bytes: `10` / `5294`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x2C06` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C0E` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C16` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C1E` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C26` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C2E` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C36` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C3E` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2C46` | 3 | 5 | 0x00=29488, 0x01=4, 0x02=1 |
| `+0x2BFE` | 2 | 4 | 0x00=29489, 0x01=4 |

### `track.plock_activation_slab`

P-lock activation/mask slab; first byte every 8 bytes is known step-active flag.

Speculation: Remaining bytes probably parameter masks, current selection, or inactive lane flags.

Observations: `29493`; unique region bodies: `45`; variable bytes: `145` / `1024`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x2C57` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C5F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C67` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C6F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C77` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C7F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C87` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C8F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C97` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x2C9F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |

### `track.post_plock_master_gap`

Eight bytes after the p-lock master flag and before step components.

Speculation: Likely automation summary bytes or selected p-lock lane state.

Observations: `29493`; unique region bodies: `29`; variable bytes: `5` / `8`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x304F` | 11 | 20 | 0x00=29473, 0x0F=3, 0x01=3, 0x02=3, 0x04=3 |
| `+0x3050` | 10 | 12 | 0x00=29481, 0x01=4, 0xFF=1, 0x02=1, 0x04=1 |
| `+0x3052` | 5 | 4 | 0x00=29489, 0x01=1, 0x02=1, 0x04=1, 0x08=1 |
| `+0x3051` | 4 | 4 | 0x00=29489, 0x01=2, 0x03=1, 0x02=1 |
| `+0x3053` | 3 | 4 | 0x00=29489, 0x02=2, 0x01=2 |

### `track.preset_identity_prefix`

Start of major preset identity/sound-state donor-copy region.

Speculation: Likely preset-engine internal state, hidden params, modulation defaults, routing defaults, engine tails.

Observations: `29493`; unique region bodies: `20`; variable bytes: `181` / `1024`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x383A` | 8 | 12 | 0x00=29481, 0x3F=4, 0x4F=2, 0x62=2, 0xFF=1 |
| `+0x3851` | 7 | 9 | 0x00=29484, 0x70=4, 0x40=1, 0x4A=1, 0xFF=1 |
| `+0x3816` | 6 | 11 | 0x00=29482, 0x1C=4, 0x47=2, 0x64=2, 0x40=2 |
| `+0x3846` | 6 | 11 | 0x00=29482, 0x61=5, 0x3D=2, 0x19=2, 0x76=1 |
| `+0x383D` | 6 | 10 | 0x00=29483, 0x80=4, 0x2F=2, 0xEB=2, 0x7F=1 |
| `+0x3845` | 6 | 10 | 0x00=29483, 0x45=4, 0xBF=2, 0x99=2, 0x4D=1 |
| `+0x3835` | 6 | 9 | 0x00=29484, 0x11=4, 0xB8=2, 0x2E=1, 0xFF=1 |
| `+0x3836` | 6 | 9 | 0x00=29484, 0x66=4, 0x1E=2, 0x1F=1, 0x40=1 |
| `+0x3812` | 5 | 10 | 0x00=29483, 0x07=4, 0x1F=2, 0x34=2, 0x40=2 |
| `+0x3839` | 5 | 10 | 0x00=29483, 0xFF=4, 0x55=3, 0x8F=2, 0xAC=1 |

### `track.m1_to_amp_gap`

Gap between M1 params and amp ADSR.

Speculation: Candidate for M1 shift params 5-8, engine hidden params, or UI mirrors.

Observations: `29493`; unique region bodies: `24`; variable bytes: `16` / `16`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x386A` | 11 | 13825 | 0x00=15668, 0x40=8266, 0x1D=5548, 0x5A=4, 0x13=1 |
| `+0x3869` | 9 | 5563 | 0x00=23930, 0xC0=5548, 0x40=6, 0x37=4, 0x88=1 |
| `+0x3876` | 8 | 13827 | 0x00=15666, 0x40=8267, 0x20=5548, 0x55=4, 0x3E=4 |
| `+0x3872` | 7 | 13824 | 0x00=15669, 0x40=8269, 0x0C=5548, 0x3E=4, 0xE8=1 |
| `+0x386E` | 7 | 13821 | 0x00=15672, 0x40=8269, 0x02=5548, 0xFF=1, 0x68=1 |
| `+0x3871` | 7 | 5560 | 0x00=23933, 0xCC=5548, 0x40=5, 0x11=4, 0x03=1 |
| `+0x3874` | 7 | 11 | 0x00=29482, 0x40=4, 0x03=3, 0x1F=1, 0x55=1 |
| `+0x386D` | 6 | 5557 | 0x00=23936, 0xA2=5548, 0x40=6, 0x0C=1, 0xAC=1 |
| `+0x3875` | 6 | 15 | 0x00=29478, 0x55=4, 0x80=4, 0x40=3, 0xFF=3 |
| `+0x386F` | 5 | 21 | 0x00=29472, 0x40=16, 0xFF=3, 0x7F=1, 0x2E=1 |

### `track.amp_to_filter_gap`

Gap between amp ADSR and filter knob block.

Speculation: Candidate for amp-envelope shift params, curves, velocity sensitivity mirror, engine volume.

Observations: `29493`; unique region bodies: `52`; variable bytes: `16` / `16`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x3896` | 31 | 28539 | 0x59=6453, 0x61=5680, 0x64=2831, 0x47=2799, 0x27=2719 |
| `+0x3895` | 29 | 28527 | 0x99=6440, 0x45=2879, 0x46=2831, 0x44=2801, 0xAC=2799 |
| `+0x388D` | 15 | 2914 | 0x00=26579, 0x80=2880, 0x55=10, 0xFF=8, 0x84=4 |
| `+0x3892` | 14 | 28509 | 0x1F=13869, 0x40=6440, 0x34=2831, 0x35=2695, 0x7F=2654 |
| `+0x388E` | 14 | 2749 | 0x00=26744, 0x2F=2719, 0x55=8, 0x3F=4, 0x51=4 |
| `+0x3887` | 12 | 22092 | 0x55=16492, 0x00=7401, 0xFF=2882, 0xA9=2693, 0x7F=7 |
| `+0x388A` | 12 | 22089 | 0x15=16489, 0x00=7404, 0x3F=2881, 0x6A=2693, 0x55=11 |
| `+0x3889` | 11 | 22084 | 0x55=16499, 0x00=7409, 0xFF=2882, 0xAA=2693, 0xE8=3 |
| `+0x3891` | 9 | 22064 | 0xFF=16524, 0x00=7429, 0x79=2831, 0x55=2697, 0x8F=4 |
| `+0x3893` | 9 | 6460 | 0x00=23033, 0x9A=6440, 0x1F=7, 0xFF=4, 0x68=3 |

### `track.filter_to_lfo_gap`

Gap between filter knobs and LFO params.

Speculation: Candidate for filter shift params, filter mode tails, drive, Z-filter state.

Observations: `29493`; unique region bodies: `41`; variable bytes: `16` / `16`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x38B6` | 15 | 10927 | 0x00=18566, 0x1E=2831, 0x43=2719, 0x33=2695, 0x14=2665 |
| `+0x38B2` | 14 | 5432 | 0x00=24061, 0x57=2718, 0x0F=2692, 0xFF=7, 0x7F=4 |
| `+0x38B5` | 13 | 10926 | 0x00=18567, 0xB8=2831, 0xFE=2719, 0x33=2693, 0x7A=2666 |
| `+0x38A7` | 11 | 35 | 0x00=29458, 0xFF=7, 0x76=7, 0x2E=7, 0xF8=4 |
| `+0x38AE` | 10 | 22074 | 0x7F=22051, 0x00=7419, 0xFF=11, 0x60=5, 0x23=2 |
| `+0x38B1` | 10 | 5431 | 0x00=24062, 0xFF=2730, 0x5C=2692, 0x28=2, 0xAE=2 |
| `+0x38AA` | 10 | 2720 | 0x00=26773, 0x33=2691, 0x68=7, 0x3F=5, 0x40=5 |
| `+0x38A8` | 9 | 23 | 0x00=29470, 0xFF=11, 0x2E=3, 0x4F=3, 0x7F=2 |
| `+0x38AF` | 9 | 23 | 0x00=29470, 0xFF=8, 0x7F=7, 0xAA=3, 0x40=1 |
| `+0x38B3` | 9 | 17 | 0x00=29476, 0x7F=7, 0xBF=3, 0x55=2, 0xFF=1 |

### `track.lfo_to_filter_env_gap`

Gap between LFO params and filter envelope.

Speculation: Strong candidate for LFO hidden/shift params; captures point to shape near +0x38D3.

Observations: `29493`; unique region bodies: `35`; variable bytes: `16` / `16`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x38CA` | 13 | 26 | 0x00=29467, 0xBF=7, 0x1A=4, 0xFF=3, 0x3D=3 |
| `+0x38D6` | 12 | 11935 | 0x00=17558, 0x7F=6441, 0x2F=2811, 0x0F=2666, 0xFF=9 |
| `+0x38D2` | 11 | 6459 | 0x00=23034, 0x40=6441, 0xFF=5, 0x0B=4, 0x7A=2 |
| `+0x38CE` | 11 | 6454 | 0x00=23039, 0x19=6440, 0x7F=5, 0x74=2, 0x2A=1 |
| `+0x38C9` | 10 | 19 | 0x00=29474, 0xFF=4, 0xDF=4, 0xBF=3, 0x3F=2 |
| `+0x38D3` | 9 | 6450 | 0x00=23043, 0xFF=6440, 0xCD=3, 0x2F=2, 0x92=1 |
| `+0x38C7` | 9 | 23 | 0x00=29470, 0x4A=7, 0x3D=7, 0xBF=3, 0xFF=2 |
| `+0x38D1` | 9 | 16 | 0x00=29477, 0xFF=4, 0xE5=4, 0xDB=2, 0x2F=2 |
| `+0x38D5` | 8 | 11927 | 0x00=17566, 0xFF=11920, 0x2F=2, 0x5E=1, 0x99=1 |
| `+0x38CD` | 8 | 6452 | 0x00=23041, 0x99=6440, 0xFF=6, 0x9E=2, 0xAC=1 |

### `track.post_filter_env_gap`

Gap before modulation routing matrix.

Speculation: Candidate for modulation matrix header, pitchbend/velocity defaults, high-pass preamble.

Observations: `29493`; unique region bodies: `35`; variable bytes: `25` / `25`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x38FB` | 11 | 31 | 0x00=29462, 0x40=14, 0xFF=5, 0x9A=2, 0x6F=2 |
| `+0x38FD` | 11 | 15 | 0x00=29478, 0xFF=3, 0x99=2, 0x20=2, 0x60=2 |
| `+0x38FE` | 10 | 29434 | 0x60=29421, 0x00=59, 0x40=3, 0x7F=2, 0x59=2 |
| `+0x38E7` | 10 | 25 | 0x00=29468, 0x03=7, 0x5C=7, 0xCD=3, 0x73=2 |
| `+0x38FC` | 10 | 18 | 0x00=29475, 0xFF=4, 0x40=3, 0x3F=3, 0x99=2 |
| `+0x38F3` | 9 | 21 | 0x00=29472, 0x40=9, 0xFF=4, 0x2F=2, 0x3F=2 |
| `+0x38F0` | 9 | 10 | 0x00=29483, 0x69=2, 0x40=2, 0x79=1, 0x3F=1 |
| `+0x38FA` | 8 | 29438 | 0x40=29426, 0x00=55, 0x7F=3, 0xFF=3, 0x6F=2 |
| `+0x38F2` | 8 | 23564 | 0x40=23556, 0x00=5929, 0x6B=2, 0xFF=2, 0x4D=1 |
| `+0x38FF` | 8 | 23 | 0x00=29470, 0x40=7, 0x60=7, 0xFF=4, 0x2E=2 |

### `track.mod_routing_matrix`

Partly decoded modulation routing matrix.

Speculation: Need exact row/field names and signed amount encoding for every controller target.

Observations: `29493`; unique region bodies: `44`; variable bytes: `60` / `60`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x390E` | 15 | 22078 | 0x3F=13822, 0x00=7415, 0x55=2882, 0x77=2692, 0x40=2665 |
| `+0x3919` | 14 | 26745 | 0xFF=12753, 0xCC=5614, 0xDF=2883, 0xAD=2832, 0x00=2748 |
| `+0x391A` | 13 | 29447 | 0x7F=12749, 0x4C=5614, 0x67=5485, 0x1A=2883, 0x28=2692 |
| `+0x3916` | 13 | 22084 | 0x3F=16516, 0x00=7409, 0x41=2882, 0x40=2665, 0xFF=11 |
| `+0x3906` | 13 | 22075 | 0x3F=8268, 0x00=7418, 0x7F=5576, 0x6C=5497, 0x60=2719 |
| `+0x3915` | 13 | 19415 | 0xFF=16518, 0x00=10078, 0x46=2882, 0xF8=3, 0xCC=2 |
| `+0x3921` | 13 | 5732 | 0x00=23761, 0xE5=2885, 0xC2=2832, 0xFF=4, 0xDA=2 |
| `+0x393A` | 12 | 22079 | 0x3F=13864, 0x00=7414, 0x40=5547, 0x7F=2652, 0xFF=7 |
| `+0x3902` | 12 | 10930 | 0x00=18563, 0x70=5497, 0x18=2719, 0x28=2692, 0xFF=6 |
| `+0x3931` | 12 | 8226 | 0x00=21267, 0xAE=2832, 0xC6=2719, 0xAC=2665, 0x92=2 |

### `track.pre_sample_gap`

Gap before the sample/region table.

Speculation: Candidate for final preset performance flags, high-pass/filter tails, sampler-mode flags, table header.

Observations: `29493`; unique region bodies: `32`; variable bytes: `27` / `27`.

Top engines: 0x12=8412, 0x03=5658, 0x07=2835, 0x16=2721, 0x14=2696, 0x13=2666

Top labels: `bass/shoulder`=2875, `pluck/beach bum`=2830, `drum/boop`=2797, `drum/in phase`=2797, `strings/draemy`=2718

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x393F` | 13 | 5481 | 0x00=24012, 0x2D=2797, 0x4F=2652, 0x22=9, 0x3F=7 |
| `+0x3940` | 13 | 5478 | 0x00=24015, 0x1D=2797, 0xCB=2652, 0x56=9, 0x2D=7 |
| `+0x3954` | 13 | 2681 | 0x00=26812, 0x71=2652, 0xFF=14, 0x2F=3, 0x01=2 |
| `+0x3956` | 12 | 2680 | 0x00=26813, 0xEF=2652, 0xFF=13, 0x61=4, 0x01=2 |
| `+0x3955` | 12 | 2677 | 0x00=26816, 0x5C=2652, 0xFF=12, 0x73=3, 0x35=2 |
| `+0x394E` | 11 | 27 | 0x00=29466, 0xFF=16, 0x6F=3, 0x3C=1, 0x35=1 |
| `+0x3951` | 10 | 8278 | 0x00=21215, 0xFF=5616, 0x03=2652, 0x65=3, 0x3C=2 |
| `+0x394F` | 10 | 8277 | 0x00=21216, 0xFF=5615, 0x1E=2653, 0x6E=3, 0x60=1 |
| `+0x3947` | 10 | 8272 | 0x00=21221, 0xFF=5611, 0x4E=2652, 0x35=3, 0x66=1 |
| `+0x3953` | 10 | 2678 | 0x00=26815, 0x80=2652, 0xFF=14, 0x74=3, 0x3C=2 |

### `track.sample_table_pre_label`

Non-overlapping sample/region table area before preset label.

Speculation: Sample paths and many slot params live here; semantics vary across drum/sampler/multisampler.

Observations: `8313`; unique region bodies: `53`; variable bytes: `3048` / `3048`.

Top engines: 0x03=5658, 0x1E=2653, 0x02=2

Top labels: `drum/in phase`=2797, `drum/boop`=2796, `pad/bandpasser`=2652, `/`=6, `/boop`=2

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x3FDC` | 19 | 5632 | 0xF4=2801, 0xF9=2796, 0x00=2681, 0x3C=7, 0x01=3 |
| `+0x3CDC` | 19 | 5631 | 0xFF=2801, 0xF7=2796, 0x00=2682, 0x3C=8, 0x01=3 |
| `+0x41DC` | 19 | 5631 | 0xF8=2801, 0xFD=2796, 0x00=2682, 0x3C=7, 0x6F=3 |
| `+0x3E5C` | 19 | 5630 | 0xFD=2801, 0xFC=2796, 0x00=2683, 0x3C=7, 0x6F=3 |
| `+0x44DC` | 19 | 5628 | 0xFA=2801, 0xFE=2795, 0x00=2685, 0x3C=7, 0x6F=3 |
| `+0x3B7A` | 18 | 8295 | 0x6F=2800, 0x68=2793, 0x35=2652, 0x00=18, 0x63=9 |
| `+0x397C` | 18 | 8289 | 0x70=2797, 0x73=2784, 0x77=2654, 0x00=24, 0x6C=19 |
| `+0x3FF3` | 18 | 5646 | 0x61=5601, 0x00=2667, 0x63=9, 0x2F=7, 0x62=7 |
| `+0x3DDC` | 18 | 5630 | 0xFD=2801, 0xFE=2796, 0x00=2683, 0x3C=7, 0xFC=3 |
| `+0x40DC` | 18 | 5630 | 0xF6=2802, 0xFD=2796, 0x00=2683, 0x3C=7, 0x01=3 |

### `track.post_note_count_tail`

Opaque fixed-body tail after note count in pristine donor structs.

Speculation: Preserved by set_preset; may be firmware default state or reserved trailing fields.

Observations: `12350`; unique region bodies: `23`; variable bytes: `100` / `100`.

Top engines: 0x12=6021, 0x03=1054, 0x00=919, 0x05=919, 0x13=727, 0x1E=720

Top labels: `pluck/dielectric`=726, `pad/bandpasser`=719, `lead/gaussian`=717, `strings/draemy`=655, `drum/in phase`=639

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x4590` | 11 | 615 | 0x00=11735, 0x0F=600, 0x09=3, 0xF0=2, 0x80=2 |
| `+0x45A0` | 11 | 613 | 0x00=11737, 0x1B=600, 0xF0=2, 0xFA=2, 0x32=2 |
| `+0x458D` | 11 | 20 | 0x00=12330, 0xF0=4, 0x64=3, 0x07=3, 0xFF=3 |
| `+0x4595` | 11 | 18 | 0x00=12332, 0xA0=4, 0x58=3, 0xFF=3, 0x3E=2 |
| `+0x4599` | 11 | 17 | 0x00=12333, 0xF0=4, 0x64=3, 0x28=2, 0x0F=2 |
| `+0x45A1` | 11 | 15 | 0x00=12335, 0x80=4, 0xFF=2, 0x5C=2, 0x64=1 |
| `+0x4588` | 10 | 616 | 0x00=11734, 0x21=600, 0xF0=4, 0x39=3, 0x07=3 |
| `+0x4584` | 10 | 615 | 0x00=11735, 0x45=600, 0xF0=3, 0x3C=3, 0xFD=3 |
| `+0x459C` | 10 | 612 | 0x00=11738, 0x5C=600, 0xF0=2, 0xF1=2, 0xA0=2 |
| `+0x4581` | 10 | 21 | 0x00=12329, 0x07=5, 0xF0=4, 0x64=3, 0xFF=3 |

### `slot.byte_01`

Unknown sample-slot byte.

Speculation: Candidate for low key, velocity low, slot enable, or alignment.

Observations: `199512`; unique region bodies: `55`; variable bytes: `1` / `1`.

Top engines: 0x03=135792, 0x1E=63672, 0x02=48

Top labels: `drum/in phase`=67128, `drum/boop`=67104, `pad/bandpasser`=63648, `/`=144, `/boop`=48

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x01` | 55 | 641 | 0x00=198871, 0x3C=289, 0x70=73, 0x6E=50, 0xFF=49 |

### `slot.byte_04`

Unknown sample-slot byte.

Speculation: Candidate for velocity high, region enable, group, or loop flag.

Observations: `199512`; unique region bodies: `49`; variable bytes: `1` / `1`.

Top engines: 0x03=135792, 0x1E=63672, 0x02=48

Top labels: `drum/in phase`=67128, `drum/boop`=67104, `pad/bandpasser`=63648, `/`=144, `/boop`=48

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x04` | 49 | 832 | 0x00=198680, 0x01=263, 0x73=97, 0x3C=72, 0x6E=72 |

### `slot.bytes_05_06`

Provisional pan/fade/crossfade-adjacent signed bytes.

Speculation: Need captures to identify which byte maps to which shift control.

Observations: `199512`; unique region bodies: `137`; variable bytes: `2` / `2`.

Top engines: 0x03=135792, 0x1E=63672, 0x02=48

Top labels: `drum/in phase`=67128, `drum/boop`=67104, `pad/bandpasser`=63648, `/`=144, `/boop`=48

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x06` | 74 | 17530 | 0x00=181982, 0xF3=2811, 0x2B=2798, 0xD1=2798, 0x13=2798 |
| `+0x05` | 64 | 107128 | 0x00=92384, 0xFD=33605, 0xFF=13998, 0xFE=11206, 0xFC=11202 |

### `slot.tail_68_7f`

Sample-slot numeric tail, excluding voice 23 to avoid preset-label overlap.

Speculation: Engine-dependent start/end/loop/gain/crossfade/length semantics.

Observations: `191199`; unique region bodies: `401`; variable bytes: `24` / `24`.

Top engines: 0x03=130134, 0x1E=61019, 0x02=46

Top labels: `drum/in phase`=64331, `drum/boop`=64308, `pad/bandpasser`=60996, `/`=138, `/boop`=46

| Offset | Distinct values | Nonzero obs | Top values |
| --- | ---: | ---: | --- |
| `+0x68` | 57 | 33424 | 0x00=157775, 0x40=2800, 0x17=2798, 0x2A=2798, 0x3B=2798 |
| `+0x70` | 56 | 139796 | 0xFF=120592, 0x00=51403, 0x84=2798, 0x60=2798, 0x5A=2797 |
| `+0x7F` | 54 | 11269 | 0x00=179930, 0xFA=5304, 0xF7=2654, 0xF9=2654, 0xFF=283 |
| `+0x77` | 53 | 584 | 0x00=190615, 0xFF=338, 0x6F=73, 0x6E=25, 0x3C=23 |
| `+0x79` | 51 | 140013 | 0xFF=129210, 0x00=51186, 0xCD=2652, 0xCE=2652, 0xC7=2652 |
| `+0x69` | 50 | 33460 | 0x00=157739, 0x19=2798, 0x3F=2798, 0x45=2798, 0x1F=2798 |
| `+0x7C` | 50 | 11342 | 0x00=179857, 0x68=2655, 0x20=2653, 0x58=2652, 0xF8=2652 |
| `+0x7D` | 50 | 11264 | 0x00=179935, 0x67=2654, 0x90=2652, 0xF8=2652, 0xEA=2652 |
| `+0x76` | 49 | 11182 | 0x00=180017, 0x02=10608, 0xFF=358, 0x63=71, 0x6F=28 |
| `+0x7E` | 49 | 11165 | 0x00=180034, 0xE1=2652, 0xE0=2652, 0x0A=2652, 0x99=2652 |

## How To Use This

- High broad-variance regions are most useful for mining existing corpus structure.
- Low/fixed regions are better tested with surgical device captures, not broad corpus scans.
- Slot tail stats skip voice 23, because its nominal tail overlaps the preset label region.
- The report is an index of variance, not proof of semantics. Promote a byte only after paired captures or writer/device validation.
