# Proiect FPGA – Identificare Obstacole din Date LiDAR (Verilog) || 3D Object Detection From LiDAR Point Clouds

## Descriere generală

Acest proiect implementează un **sistem hardware descris în Verilog** pentru **identificarea obstacolelor din date LiDAR 3D**, folosind o reprezentare **Bird’s-Eye View (BEV)** și o **hartă de ocupație (occupancy grid)**.

Proiectul este realizat în scop **academic**, fiind destinat **simulării și sintezei în Vivado**, fără implementare pe o placă FPGA fizică. Designul este orientat pe procesare **streaming**, similar sistemelor reale utilizate în robotică și conducere autonomă.

---

## Obiectivul proiectului

Scopul proiectului este:
- procesarea punctelor LiDAR 3D în hardware,
- identificarea regiunilor care conțin obstacole,
- construirea unei hărți 2D de obstacole utilizabile ulterior în software.

---

## Fluxul de procesare

Pentru fiecare punct LiDAR de intrare `(x, y, z)`:

1. **Filtrare sol** – eliminarea punctelor cu înălțime mică
2. **Proiecție BEV** – maparea coordonatelor 3D într-o grilă 2D
3. **Hartă de ocupație** – marcarea celulelor ocupate
4. **Semnal obstacol** – indică detectarea unui obstacol

Fluxul logic este:<br>

LiDAR (x, y, z)<br>
&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
Filtru de sol (threshold)<br>
&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
Proiecție BEV<br>
&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
Occupancy Grid<br>
&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
Detectare obstacol



---

## Descrierea modulelor Verilog

### `lidar_top.v`
Modulul principal (top-level) care conectează toate componentele sistemului.

**Intrări:**
- `clk` – semnal de ceas
- `valid` – indică un punct LiDAR valid
- `x`, `y`, `z` – coordonate LiDAR (fixed-point)

**Ieșiri:**
- `obstacle` – semnal activ atunci când un obstacol este detectat

---

### `threshold_filter.v`
Modul de **filtrare a solului**.

- Punctele cu `z` sub un prag prestabilit sunt considerate sol
- Punctele peste prag sunt considerate obstacole

Aceasta este o metodă simplificată, dar realistă, utilizată frecvent în pipeline-uri LiDAR reale.

---

### `bev_mapper.v`
Modul de **proiecție Bird’s-Eye View**.

- Convertește coordonatele `(x, y)` în coordonate discrete `(gx, gy)`
- Spațiul este discretizat într-o grilă 2D
- Permite procesare hardware eficientă

---

### `occupancy_grid.v`
Implementează **harta de ocupație 2D**.

- Fiecare celulă reprezintă o zonă din spațiul real
- Dacă un punct de obstacol ajunge într-o celulă, aceasta este marcată ca ocupată
- Harta este stocată intern (memorie inferată – BRAM)

---

## Testbench și simulare

### `tb_lidar_top.v`

Testbench-ul:
- Simulează un **cadru LiDAR static**
- Trimite puncte de sol și puncte de obstacol
- Conține **două obstacole distincte**, de dimensiuni diferite
- Trimite punctele secvențial, un punct per ciclu de ceas

Testbench-ul joacă rolul unui **senzor LiDAR virtual**.

---

## Compatibilitate cu dataset-uri reale (ex: KITTI)

Designul hardware:
- NU încarcă direct fișiere `.bin` KITTI
- Este însă **compatibil la nivel de flux de date**

Într-un scenariu real:
1. Datele KITTI sunt citite în software (Python/C++)
2. Convertite în format fixed-point
3. Transmise punct cu punct către hardware

Proiectul implementează **etapa de preprocesare** întâlnită în majoritatea sistemelor moderne de detecție 3D.

---

## Ce face și ce NU face proiectul

### Face:
- Identifică regiuni cu obstacole
- Construiește o hartă BEV de ocupație
- Procesează date LiDAR în timp real (streaming)

### NU face:
- Clasificare de obiecte
- Detectare bounding box-uri 3D
- Tracking
- Machine Learning

Aceste funcționalități pot fi adăugate ulterior, dar nu sunt necesare pentru scopul proiectului.

---

## Utilizare în Vivado

- Fișierele `.v` → **Design Sources**
- Testbench-ul → **Simulation Sources**
- Nu sunt necesare fișiere `.xdc`
- Proiectul poate fi:
  - Simulat
  - Sintetizat
  - Analizat din punct de vedere al resurselor

---

## Concluzie

Proiectul demonstrează:
- procesarea hardware a datelor LiDAR,
- utilizarea reprezentării Bird’s-Eye View,
- construcția unei hărți de obstacole în Verilog,
- un design streaming, realist și sintetizabil.

Reprezintă o bază solidă pentru sisteme de percepție în robotică și conducere autonomă și este potrivit ca **proiect academic FPGA**.

---

## Extensii posibile

- Resetare per cadru LiDAR
- Gruparea celulelor ocupate (clustering)
- Estimare bounding box-uri
- Integrarea unui accelerator neural

---

**Autor:**  
Proiect realizat în cadrul disciplinei Arhitectura Calculatoarelor || Ingineria Sistemelor
Realizat de Stresna George, Antonescu Cristian-Elisei, Popa-Galita Matei-Constantin
