class Logica_Ganador
  $solucion
  $simbolo
  $simbolo_encontrado
  $fila
  $columna
  $movimientos

  def initialize
    $fila = 0
    $columna = 0
  end

  def iteraciones_de_busqueda(arreglo)
    iteraciones = $movimientos % 2
    if !iteraciones.even?
      iteraciones -= 1
      iteraciones = (iteraciones / 2) + 1
    end
    iteraciones.times do
      encontrar_fila(arreglo)
      revisar_gato(arreglo)
    end
  end

  def ganador(arreglo,jugador,movimientos)
    $movimientos = movimientos
    $fila = 0
    $columna = 0 # extaer el if en un metodo aparte
    if jugador == 1
      $simbolo = "X"
    else
      $simbolo = "O"
    end
    iteraciones_de_busqueda(arreglo)
    if $solucion == true # extraer en metodo aparte
      return $solucion
    else
      return false
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
      if arreglo[$fila][$columna] == $simbolo
        $simbolo_encontrado = true
      else
        $columna += 1
      end
    end
  end

  def revisar_gato(arreglo)
    $solucion = false
    revisar_filas(arreglo)
    revisar_columnas(arreglo)
    if $solucion == false && arreglo[1][1] == $simbolo
      $fila = 1
      $columna = 1
      comparacion(arreglo,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparacion(arreglo,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def revisar_filas(arreglo) # elseif
    if $fila == 0
      comparacion(arreglo,$fila + 1, $columna, $fila + 2, $columna)
    end
    if $fila == 1
      comparacion(arreglo,$fila + 1, $columna, $fila - 1, $columna)
    end
    if $fila == 2
      comparacion(arreglo,$fila - 1, $columna, $fila - 2, $columna)
    end
  end

  def revisar_columnas(arreglo) # elseif
    if $columna == 0
      comparacion(arreglo,$fila,$columna + 1, $fila,$columna + 2)
    end
    if $columna == 1
      comparacion(arreglo,$fila,$columna + 1, $fila,$columna - 1)
    end
    if $columna == 2
      comparacion(arreglo,$fila,$columna - 1, $fila,$columna - 2)
    end
  end

  def comparacion(arreglo,fila1,columna1,fila2,columna2)
    if arreglo[fila1][columna1] == $simbolo && arreglo[fila2][columna2] == $simbolo
      $solucion = true
    end
  end
end
#prueba = Logica_Ganador.new()
#prueba.pru
