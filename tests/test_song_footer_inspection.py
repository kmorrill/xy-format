from xy.image_writer import ImageProject
from xy.song_footer_inspection import inspect_song_footer


FIXTURE = "src/one-off-changes-from-default/unnamed 155.xy"
LOOP_OFF_FIXTURE = "src/one-off-changes-from-default/unnamed 154.xy"


def test_inspects_all_fourteen_song_slots() -> None:
    slots = inspect_song_footer(ImageProject.from_file(FIXTURE))

    assert len(slots) == 14
    assert slots[1].song == 2
    assert slots[1].scene_chain == (1, 2, 3)
    assert slots[1].loop
    assert slots[1].loop_raw == 0
    assert slots[1].reserved == 0


def test_reads_loop_byte_and_rewrites_any_of_fourteen_slots() -> None:
    loop_on = ImageProject.from_file(FIXTURE)
    loop_off = ImageProject.from_file(LOOP_OFF_FIXTURE)
    assert loop_on.get_song_chain(2) == ([0, 1, 2], True)
    assert loop_off.get_song_chain(2) == ([0, 1], False)

    loop_on.set_song_chain(14, [0, 1, 2], loop=True)
    reloaded = ImageProject.from_bytes(loop_on.to_bytes())
    assert reloaded.get_song_chain(2) == ([0, 1, 2], True)
    assert reloaded.get_song_chain(14) == ([0, 1, 2], True)
