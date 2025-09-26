from PIL import Image
with Image.open("cat.jpg") as im:
    im = im.convert(mode="1", colors=2)
    im = im.resize((400, 400))
    px = im.load()
    for row in range(im.height):
        for col in range(im.width):
            print(1 if px[col, row] > 0 else 0, end='')
        print()
