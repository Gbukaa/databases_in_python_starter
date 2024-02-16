from lib.album import Album

"""
Constructs containing id, title, release_year, artist_id
"""
def test_constructs_with_info():
    album = Album(1, "Waterloo", 1974, 2)
    assert album.id == 1
    assert album.title == "Waterloo"
    assert album.release_year == 1974
    assert album.artist_id == 2

"""
We can compare two identical albums
And have them be equal
"""
def test_albums_are_equal():
    album1 = Album(1, "Waterloo", 1974, 2)
    album2 = Album(1, "Waterloo", 1974, 2)
    assert album1 == album2

def test_albums_format_nicely():
    album = Album(1, "Waterloo", 1974, 2)
    assert str(album) == "Album(1, Waterloo, 1974, 2)"
    # Try commenting out the `__repr__` method in lib/artist.py
    # And see what happens when you run this test again.    