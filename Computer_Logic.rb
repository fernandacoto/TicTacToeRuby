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
    if $cantidad_casillas_ocupadas < 3
      encontrar_fila_vacia(tablero)
    else
      elegir_jugada(tablero)
    end
    return $movida
  end

  def elegir_jugada(tablero)
    encontrar_fila_vacia(tablero)
    if $solucion_encontrada == true
      return $movida
    else
      verificar_posibilidad_gane_usuario(tablero)
    end
    return $movida
  end

  def verificar_posibilidad_gane_usuario(tablero)
    $simbolo_utilizando = "X"
    $solucion_encontrada = false
    $solucion_encontrada = buscar_opciones_gane_usuario(tablero)
    if $solucion_encontrada == true
      return $movida
    else
      chequear_movimiento_acertado(tablero)
    end
  end

  def chequear_movimiento_acertado(tablero)
    if $solucion_encontrada == false
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
    if $solucion_encontrada == false && tablero[1][1] == $simbolo_utilizando
      $fila = 1
      $columna = 1
      comparar_casillas(tablero,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparar_casillas(tablero,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def encontrar_fila_vacia(arreglo)
    $simbolo_encontrado = false
    if $cantidad_casillas_ocupadas < 2
      iniciar_primer_movimiento(arreglo)
    else
      iniciar_proximo_movimiento(arreglo)
    end
  end

  def iniciar_primer_movimiento(arreglo)
    if arreglo[1][1] == " "
      2.times do $movida.push(1) end
    else
      buscar_movida(arreglo)
    end
  end

  def buscar_movida(arreglo)
    while $simbolo_encontrado == false && $fila < 3
      buscar_columna_vacia(arreglo)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
  end

  def buscar_columna_vacia(arreglo)
     $simbolo_utilizando = " "
     while $simbolo_encontrado == false && $columna < 3
       if arreglo[$fila][$columna] == $simbolo_utilizando
         $movida[0] = $fila
         $movida[1] = $columna
         $simbolo_encontrado = true
       else
         $columna += 1
       end
     end
  end

  def iniciar_proximo_movimiento(arreglo)
    $simbolo_utilizando = "O"
    $iteraciones_de_busqueda = $cantidad_casillas_ocupadas / 2
    $iteraciones_de_busqueda.times do
      encontrar_fila(arreglo)
      posibilidad_de_ganar(arreglo)
    end
  end
  
  def encontrar_fila(arreglo)
    $simbolo_encontrado = false
    while $simbolo_encontrado == false && $fila < 3
      encontrar_columna(arreglo)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
  end

  def encontrar_columna(arreglo)
    while $simbolo_encontrado == false && $columna < 3
      if arreglo[$fila][$columna] == $simbolo_utilizando
        $simbolo_encontrado = true
      else
        $columna += 1
      end
    end
  end

  def revisar_filas_vacias(arreglo)
    if $fila == 0
      seleccionar_casillas_desocupadas(arreglo,$fila + 1, $columna, $fila + 2, $columna)
    else
      if $fila == 1
        seleccionar_casillas_desocupadas(arreglo,$fila + 1, $columna, $fila - 1, $columna)
      else
        if $fila == 2
          seleccionar_casillas_desocupadas(arreglo,$fila - 1, $columna, $fila - 2, $columna)
        end
      end
    end
  end

  def revisar_columnas_vacias(arreglo)
    if $columna == 0
      seleccionar_casillas_desocupadas(arreglo,$fila,$columna + 1, $fila,$columna + 2)
    else
      if $columna == 1
        seleccionar_casillas_desocupadas(arreglo,$fila,$columna + 1, $fila,$columna - 1)
      else
        if $columna == 2
          seleccionar_casillas_desocupadas(arreglo,$fila,$columna - 1, $fila,$columna - 2)
        end
      end
    end
  end

  def seleccionar_casillas_desocupadas(arreglo,fila1,columna1,fila2,columna2)
    if $solucion_encontrada == false
      if arreglo[fila1][columna1] == " " && arreglo[fila2][columna2] == " "
        $solucion_encontrada = true
        $movida[0]=fila1
        $movida[1]=columna1
      end
    end
  end

  def posibilidad_de_ganar(arreglo)
    $solucion_encontrada = false
    revisar_filas(arreglo)
    revisar_columnas(arreglo)
    if $solucion_encontrada == false && arreglo[1][1] == $simbolo_utilizando
      $fila = 1
      $columna = 1
      comparar_casillas(arreglo,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparar_casillas(arreglo,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def revisar_filas(arreglo)
    if $fila == 0
      comparar_casillas(arreglo,$fila + 1, $columna, $fila + 2, $columna)
    else
      if $fila == 1
        comparar_casillas(arreglo,$fila + 1, $columna, $fila - 1, $columna)
      else
        if $fila == 2
          comparar_casillas(arreglo,$fila - 1, $columna, $fila - 2, $columna)
        end
      end
    end
  end

  def revisar_columnas(arreglo)
    if $columna == 0
      comparar_casillas(arreglo,$fila,$columna + 1, $fila,$columna + 2)
    else
      if $columna == 1
        comparar_casillas(arreglo,$fila,$columna + 1, $fila,$columna - 1)
      else
        if $columna == 2
          comparar_casillas(arreglo,$fila,$columna - 1, $fila,$columna - 2)
        end
      end
    end
  end

  def comparar_casillas(arreglo,fila1,columna1,fila2,columna2)
    if $solucion_encontrada == false && fila1 < 3 && fila2 < 3
      if arreglo[fila1][columna1] == $simbolo_utilizando && arreglo[fila2][columna2] == " "
        $solucion_encontrada = true
        $movida[0]=fila2
        $movida[1]=columna2
      else 
        if arreglo[fila1][columna1] == " " && arreglo[fila2][columna2] == $simbolo_utilizando
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
