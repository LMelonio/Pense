"""Páginas e figuras das provas em PDF (precisa de: pip install pymupdf pillow).

Ver uma página (gera PNG com grade de 10% para medir o recorte):
  python scripts/figura.py pagina conteudo/provas/2023_PV_impresso_D2_CD5.pdf 12 tmp/pag12.png
Recortar uma figura (x0 y0 x1 y1 em fração da página, 0 a 1, medidos na grade):
  python scripts/figura.py recortar conteudo/provas/2023_PV_impresso_D2_CD5.pdf 12 0.52 0.10 0.95 0.38 public/imagens/2023/D2/q141_fig1.webp
"""
import sys, os
import pymupdf as fitz
from PIL import Image, ImageDraw

def pagina(pdf, n, saida):
    p = fitz.open(pdf)[int(n) - 1]
    pix = p.get_pixmap(dpi=110)
    img = Image.frombytes('RGB', (pix.width, pix.height), pix.samples)
    d = ImageDraw.Draw(img)
    for i in range(1, 10):
        x, y = img.width * i / 10, img.height * i / 10
        d.line([(x, 0), (x, img.height)], fill=(255, 0, 0), width=1)
        d.line([(0, y), (img.width, y)], fill=(255, 0, 0), width=1)
        d.text((x + 2, 2), f'{i/10:.1f}', fill=(255, 0, 0))
        d.text((2, y + 2), f'{i/10:.1f}', fill=(255, 0, 0))
    os.makedirs(os.path.dirname(saida) or '.', exist_ok=True)
    img.save(saida)
    print(f'{saida}: página {n} de {len(p.parent)}')

def recortar(pdf, n, x0, y0, x1, y1, saida, largura_max=1000):
    p = fitz.open(pdf)[int(n) - 1]
    r = p.rect
    clip = fitz.Rect(r.x0 + r.width * float(x0), r.y0 + r.height * float(y0), r.x0 + r.width * float(x1), r.y0 + r.height * float(y1))
    pix = p.get_pixmap(dpi=200, clip=clip)
    img = Image.frombytes('RGB', (pix.width, pix.height), pix.samples)
    if img.width > largura_max:
        img = img.resize((largura_max, round(img.height * largura_max / img.width)), Image.LANCZOS)
    os.makedirs(os.path.dirname(saida) or '.', exist_ok=True)
    img.save(saida, 'WEBP', quality=80)
    print(f'{saida}: {img.width}x{img.height}, {os.path.getsize(saida) // 1024} KB')

if __name__ == '__main__':
    acao, *a = sys.argv[1:]
    {'pagina': pagina, 'recortar': recortar}[acao](*a)
