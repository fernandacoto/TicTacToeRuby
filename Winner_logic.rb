class Logica_Ganador
  $solucion_encontrada
  $simbolo_utilizando
  $simbolo_encontrado
  $fila
  $columna
  $cantidad_movidas
  $primer_jugador

  def initialize
    $fila = 0
    $columna = 0
    $primer_jugador = 1
  end

  def iniciar_buscar_ganador(tablero,jugador,movidas)
    $cantidad_movidas = movidas
    $fila = 0
    $columna = 0 
    seleccionar_jugador(jugador)
    iteraciones_de_busqueda(tablero)
    revisar_solucion
  end

  def seleccionar_jugador(jugador)
    if jugador == $primer_jugador
      $simbolo_utilizando = "X"
    else
      $simbolo_utilizando = "O"
    end
  end

  def iteraciones_de_busqueda(tablero)
    $solucion_encontrada = false
    $simbolo_encontrado = false
    encontrar_columna(tablero)
    revisar_tablero(tablero)
    if revisar_solucion == false
      $simbolo_encontrado = false
      $fila = 1
      $columna = 0
      encontrar_columna(tablero)
      if $simbolo_encontrado == true
        revisar_tablero(tablero)
      end
    end
    if revisar_solucion == false
        $simbolo_encontrado = false
        $fila = 2
        $columna = 0
        encontrar_columna(tablero)
        if $simbolo_encontrado == true
        revisar_tablero(tablero)
        end
    end 
  end


  def se_puede_revisar(tablero)
    if $simbolo_encontrado
      revisar_tablero(tablero)
    end
  end

  def encontrar_fila(tablero)
    $simbolo_encontrado = false
    while $simbolo_encontrado == false && $fila < 3
      encontrar_columna(tablero)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
  end

  def encontrar_columna(tablero)
    while !$simbolo_encontrado and $columna < 3
      if tablero[$fila][$columna].eql?$simbolo_utilizando
        $simbolo_encontrado = true
      else
        $columna += 1
      end
    end
  end

  def revisar_tablero(tablero)
    revisar_filas(tablero)
    revisar_columnas(tablero)
    if !$solucion_encontrada and tablero[1][1].eql?$simbolo_utilizando
      $fila = 1
      $columna = 1
      comparar_casillas(tablero,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparar_casillas(tablero,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def revisar_filas(tablero)
    if $fila.eql?0
      comparar_casillas(tablero,$fila + 1, $columna, $fila + 2, $columna)
    elsif $fila.eql?1
        comparar_casillas(tablero,$fila + 1, $columna, $fila - 1, $columna)
      elsif $fila.eql?2
          comparar_casillas(tablero,$fila - 1, $columna, $fila - 2, $columna)
    end
  end

  def revisar_columnas(tablero)
    if $columna.eql?0
      comparar_casillas(tablero,$fila,$columna + 1, $fila,$columna + 2)
    else
      if $columna.eql?1
        comparar_casillas(tablero,$fila,$columna + 1, $fila,$columna - 1)
      else
        if $columna.eql?2
          comparar_casillas(tablero,$fila,$columna - 1, $fila,$columna - 2)
        end
      end
    end
  end

  def comparar_casillas(tablero,fila1,columna1,fila2,columna2)
    if tablero[fila1][columna1] == $simbolo_utilizando && tablero[fila2][columna2] == $simbolo_utilizando
      $solucion_encontrada = true
    end
   return $solucion_encontrada
  end

  def revisar_solucion
    return $solucion_encontrada
  end
end
