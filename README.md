# Proyecto: Estudio de Speedup y Eficiencia en un Sistema Multiprocesador

![Tarjeta BASYS 3 - Vista Superior](https://cdn11.bigcommerce.com/s-7gavg/images/stencil/1920w/products/106/6255/Basys3-Rev.C-obl-1000__14394.1749749725.png?c=2)

**Un proyecto final para el curso de Hardware Reconfigurable.**

Este repositorio contiene la implementación y el análisis de un sistema multi-procesador en un FPGA para estudiar el speedup, la eficiencia y los límites prácticos de la paralelización, demostrando la Ley de Amdahl.

## Objetivo

El objetivo principal es realizar un estudio del **speedup** y la **eficiencia** al implementar múltiples procesadores (cores) para completar una tarea específica.

Esperamos evidenciar la **Ley de Amdahl**, demostrando que añadir más hardware no mejora la eficiencia indefinidamente, sino que el rendimiento se ve limitado por la porción secuencial de la tarea.

---

## Contexto Teórico: La Ley de Amdahl

Esta ley, formulada por Gene Amdahl, es fundamental para entender el límite del rendimiento en la computación paralela.

En esencia, establece que la mejora máxima de rendimiento (speedup) que se puede obtener al añadir más procesadores está **limitada por la porción de código que no se puede paralelizar** (la parte secuencial).

Esto se conecta directamente con la **Ley de rendimientos decrecientes**: llega un punto en que añadir más recursos (cores) aporta un beneficio cada vez menor, ya que la eficiencia se ve frenada por ese cuello de botella secuencial.

---

## Implementación

### La Tarea

Se implementó una tarea básica de conteo:
1.  Leer un bloque de **256 valores** de la memoria.
2.  Dentro de estos valores, hay **93 números pares**.
3.  Cada procesador debe detectar y llevar un conteo de los números pares que procesa.
4.  Al usar múltiples cores, la carga de trabajo se divide, pero el resultado final (93) debe ser consistente.

### Arquitectura y Plataforma

* **Soft-Procesor:** Se utilizó el **[Jimmy 8-bit processor](https://github.com/kuashio/jimmy)**, un procesador softcore de 8 bits (2 address machine, arquitectura Harvard) proporcionado por el curso e implementado en Verilog.
* **Simulación Inicial:** Las pruebas de concepto se realizaron en **EDAPlayground**.
* **Implementación Física:** Se utilizó **Xilinx Vivado** para la síntesis e implementación.
* **Hardware:** Tarjeta **Digilent BASYS3**, que cuenta con un FPGA **Artix-7**.

Se implementaron y probaron configuraciones con **1, 2 y 4 cores** del procesador.

---

## Resultados y Análisis

Los resultados obtenidos al ejecutar la tarea en las diferentes configuraciones fueron los siguientes:

| Cores | Ciclos de Reloj | Speedup | Eficiencia |
| :---: | :-------------: | :-----: | :--------: |
| 1 | 81,664 | 100% | 100% |
| 2 | 44,032 | 185% | 93% |
| 4 | 24,320 | 336% | 84% |

**Análisis:**
Como muestra la tabla, al duplicar los cores (de 1 a 2), no obtuvimos un speedup del 200%, sino del 185%. De igual manera, al cuadruplicar (de 1 a 4), no llegamos al 400%, sino al 336%.

Esto **evidencia claramente la Ley de Amdahl**. La eficiencia (Speedup / N° Cores) disminuye a medida que añadimos más procesadores. Esto se debe a que siempre hay una parte del trabajo (como la inicialización, la gestión de memoria o la combinación final de resultados) que es secuencial y no puede ser paralelizada.

---

## Cómo Usar este Repositorio

### Prerequisitos
* [Xilinx Vivado 2023.2](https://www.xilinx.com/support/download.html)
* La tarjeta FPGA [Digilent BASYS3](https://digilent.com/shop/introductory-fpga-boards/)

### Pasos para Replicar
1.  Clona este repositorio: `git clone ...`
2.  Abre el proyecto en Vivado (ubicado en `.../ruta/al/proyecto.xpr`).
3.  En Vivado, ejecuta la **Síntesis** y la **Implementación**.
4.  Genera el **Bitstream**.
5.  Conecta la BASYS3 y usa el "Hardware Manager" de Vivado para programar el dispositivo con el bitstream generado.

### Visualización de Resultados

Una vez que el FPGA está programado, puedes interactuar con el sistema usando los botones de la tarjeta:



* ** Botón Central (BTN_C):** Presiona este botón para hacer un **RESET** del sistema e iniciar la tarea de conteo.
* ** Botón Arriba (BTN_U):** Presiona este botón para alternar la visualización. Controla un multiplexor que muestra uno de los dos resultados:
    * **Vista 1 (Conteo de Pares):** Los 4 **displays de 7 segmentos** mostrarán el conteo total de números pares encontrados (que debe ser `0093`).
    * **Vista 2 (Ciclos de Reloj):** Los **16 LEDs** de la tarjeta mostrarán los bits `[23:8]` del contador de ciclos (un número de 32 bits), que representa el tiempo total que le tomó al sistema completar la tarea.

---
## Demostración
   **[Playlist en Youtube](https://www.youtube.com/playlist?list=PLp0enpagyuzkXTCJPyjHd2cq7K81NropY)**
   
## Trabajo Futuro

Como una mejora a este proyecto, se podría considerar:
* Realizar un *upgrade* del procesador a 16 o 32 bits.
* Implementar más instrucciones para realizar tareas más complejas.
* Añadir una mayor cantidad de registros de propósito general.

---

## Autor

* Brayan Isaac Gómez Velásquez
