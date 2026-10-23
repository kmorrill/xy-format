"""Build the manually audited exporter crosswalk; no device or repo core writes."""
from pathlib import Path
import json
out=Path(__file__).parent
fields=[]
def field(path,ram=None,wire=None,encoding='q31_high16',condition='always',evidence=None,**kw):
 fields.append(dict(path=path,ram_offset=ram,wire_offset=wire,encoding=encoding,condition=condition,evidence=evidence,**kw))
def param(path,i,encoding='q31_high16',condition='always',evidence=None):
 field(path,0x3864+4*i,0x3857+4*i,encoding,condition,evidence,parameter_id=i,bytes=4)
field('type',0x18,0x14,'engine_registry_name',evidence='0x8d4decde',bytes=4)
field('version',encoding='constant',value=4,evidence='0x8d4ded28')
field('platform',encoding='constant',value='OP-XY',evidence='0x8d4ded64')
field('octave',encoding='signed_byte',evidence='0x8d4dedb4 -> 0x8d56fcf0',global_ram_expression='0x40 + zero_based_track',global_wire_expression='0x3d + zero_based_track')
for i in range(8):param(f'engine.params[{i}]',i,evidence='0x8d4dee2e..0x8d4dee90')
for group,start,addr in [('amp',8,'0x8d4defbc..0x8d4df0d0'),('filter',32,'0x8d4df166..0x8d4df26e')]:
 for i,name in enumerate(['attack','decay','sustain','release']):param(f'envelope.{group}.{name}',start+i,evidence=addr)
for i,name in [(12,'playmode'),(13,'portamento.amount'),(14,'bendrange'),(15,'volume')]:
 param('engine.'+name,i,'playmode_quantized_enum' if i==12 else 'q31_high16','engine_id != 29','0x8d4e05b0..0x8d4e0700')
for i in range(8):
 param(f'engine.cc[{i}].val',8+i if i<4 else 12+i,'signed_bit_extract_9bits_at_bit24','engine_id == 29','0x8d4df2c6..0x8d4df3bc')
 param(f'engine.cc[{i}].cc',12+i if i<4 else 16+i,'cc_number_quantized','engine_id == 29','0x8d4df3c8..0x8d4df4be')
for name,ram,wire,active,start,addr in [('fx',0x28,0x21,0x2c,16,'0x8d4df4c0..0x8d4df61a'),('lfo',0x20,0x1c,0x24,24,'0x8d4df61c..0x8d4df75e')]:
 field(name+'.type',ram,wire,'filter_types_registry_name' if name=='fx' else 'lfo_types_registry_name',evidence=addr,bytes=4)
 field(name+'.active',active,0x25 if name=='fx' else 0x20,'boolean',evidence=addr,bytes=1)
 for i in range(8):param(f'{name}.params[{i}]',start+i,evidence=addr)
for name,start in [('modwheel',42),('aftertouch',44),('pitchbend',46),('velocity',55)]:
 for j,member in enumerate(['target','amount']):param(f'engine.modulation.{name}.{member}',start+j,evidence='0x8d4df82a..0x8d4dfb54')
for i,name in [(48,'velocity.sensitivity'),(49,'portamento.type'),(50,'tuning.scale'),(51,'width'),(52,'transpose'),(53,'tuning.root'),(54,'highpass')]:
 param('engine.'+name,i,'transpose_quantized' if i==52 else 'q31_high16',evidence='0x8d4dfb58..0x8d4dfd9a')
field('engine.tuning[0..11]',0x5394,None,'packed_pitch_to_float','any of 12 raw words != 0','0x8d4dff40..0x8d4e0004',bytes=48,wire_expression='pattern.end - 96 + 4*i')
regions=[]
def region(path,off,bytes,encoding='integer',condition='all emitted regions',evidence=None,**kw):
 regions.append(dict(path='regions[].'+path,sample_offset=off,bytes=bytes,ram_expression=None if off is None else f'0x394c + 128*slot + {off}',wire_expression=None if off is None else f'0x393f + 128*slot + {off}',encoding=encoding,condition=condition,evidence=evidence,**kw))
