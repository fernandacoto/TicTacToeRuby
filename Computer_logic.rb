class Logica_Computadora
  $solucion_encontrada
  $simbolo_utilizando
  $simbolo_encontrado
  $fila
  $columna
  $cantidad_casillas_ocupadas
  $movida
  $iteraciones_de_busqueda

  def initialize
    $fila = 0
    $columna = 0
    $simbolo_utilizando = "O"
    $movida = []
  end

  def iniciar_movida_computadora(tablero, cantidad_casillas_ocupadas)
    $fila = 0
    $columna = 0
    $cantidad_casillas_ocupadas = cantidad_casillas_ocupadas
    movida_aleatoria?(tablero)
    return $movida
  end

  def movida_aleatoria?(tablero)
    if $cantidad_casillas_ocupadas < 3 
      encontrar_fila_vacia(tablero)
    else
      elegir_jugada(tablero)
    end
  end

  def elegir_jugada(tablero)
    encontrar_fila_vacia(tablero)
    hay_solucion?(tablero)
    return $movida
  end

  def hay_solucion?(tablero)
    if $solucion_encontrada 
      return $movida
    else
      verificar_posibilidad_gane_usuario(tablero)
    end
  end

  def verificar_posibilidad_gane_usuario(tablero)
    $simbolo_utilizando = "X"
    $solucion_encontrada = false
    $solucion_encontrada = buscar_opciones_gane_usuario(tablero)
    marcar_o_buscar?(tablero)
  end

  def marcar_o_buscar?(tablero)
    if $solucion_encontrada 
      return $movida
    else
      chequear_movimiento_acertado(tablero)
    end
  end

  def chequear_movimiento_acertado(tablero)
    if !$solucion_encontrada
      $fila = 0
      $columna = 0
      $simbolo_utilizando = " "
      $simbolo_encontrado = false
      iniciar_primer_movimiento(tablero)
    end
  end

  def buscar_opciones_gane_usuario(tablero)
    iteraciones = repetir_busqueda_solucion
    iteraciones.times do
      encontrar_fila(tablero)
      revisar_tablero_usuario(tablero)
    end
    return $solucion_encontrada
  end

  def repetir_busqueda_solucion
    cantidad_casillas_ocupadas = $cantidad_casillas_ocupadas % 2
    if cantidad_casillas_ocupadas.even?
      return cantidad_casillas_ocupadas
    else
      return (($cantidad_casillas_ocupadas - 1) / 2) + 1
    end
  end

  def revisar_tablero_usuario(tablero)
    revisar_filas(tablero)
    revisar_columnas(tablero)
    revisar_diagonales(tablero)
  end

  def revisar_diagonales(tablero)
    if !$solucion_encontrada and tablero[1][1].eql?$simbolo_utilizando
      $fila = 1
      $columna = 1
      comparar_casillas(tablero,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparar_casillas(tablero,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def encontrar_fila_vacia(tablero)
    $simbolo_encontrado = false
    if $cantidad_casillas_ocupadas < 2
      iniciar_primer_movimiento(tablero)
    else
      iniciar_proximo_movimiento(tablero)
    end
  end

  def iniciar_primer_movimiento(tablero)
    if tablero[1][1].eql? " "
      2.times do $movida.push(1) end
    else
      buscar_movida(tablero)
    end
  end

  def buscar_movida(tablero)
    while !$simbolo_encontrado and  $fila < 3
      buscar_columna_vacia(tablero)
      if !$simbolo_encontrado 
        $fila += 1
        $columna = 0
      end
    end
  end

  def buscar_columna_vacia(tablero)
     $simbolo_utilizando = " "
     while !$simbolo_encontrado and $columna < 3
       if tablero[$fila][$columna].eql?$simbolo_utilizando
         $movida[0] = $fila
         $movida[1] = $columna
         $simbolo_encontrado = true
       else
         $columna += 1
       end
     end
  end

  def iniciar_proximo_movimiento(tablero)
    $simbolo_utilizando = "O"
    $iteraciones_de_busqueda = $cantidad_casillas_ocupadas / 2
    $iteraciones_de_busqueda.times do
      encontrar_fila(tablero)
      posibilidad_de_ganar(tablero)
    end
  end
  
  def encontrar_fila(tablero)
    $simbolo_encontrado = false
    while !$simbolo_encontrado and $fila < 3
      encontrar_columna(tablero)
      if !$simbolo_encontrado
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

  def revisar_filas_vacias(tablero)
    if $fila.eql?0
      seleccionar_casillas_desocupadas(tablero,$fila + 1, $columna, $fila + 2, $columna)
    else
      if $fila.eql?1
        seleccionar_casillas_desocupadas(tablero,$fila + 1, $columna, $fila - 1, $columna)
      else
        if $fila.eql?2
          seleccionar_casillas_desocupadas(tablero,$fila - 1, $columna, $fila - 2, $columna)
        end
      end
    end
  end

  def revisar_columnas_vacias(tablero)
    if $columna.eql?0
      seleccionar_casillas_desocupadas(tablero,$fila,$columna + 1, $fila,$columna + 2)
    else
      if $columna.eql?1
        seleccionar_casillas_desocupadas(tablero,$fila,$columna + 1, $fila,$columna - 1)
      else
        if $columna.eql?2
          seleccionar_casillas_desocupadas(tablero,$fila,$columna - 1, $fila,$columna - 2)
        end
      end
    end
  end

  def seleccionar_casillas_desocupadas(tablero,fila1,columna1,fila2,columna2)
    if !solucion_encontrada
      if tablero[fila1][columna1].eql?" " and tablero[fila2][columna2].eql?" "
        $solucion_encontrada = true
        $movida[0]=fila1
        $movida[1]=columna1
      end
    end
  end

  def posibilidad_de_ganar(tablero)
    $solucion_encontrada = false
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
    else
      if $fila.eql?1
        comparar_casillas(tablero,$fila + 1, $columna, $fila - 1, $columna)
      else
        if $fila.eql?2
          comparar_casillas(tablero,$fila - 1, $columna, $fila - 2, $columna)
        end
      end
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

  def comparar_casillas(tablero,fila1,columna1,fila2,columna2) # hacer mas pequeno
    if !$solucion_encontrada and fila1 < 3 and fila2 < 3
      if tablero[fila1][columna1].eql?$simbolo_utilizando and tablero[fila2][columna2].eql?" "
        $solucion_encontrada = true
        $movida[0]=fila2
        $movida[1]=columna2
      else 
        if tablero[fila1][columna1].eql?" " and tablero[fila2][columna2].eql?$simbolo_utilizando
        $solucion_encontrada = true
        $movida[0]=fila1
        $movida[1]=columna1
        else 
          $solucion_encontrada = false
        end
      end
    end
    return $solucion_encontrada
  end

end
