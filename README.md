# PL
El simulador permitirá configurar y jugar partidas de este conocido juego de cartas. El objetivo es validar las reglas básicas del juego y simular una partida completa, dando al final el ganador.

El análisis léxico estaría compuesto por estos tokens:

    CARTA: con su respectivo número y palo
    JUGADOR: identificador de cada jugador
    REGLA: condiciones de la partida, como límite de puntos o cartas.
    ACCIÓN: que es posible hacer en cada turno, por ejemplo: coger carta del mazo, descartar, cerrar o hacer chinchón.

Una aproximación a la posible gramática consiste en:

    PARTIDA -> CONFIGURACION

    CONFIGURACION -> JUGADORES REGLAS MAZO

    TURNO -> JUGADOR ACCION ESTADO_PARTIDA

    ACCION -> ROBAR | DESCARTAR | CERRAR | CHINCHON

    ESTADO_PARTIDA -> MANO JUGADOR MAZO DESCARTES

    RONDA -> CIERRE PUNTUACION

Los errores a tener en cuenta serían:

    Reglas inconsistentes, como que el límite de cartas sea 5 y a la vez, permitir chinchón que necesitaría 7.
    Acciones inválidas, como coger carta del mazo cuando está vacío, o hacer chinchón sin una combinación de cartas válida.
    Errores de configuración inicial con reglas mal definidas.

La salida consistirá en un archivo con el desarrollo completo de la partida en cada ronda. Además, por consola se va informando en cada turno de las posibles jugadas, los errores en caso de producirse y el estado de la partida tras cada ronda.