region('sample',0x20,96,'NUL-terminated string',evidence='0x8d4e0042')
region('framecount',0,4,'u32',evidence='0x8d4e0076')
region('pitch.keycenter',0x18,1,'u8','engine_id in [2,30]','0x8d4e03f0')
region('pitch.keycenter',None,0,'constant','engine_id == 3','0x8d4e00ba',value=60)
region('transpose',0x18,1,'u8 minus 60','engine_id == 3','0x8d4e00f6')
region('tune',0x1c,1,'i8',evidence='0x8d4e0136 / 0x8d4e0430')
region('hikey',0x1a,1,'u8',evidence='0x8d4e0280')
region('playmode',0x1b,1,'low6bit enum: 0 gate,1 oneshot,2 group,3 loop; others oneshot','engine_id == 3','0x8d4e0168..0x8d4e0172')
region('pan',0x1e,1,'i8','engine_id == 3','0x8d4e01b4')
region('fade.in',0x14,4,'word when mode bit7=0 else 0','engine_id == 3','0x8d4e01ee..0x8d4e0200')
region('fade.out',0x14,4,'word when mode bit7=1 else 0','engine_id == 3','0x8d4e023a..0x8d4e024c')
region('loop.start',0xc,4,'integer','engine_id in [2,30]','0x8d4e0468')
region('loop.end',0x10,4,'integer','engine_id in [2,30]','0x8d4e04a0')
region('loop.crossfade',0x14,4,'fractional multiply raw*framecount, truncating','engine_id in [2,30]','0x8d4e04da..0x8d4e04e6',related_sample_offset=0)
region('loop.onrelease',0x1b,1,'bit7 boolean','engine_id in [2,30]','0x8d4e0516..0x8d4e052a')
region('loop.enabled',0x1b,1,'constant false','engine_id in [2,30] and bit6 set; otherwise omitted','0x8d4e054c..0x8d4e059a')
region('sample.start',4,4,'integer','raw word != 0','0x8d4e02a4 / 0x8d4e0398')
region('sample.end',8,4,'integer','raw word != 0xffffffff','0x8d4e02ac / 0x8d4e0358')
region('gain',0x1d,1,'i8','raw byte != 0','0x8d4e02b4 / 0x8d4e0318')
region('reverse',0x1f,1,'boolean',evidence='0x8d4e02ce')
engines={2:'sampler',3:'drum',6:'organ',7:'epiano',18:'prism',19:'hardsync',20:'dissolve',22:'axis',29:'midi',30:'multisampler',31:'wavetable',32:'simple'}
result=dict(firmware='OP-XY 1.1.21+0',firmware_sha256='acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86',exporter='0x8d4dec6c',wire_coordinate='virtual pattern origin, except explicitly global/dynamic fields',fields=fields,regions=regions,region_iteration=dict(slots=24,stride=128,engine_ids=[2,3,30],emit_if='NUL-terminated sample path nonempty',order='slot order, empty slots skipped',all_other_engines='regions array emitted empty'),omitted_parameter_ids=[36,37,38,39,40,41,57],omitted_sound_state=[{'ram_start':0x16,'wire_start':0x13,'bytes':1},{'ram_start':0x1c,'wire_start':0x18,'bytes':4},{'ram_start':0x30,'wire_start':0x26,'bytes':552},{'ram_start':0x454c,'wire_start':0x453f,'bytes':48},{'ram_start':0x53c4,'wire_expression':'pattern.end - 48','bytes':48}],other_omissions=['notes','p-lock cells and masks','step components','all performance vectors','sample+0x19','sample trailing path bytes after NUL','sampler pan +0x1e','name','lokey'],engine_registry=dict(initializer='0x8d4fe46c',runtime_table='0x846df650',stride=48,name_offset=16,registered_names=engines),lfo_registry=dict(initializer='0x8d5a35dc',runtime_table='0x86bd609c',entries=[{'id':i,'name':n} for i,n in [(0,'tremolo'),(1,'value'),(2,'random'),(3,'element'),(6,'duck'),(4,'x-x-x-x-'),(5,'x-x-x-x-')]]),filter_registry=dict(initializer='0x8d4fe67c',confirmed_names={9:'z lowpass',10:'svf',16:'ladder',17:'z hipass'},export_lookup='filter_types object by id, then type member'),conversion_helpers={'q31_high16':'0x8d4ddb86: signed raw >> 16; all58 words asserted nonnegative at export entry','transpose_quantized':'0x8d4ddb96: (((raw >> 8)*73) >> 23)-36','cc_number_quantized':'0x8d4ddbb0: (((raw >> 8)*129) >> 23)-1','signed_bit_extract_9bits_at_bit24':'0x8d4ddc32: shift raw right8, signed EXTRACT(offset16,width9); effective bit24, 9-bit extraction behavior needs Blackfin+ boundary qualification','playmode_quantized_enum':'0x8d4dec2a: (((raw >> 8)*3) >>23): 0 poly,1 mono,2 legato,other poly','packed_pitch_to_float':'0x8d5a903c: signed upper16 + unsigned low8*0.01 via ROM float helpers'},limitations=['Static trace, no device validation','JSON registry data itself not available as runtime populated JSON in loader image','Crossfade multiply uses Blackfin+ R2*R3(T); formula rounding/saturation requires target qualification','Export does not prove import reconstruction of omitted state'])
(out/'preset-export-schema.json').write_text(json.dumps(result,indent=2)+'\n')
(out/'preset-export-engine-table.json').write_text(json.dumps(result['engine_registry'],indent=2)+'\n')
print('fields',len(fields),'region field rows',len(regions))
